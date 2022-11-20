extends Node2D

export var levelBase_path : NodePath
var levelBase : Control

onready var admob = get_node("AdMob")
export var touchButtonPath:String
onready var touchButton = get_node("Control/Panel/ADDS")
#onready var player = get_node("Player")



# Called when the node enters the scene tree for the first time.
func _ready():
	$Pause.hide()
	levelBase = get_node(levelBase_path)
#	levelBase.hide()
	loadAds()
	
	
func loadAds() -> void:
	admob.load_banner()
	admob.move_banner(false)
	admob.show_banner()

	admob.load_rewarded_video()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ADDS_pressed():
#	touchButton.modulate = Color(100,100,100)
	
	if Globals.charge < 1:
		if(admob.is_rewarded_video_loaded()):
			admob.show_rewarded_video()
#			$Control/Panel/ADDS/VBoxCharge/Thunder/Charge.set_text(0)
	elif Globals.charge > 0:
		Globals.charge -=1
		$LevelBase/Level.showBoxColor()
		$Control/Panel/ADDS/VBoxCharge/Thunder/Charge.set_text(str(Globals.charge))
	if Globals.charge == 0:
		$Control/Panel/ADDS/show.set_text("Watch Add")
		

#func _on_ADDS_released():
#	touchButton.modulate = Color(100,10,0)


func _on_AdMob_banner_failed_to_load(error_code):
	print_debug("error",error_code)


func _on_AdMob_banner_loaded():
	print_debug("signal Ad Banner Loaded")


func _on_AdMob_rewarded(currency, ammount):
	Globals.charge += 5
	$Control/Panel/ADDS/VBoxCharge/Thunder/Charge.set_text(str(Globals.charge))
	admob.load_rewarded_video()



