extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	setTries()
	setTime()
	setLife()
	pass # Replace with function body.

func setTries():
	$Color/VBoxContainer/Tries.set_text("Tries : "+str(Globals.tries))
	
func setTime():
	$Color/VBoxContainer/Time.set_text("Time : "+str(Globals.time) + " sec")

func setLife():
	$Color/VBoxContainer/Life.set_text("Lives Left : "+ str(Globals.level_life))
