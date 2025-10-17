extends Control
#signal box_flip(boxid)


#enum boxStates {PRESSED, UNPRESSED, WAIT_FOR_MATCH, MATCHED}

export var ScorePath:String
var scoreLable:Label

export var GCPath: String 
var GC:GridContainer


var correct_boxes_selected = 0

# "RedShades" "BlueShades" "PurpleShades"
#"PurpleShades2"


export var StartMsgPath: String 
var StartLabel

export var ChargeMsgPath: String 
var ChargeLabel

var started = false

var timeSpan = 1
var correctAnsTimer = Timer.new()
var wrongAnsTimer = Timer.new()
var timer = Timer.new()

var box1
var box2


var colors_current_game:Array

var boxes:Array
#var finished:Array

var last_selected_match_id = -1
var last_selected_box_id = -1

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
#	rng.seed = rng.randf_range(-1, boxno)
	initializeTimers()
	initailizeLife()
	setGlobals()

	GC= get_node(GCPath)
	GC.columns = Globals.columns[Globals.level]

	# var rndno:int = floor(rng.randf_range(-1,totalboxes))
	
	initializeBoxesArray()
	boxes.shuffle()	
	addBoxes()
func setGlobals():
	Globals.level_life = Globals.life[Globals.level]
	Globals.tries = 0
	Globals.charge = 5
	get_parent().get_parent().get_node("Control/Panel/ADDS/VBoxCharge/Thunder/Charge").set_text(str(Globals.charge))
func initailizeLife():
	Globals.level_life = Globals.maxBoxesPerLevel.get(Globals.level) - 1
	StartLabel = get_node(StartMsgPath)
	scoreLable = get_parent().get_parent().get_node(ScorePath)
func initializeBoxesArray():
	var totalboxes = Globals.maxBoxesPerLevel.get(Globals.level)
	var halfboxes = totalboxes/2
	# printt("totalboxes",totalboxes,"halfboxes",halfboxes)

	for i in totalboxes:
		
		var box = preload("res://Scenes/Box/ModulatingBox.tscn").instance()
		if i >= (halfboxes):
			box.matchID = i - (halfboxes)
		else:
			box.matchID =  i
		# printt("box.matchID",box.matchID)
		colors_current_game.append(Globals.colors.get(Globals.level)[box.matchID] )
		box.color_box = colors_current_game[i]

		box.self_modulate = box.color_box
#		box.rect_pivot_offset = box.rect_size*box.rect_scale /2
#		box.state = boxStates.UNPRESSED
		boxes.append(box)
func addBoxes():
	var i=0
	for box in boxes:
		box.BoxID = i
		box.connect("pressed",self,"on_box_pressed",[box.BoxID])
		# box.connect("fin",self,"on_animation_finished",[box.BoxID])
		printt("box.matchID",box.matchID,"box.BoxID",box.BoxID)
		GC.add_child(box)
		box.rect_pivot_offset = box.rect_size*rect_scale / 2
		i +=1
#	var screen_width = ProjectSettings.get_setting ("display/window/size/width")
#	var screen_height = ProjectSettings.get_setting ("display/window/size/height")
#
#	for box in get_children():
#		box.rect_size.x = screen_width / 2
#		box.rect_size.y = screen_height / 2
#		print(box.rect_size)
func initializeTimers():
	correctAnsTimer.connect("timeout",self,"correctAnswer")
	wrongAnsTimer.connect("timeout",self,"wrongAnswer")
	timer.connect("timeout",self,"incrementSecond")

	correctAnsTimer.set_one_shot(true)
	wrongAnsTimer.set_one_shot(true)

	add_child(timer)
	timer.start(1)
	Globals.time = 0
	add_child(correctAnsTimer)
	add_child(wrongAnsTimer)

func boxDead(boxID):
	# match_box(boxID)
	selectBox(boxID)
	updateLife()
	#	updateTimer()


func compareBoxes():
	if boxes[box1].matchID == boxes[box2].matchID && box1 != box2:
		correctAnsTimer.start(timeSpan)
	else:
		wrongAnsTimer.start(timeSpan)

func selectBox(boxID):
	if box1 == null:
		box1 = boxID
		selectAnswerJobs(boxID)
	elif box2 == null:
		box2 = boxID
		selectAnswerJobs(boxID)
		compareBoxes()
	printt("box1",box1,"box2",box2)



func selectAnswerJobs(box):
#	box.state = boxStates.WAIT_FOR_MATCH
	boxes[box].playFlip()
	boxes[box].changeColor(boxes[box].color_box)
	Globals.tries += 1
func wrongAnswer():
#	box.state = boxStates.UNPRESSED
	boxes[box1].playFlip()
	boxes[box1].changeColor("fff")
	boxes[box2].playFlip()
	boxes[box2].changeColor("fff")
	box1 = null 
	box2 = null 
func correctAnswer():
	boxes[box1].changeColor(0000)
	boxes[box1].set_disabled(true)
	boxes[box2].changeColor(0000)
	boxes[box2].set_disabled(true)
#	box.state = boxStates.MATCHED
	box1 = null 
	box2 = null 
	Globals.level_life +=2	
	scoreLable.set_text(str(Globals.level_life))
	correct_boxes_selected +=2
	if correct_boxes_selected == Globals.maxBoxesPerLevel.get(Globals.level):
		finished()
func incrementSecond():
	Globals.time +=1
func updateLife():
	printt(Globals.time)
	Globals.level_life-=1
	if Globals.level_life < 1:
		gameover()
	scoreLable.set_text(str(Globals.level_life))
	
func finished():
	timer.stop()
	get_tree().change_scene("res://Scenes/GUI/End/Retry.tscn")
	
func gameover():
	timer.stop()
	get_tree().change_scene("res://Scenes/GUI/End/Gameover.tscn")
	
func showBoxColor():
	for box in boxes:
		if not box.is_disabled():
			selectAnswerJobs(box.BoxID)
	started = false
# func updateTimer():
# 	timeSpan -= clamp(.05,.5,1.5)

# func changeColor(box):
# 	call_deferred(str(box),"self_modulate",Color("fff"))
	
#func playAnimation(obj):
#	call_deferred(str(obj.get_node("AnimationPlayer")) ,"play('TurnBox')")
func _preconditions():
	if !started:
		started = true
		StartLabel.hide()
		for box in boxes:
			if not box.is_disabled():
				box.playFlip()
				box.changeColor("fff")
		return false
	return true
func on_box_pressed(boxID):
	if _preconditions():
#		if boxes[boxID].state == boxStates.UNPRESSED:
		boxDead(boxID)
		

#TODO
#create NinePatchRect for box and score bg 
#update GC columns
#write random gen var to add to index of colors 
#wrie code for matching using current selected var 
#Add charge per level for use if not addvert 
#update rate 
#add retry to info 
#update taps score
