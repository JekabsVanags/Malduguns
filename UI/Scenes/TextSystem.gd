extends CanvasLayer
const CHARACTERSPEED = 0.05

var textScroller
var textBox
var speakerBox
var speakerImage
var scrollSpeed

signal dialogue_done

var index
var dialoguetext
var speakersnames
var speakerfaces

var readyToPreceed

func _ready():
	textScroller = $Control/Tween
	textBox = $Control/MarginContainer/Panel/HSplitContainer/TextBox
	speakerBox = $Control/MarginContainer/Panel/SpeakerBox
	speakerImage = $Control/TextFace
	
	$Control.visible = false
	textBox.percent_visible = 0
	textBox.text = ""
	index = 0

func _process(delta):
	if Input.is_action_just_pressed("ui_accept") && readyToPreceed == false:
		textScroller.seek(textScroller.get_runtime()-0.001)
	elif Input.is_action_just_pressed("ui_accept") && readyToPreceed == true:
		textBox.modulate = Color(1,1,1,0)
		readyToPreceed = false
		$Control/MarginContainer/Panel/HSplitContainer/Finished.visible = false
		$Control/MarginContainer/Panel/HSplitContainer/Finished/AnimationPlayer.stop()
		dialogueProceed()

func startDialogue(dialogue, speaker, images):
	dialoguetext = dialogue
	speakersnames = speaker
	speakerfaces = images
	dialogueProceed()
	

func dialogueProceed():
	$Control.visible = true
	if index < len(dialoguetext):
		textBox.modulate = Color(1,1,1,1)
		textBox.text = dialoguetext[index]
		speakerBox.text = speakersnames[index]
		speakerImage.texture = load(speakerfaces.get(speakersnames[index]))
		scrollSpeed = len(dialoguetext[index])*CHARACTERSPEED
		readyToPreceed = false
		displayText()
	else :
		$Control.visible = false
		index = 0
		emit_signal("dialogue_done")

func displayText():
	textScroller.interpolate_property(textBox,"percent_visible",0,1,scrollSpeed)
	textScroller.start()

func _on_Tween_tween_completed(object, key):
	index += 1
	$Control/MarginContainer/Panel/HSplitContainer/Finished.visible = true
	$Control/MarginContainer/Panel/HSplitContainer/Finished/AnimationPlayer.play("IDLE")
	readyToPreceed = true
