extends Node2D

#export var LevelSelectPath:String
#var LevelSelect

#func _ready():
#	LevelSelect = get_node(LevelSelectPath)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Play_pressed():
	get_tree().change_scene("res://Scenes/GUI/LevelSelect/LevelSelect.tscn")


func _on_Info_pressed():
	get_tree().change_scene("res://Scenes/GUI/Start/Info.tscn")
