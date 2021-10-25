extends Node2D


onready var admob = get_node("AdMob")
onready var touchButton = get_node("Control/ADDS")
onready var player = get_node("Player")



# Called when the node enters the scene tree for the first time.
func _ready():
	loadAds()
	
	
func loadAds() -> void:
	admob.load_banner()
	admob.show_banner()
	
	admob.load_interstitial()
	admob.load_rewarded_video()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ADDS_pressed():
	touchButton.modulate = Color(100,100,100)
	if(admob.is_rewarded_video_loaded()):
		admob.show_rewarded_video()

func _on_ADDS_released():
	touchButton.modulate = Color(100,10,0)


func _on_AdMob_banner_failed_to_load(error_code):
	print_debug("error",error_code)


func _on_AdMob_banner_loaded():
	print_debug("signal Ad Banner Loaded")


func _on_AdMob_rewarded(currency, ammount):
	player.life = player.life + currency
