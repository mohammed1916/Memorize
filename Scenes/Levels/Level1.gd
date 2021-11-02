extends Control
signal box_flip(boxid)
#onready var boxtl = get_node("TopLeft")
#onready var boxtr = get_node("TopRight")
#onready var boxbl = get_node("BottomLeft")
#onready var boxbr = get_node("BottomRight")


enum boxStates {PRESSED, UNPRESSED, WAIT_FOR_MATCH, MATCHED}

export var ScorePath:String
var scoreLable:Label

export var GCPath: String 
var GC:GridContainer

#export var TLPath: String 
#var TL:TextureButton
#export var TRPath: String 
#var TR:TextureButton
#export var BLPath: String 
#var BL:TextureButton
#export var BRPath: String 
#var BR:TextureButton

# "RedShades" "BlueShades" "PurpleShades"
#"PurpleShades2"


export var StartMsgPath: String 
var StartLabel
var started = false

var timeSpan =.7
var score=0
var colors_current_game:Array

var boxes:Array
#var finished:Array

var last_selected = -1
var last_selected_box_id = -1

var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
#	rng.seed = rng.randf_range(-1, boxno)
	StartLabel = get_node(StartMsgPath)
	scoreLable = get_parent().get_parent().get_node(ScorePath)
#	TL= get_node(TLPath)
#	TR= get_node(TRPath)
#	BL= get_node(BLPath)
#	BR= get_node(BRPath)
	GC= get_node(GCPath)
	GC.columns = Globals.columns[Globals.level]
	var totalboxes = Globals.maxBoxesPerLevel.get(Globals.level)
	var halfboxes = totalboxes/2
	printt("totalboxes",totalboxes,"halfboxes",halfboxes)
	var rndno:int = floor(rng.randf_range(-1,totalboxes))
	
	var temp:Array
#	for i in totalboxes: 
#		Array.append
	for i in totalboxes:
		
		var box = preload("res://Scenes/Box/ModulatingBox.tscn").instance()
		if i >= (halfboxes):
			box.matchID = i - (halfboxes)
		else:
			 box.matchID =  i
		printt("box.matchID",box.matchID)
		colors_current_game.append(Globals.colors.get(Globals.level)[box.matchID] )
		box.color_box = colors_current_game[i]
#		box.self_modulate = Color("fff")
		box.self_modulate = box.color_box
		box.rect_pivot_offset = box.rect_size*box.rect_scale /2
		box.state = boxStates.UNPRESSED
		boxes.append(box)
	boxes.shuffle()
	printt("shuffle")
	var i=0
	for box in boxes:
		box.BoxID = i
		box.connect("pressed",self,"on_box_pressed",[box.BoxID])
		box.connect("fin",self,"on_animation_finished",[box.BoxID])
		printt("box.matchID",box.matchID,"box.BoxID",box.BoxID)
		GC.add_child(box)
		i +=1
#	var screen_width = ProjectSettings.get_setting ("display/window/size/width")
#	var screen_height = ProjectSettings.get_setting ("display/window/size/height")
#
#	for box in get_children():
#		box.rect_size.x = screen_width / 2
#		box.rect_size.y = screen_height / 2
#		print(box.rect_size)



func randomSpawn(boxID):
#	for box in boxes:
#	if boxes[boxID].state == boxStates.PRESSED:
#	emit_signal("box_flip",boxID)
#		yield(get_tree().create_timer(timeSpan),"timeout")
#		boxes[boxID].playAnimation()
#		boxes[boxID].changeColor(boxes[boxID].color_box)
	#			box.show()
		
	match_box(boxID)
	updateScore()
	#	updateTimer()

			
func _process(delta):
#	randomSpawn(delta)
	pass
func match_box(boxID):
	printt("-------------","-------------")
	printt(boxes[boxID].state )
	var is_matched = false
	if boxes[boxID].state == boxStates.MATCHED:
		printt("matched",boxID)
		pass
#	elif boxes[boxID].matchID == last_selected && boxID !=last_selected_box_id && last_selected_box_id != -1:
	elif boxes[boxID].state == boxStates.WAIT_FOR_MATCH:
		printt("boxStates.WAIT_FOR_MATCH",boxID)
		
