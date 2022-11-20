extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Home_pressed():
	get_tree().change_scene("res://Scenes/GUI/Start/Start.tscn")
	get_tree().set_pause(false)


func _on_Retry_pressed():
	get_tree().change_scene("res://Scenes/GUI/Main/GUI.tscn")
	get_tree().set_pause(false)


func _on_Resume_pressed():
	hide()
	get_parent().get_node("LevelBase").show()
	get_parent().get_node("Control").show()
	get_tree().set_pause(false)
