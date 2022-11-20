extends Node

var time:int
var tries:int = 0
var level_life:int
var life = [7,20,40,60,80] 

var level = 0
var last_selected = -1
var last_selected_box_id = -1
var columns:Array = [
	2,
	2,
	4,
	4,
	6
]
var descriptionLevel = [
	"EASY",
	"EASY",
	"INTERMEDIATE",
	"INTERMEDIATE",
	"HARD"
]
var colors_gui:Dictionary= {
	0: ["2EC1AC","3E978B","D2E603","EFF48E"],
	1: ["440055","2ad4ff","006680","2ad4ff"],
	2: ["22577A","38A3A5","57CC99","80ED99"],
	3: ["202040","202060","602080","B030B0"],
	4: ["E01171","AB0E86","59057B","0F0766"]
}

var Textures = [
	"res://Assets/LevelIcons/0.png",
	"res://Assets/LevelIcons/1.png",
	"res://Assets/LevelIcons/2.png",
	"res://Assets/LevelIcons/3.png",
	"res://Assets/LevelIcons/4.png"
]
var maxBoxesPerLevel:Dictionary = {
	0: 4,
	1: 8,
	2: 16,
	3: 24,
	4: 36,

}
var maxLevelFrom0 = 4
#var current_scene = null
var colors:Dictionary = {
	0: ["2EC1AC","D2E603"],
	1: ["440055","ab37c8","006680","2ad4ff"],
	2: ["252945","536c67","5500d4","0044aa",
	"d400aa","39cc6c","55ddff","a02c2c"],
	3: ["002b11","00d455","00d400ss","005544",
	"ff2a7f","892ca0","ccff00","a0892c",
	"aa0000","550000","00d4aa","280b17",
	"550044","5500d4","aa0044","252945"
	] ,
	4: ["48373e","c80071","50162d","f54d51","d35fbc","782167",
	"ff0000","7137c8","4400aa","212178","0000d4","a02c2c",
	"ccff00","00ccff","00ccff","008066","37c871","00ff00"
	] ,
	
	}

var charge = 5

func _ready():
	var root = get_tree().get_root()
	var level = 0
#	current_scene = root.get_child(root.get_child_count() - 1)
	
#func goto_scene(path,current_scene_path):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:

#	call_deferred("_deferred_goto_scene", path,current_scene_path)


#func _deferred_goto_scene(path,current_scene_path):
#	# It is now safe to remove the current scene
#	current_scene = ResourceLoader.load(current_scene_path)
#	current_scene.free()
#
#	# Load the new scene.
#	var s = ResourceLoader.load(path)
#
#	# Instance the new scene.
#	current_scene = s.instance()
#
#	# Add it to the active scene, as child of root.
#	get_tree().get_root().add_child(current_scene)
#
#	# Optionally, to make it compatible with the SceneTree.change_scene() API.
#	get_tree().set_current_scene(current_scene)