#		for box in boxes:
#			if box.matchID == boxID:
#		yield(get_tree().create_timer(1),"timeout")

#		if (last_selected_box_id in finished):
#			pass
#		else:
#			finished.append(boxID)
#			finished.append(last_selected_box_id)
#		printt(finished)
		
#		is_matched = true
#		else:
		printt("UNPRESSED ",boxID,last_selected_box_id)
		boxes[boxID].state = boxStates.UNPRESSED
		boxes[boxID].playFlip()
		boxes[boxID].changeColor("fff")
		
		boxes[last_selected_box_id].state = boxStates.UNPRESSED
		boxes[last_selected_box_id].playFlip()
		boxes[last_selected_box_id].changeColor("fff")
	else:
		if boxes[boxID].matchID == last_selected && boxID != last_selected_box_id:
			boxes[boxID].changeColor(0000)
			boxes[boxID].set_disabled(true)
			boxes[boxID].state = boxStates.MATCHED
			
			boxes[last_selected_box_id].changeColor(0000)
			boxes[last_selected_box_id].set_disabled(true)
			boxes[last_selected_box_id].state = boxStates.MATCHED
			
			is_matched =true
			printt("boxes[boxID].matchID",boxes[boxID].matchID,"last_selected",last_selected)
			printt("boxID",boxID,"last_selected_box_id",last_selected_box_id)
		else:
#		emit_signal("box_flip",boxID)
			last_selected = boxes[boxID].matchID
			last_selected_box_id = boxes[boxID].BoxID
			printt("else",last_selected,last_selected_box_id)
	#		playAnimation(boxes[boxID])
			boxes[boxID].playFlip()
			boxes[boxID].changeColor(boxes[boxID].color_box)
			boxes[boxID].state = boxStates.WAIT_FOR_MATCH
#		yield(get_tree().create_timer(1),"timeout")
#		playAnimation(boxes[boxID])
	if not is_matched && boxes[last_selected_box_id].state == boxStates.UNPRESSED:
#		for box in boxes:
		boxes[boxID].changeColor(0000)
		boxes[boxID].set_disabled(true)
		boxes[boxID].state = boxStates.MATCHED
		
		boxes[last_selected_box_id].changeColor(0000)
		boxes[last_selected_box_id].set_disabled(true)
		boxes[last_selected_box_id].state = boxStates.MATCHED
#		boxes[boxID].self_modulate = Color("fff")
		boxes[boxID].state = boxStates.UNPRESSED
		boxes[last_selected_box_id].state = boxStates.UNPRESSED
func boxDead(boxID):
#	boxes[boxID].self_modulate = Color("000")
#	boxes[boxID].hide()
#	boxes[boxID].state = boxStates.PRESSED
	randomSpawn(boxID)

func updateScore():
	score+=1	
	scoreLable.set_text(str(score))
	
func updateTimer():
	timeSpan -= clamp(.05,.5,1.5)

func changeColor(box):
	call_deferred(str(box),"self_modulate",Color("fff"))
	
#func playAnimation(obj):
#	call_deferred(str(obj.get_node("AnimationPlayer")) ,"play('TurnBox')")
func _preconditions():
	if !started:
		started = true
		StartLabel.hide()
		for box in boxes:
			box.self_modulate = Color("fff")
		return false
	return true
func on_box_pressed(boxID):
	if _preconditions():
#		if boxes[boxID].state == boxStates.UNPRESSED:
		boxDead(boxID)
func on_animation_finished(boxID):
#	printt("on_animation_finished")	
	pass
#	for bID in finished:
#		boxes[bID].self_modulate = Color(0000)
#	boxes[boxID].self_modulate = Color(0000)
#		boxes[boxID].set_disabled(true)
#	boxes[last_selected_box_id].self_modulate = Color(0000)
#	boxes[last_selected_box_id].set_disabled(true)

#TODO
#create NinePatchRect for box and score bg 
#update GC columns
#write random gen var to add to index of colors 
#wrie code for matching using current selected var 
#Add charge per level for use if not addvert 
#update rate 
#add retry to info 
#update taps score
