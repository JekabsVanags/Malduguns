extends KinematicBody2D


var state_machine
var state = "idle"
var movement = Vector2(0,0)

func _ready():
	state_machine = $AnimationTree.get("parameters/playback")

func _process(delta):
	#Get the enemy to the ground. This particular enemy doesnt have other movements
	if is_on_floor() != true:
		movement.y += ((cloud.GRAVITY)/delta)*1000
		movement = move_and_slide(movement,Vector2(0,-1))
	
	#Check the player position and if the enemy needs to turn arround
	if state == "idle":
		if self.global_position.x > cloud.player_LOC.x && scale.x != -1:
			yield(get_tree().create_timer(cloud.getRandomNr(1,2)),"timeout")
			scale.x = -1
		elif self.global_position.x < cloud.player_LOC.x && scale.x != 1:
			yield(get_tree().create_timer(cloud.getRandomNr(1,2)),"timeout")
			scale.x = 1
		else:
			pass

func _on_DetectionArea_body_entered(body):
	if body.has_method("takingDamage"):
		$Hitbox.monitoring = true
		$DetectionArea.monitoring = false

func _on_Hitbox_body_entered(body):
	if body.has_method("takingDamage"):
		travelState("attack")
		body.takingDamage(1,position,2)
		$Hitbox.monitoring = false
		$DetectionArea.monitoring = true
		yield(get_tree().create_timer(0.5),"timeout");
		travelState("idle")

func travelState(targetstate):
	state = targetstate
	state_machine.travel(targetstate)
