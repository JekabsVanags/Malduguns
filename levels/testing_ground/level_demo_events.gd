extends Node2D
var talking

var textBox

"""
var portraits ={
	"LAIMA" : "res://UI/UI_Elements/Text_Faces/laima.png",
	"MALDUGUNS" : "res://UI/UI_Elements/Text_Faces/malduguns.png",
	"KRISJANIS" : "res://UI/UI_Elements/Text_Faces/malduguns.png"
}

func _ready():
	textBox = get_node("/root/TextSystem")
	textBox.connect("dialogue_done", self, "_on_TextSystem_dialogue_done")
	
	talking = true
	var text = [
	"Come to me, dear traveler",
	"Come and join me in the sun beyond",
	"THIS IS TEST"]
	var speakers = [
	"LAIMA",
	"LAIMA",
	"KRISJANIS"
	]
	textBox.startDialogue(text,speakers,portraits)

func _on_Finish_body_entered(body):
	talking = true
	var text = [
	"Congratulations on finishing the test level, for this has been a challange",
	"It was nothing!",
	"You say so... But what do you think really?",
	"Nevermind, we will see.",
	"Hmmm... What a weird diety",
	"Am not!"]
	var speakers = [
	"LAIMA",
	"MALDUGUNS",
	"LAIMA",
	"LAIMA",
	"MALDUGUNS",
	"LAIMA"
	]
	textBox.startDialogue(text,speakers,portraits)

func _on_Finish_body_exited(body):
	$EventNodes/Finish.queue_free()
	
func _on_TextSystem_dialogue_done():
	talking = false
"""
