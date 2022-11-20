extends TextureButton

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Pause_pressed():
	get_tree().set_pause(true)
	get_parent().get_parent().get_parent().get_node("Control").hide()
	get_parent().get_parent().get_parent().get_node("LevelBase").hide()
	get_parent().get_parent().get_parent().get_node("Pause").show()
