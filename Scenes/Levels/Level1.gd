extends Control

#onready var boxtl = get_node("TopLeft")
#onready var boxtr = get_node("TopRight")
#onready var boxbl = get_node("BottomLeft")
#onready var boxbr = get_node("BottomRight")




# Called when the node enters the scene tree for the first time.
func _ready():
	var screen_width = ProjectSettings.get_setting ("display/window/size/width")
	var screen_height = ProjectSettings.get_setting ("display/window/size/height")
	
	for box in get_children():
		box.rect_size.x = screen_width / 2
		box.rect_size.y = screen_height / 2
		print(box.rect_size)
	
