extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var guiPath:String
var gui

var current_scene:String

onready var pl = get_node("MarginContainer/Control2/PrevLevel")
onready var nl = get_node("MarginContainer/Control3/NextLevel")

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.level =0
	pl.hide()
	current_scene  = get_tree().get_current_scene().get_name()
	gui = load(guiPath) 
	applyColors()
	updateTexture()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func applyColors():
	get_node("MarginContainer/Control/Bg").self_modulate = Globals.colors_gui.get(Globals.level)[2]
	get_node("MarginContainer/Control/Bg/Bg2").self_modulate = Globals.colors_gui.get(Globals.level)[3]
	get_node("MarginContainer/Control/Bg/Bg2/Bg3").self_modulate = Globals.colors_gui.get(Globals.level)[2]
	get_node("Control/VBoxContainer/TextureProgress").self_modulate = Globals.colors_gui.get(Globals.level)[1]
	get_node("Control/VBoxContainer/TextureRect").self_modulate = Globals.colors_gui.get(Globals.level)[0]
	get_node("TextureRect").self_modulate = Globals.colors_gui.get(Globals.level)[3]
	get_node("MarginContainer/Control/Bg/Bg2/Bg3/RichTextLabel").self_modulate = Color("fff")
	get_node("MarginContainer/Control/Bg/Bg2/Bg3/RichTextLabel").set_text(Globals.descriptionLevel[Globals.level])
	
	updateProgress()
	
func updateProgress():
	get_node("Control/VBoxContainer/TextureProgress").tint_under = Globals.colors_gui.get(Globals.level)[3]
	get_node("Control/VBoxContainer/TextureProgress").tint_progress = Globals.colors_gui.get(Globals.level)[1]
	get_node("Control/VBoxContainer/TextureProgress").value = (Globals.level) * 20

func _on_NextLevel_pressed():
#	print("pressed next")
	Globals.level = Globals.level + 1
	if Globals.level > 0 && ! pl.visible:
		pl.show()
	if Globals.level == Globals.maxLevelFrom0 && nl.visible:
		nl.hide()
#	if Globals.level == 0:
#		get_node("MarginContainer/Control2/PrevLevel").hide()
#	elif Globals.level < Globals.maxLevel-1 && get_node("MarginContainer/Control3/NextLevel").visible:
#		get_node("MarginContainer/Control3/NextLevel").show()
	
	applyColors()
	updateTexture()	


func _on_PrevLevel_pressed():
#	print("pressed prev")
#	if Globals.level == 0 && ! pl.visible:
#		pl.show()
#	elif Globals.level == Globals.maxLevel-1 && nl.visible:
#		nl.hide()
	Globals.level = Globals.level - 1 
	if Globals.level == 0:
		pl.hide()
	elif Globals.level < Globals.maxLevelFrom0 && ! get_node("MarginContainer/Control3/NextLevel").visible:
		nl.show()
	applyColors()
	updateTexture()


func _on_Bg_pressed():
	get_tree().change_scene(guiPath)
	
func updateTexture():
	get_node("MarginContainer/Control/Bg/Bg2/Bg3/LevelPic").texture_normal = load(Globals.Textures[Globals.level])
	get_node("MarginContainer/Control/Bg/Bg2/Bg3/LevelPic").texture_pressed = load(Globals.Textures[Globals.level])	


func _on_Home_pressed():
	get_tree().change_scene("res://Scenes/GUI/Start/Start.tscn")
	get_tree().set_pause(false)
