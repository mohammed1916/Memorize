extends TextureButton

class_name ModulatingBox
	
#signal fin
#onready var button = $TextureButton
export var BoxID:int

var matchID:int
var color_box:Color
#var state:int 


#var id:int

export var level_controller_path:String
#var level_controller

#func _ready():
#	rect_pivot_offset = (rect_size * rect_scale) / 2
#	level_controller = get_node(level_controller_path)
#	connect("box_flip",self,"_on_TextureButton_pressed")
#	if BoxID == null:
#		BoxID = get_tree().get_nodes_in_group("Box").size()


#func _on_TextureButton_pressed(bid):
#	print("played")
#	$AnimationPlayer.play("TurnBox")
#	id = bid
	

#
#func _on_AnimationPlayer_animation_finished(anim_name):
#	if anim_name.name == "TurnBox":
#		call("matchIDmatch_box",id)
func playFlip():
#	printt("BoxScript playing Animation")
	$AnimationPlayer.play("TurnBox")
	
func changeColor(color):
#	printt("BoxScript color",color)
	self_modulate = Color(color)
	
#func set_disabled(val):
#	button.set_disabled(val)

#func _on_AnimationPlayer_animation_finished(anim_name):
#	emit_signal("fin")
