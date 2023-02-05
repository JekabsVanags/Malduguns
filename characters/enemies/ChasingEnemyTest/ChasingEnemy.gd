extends KinematicBody2D


var state_machine
var state = "idle"
var movement = Vector2(0,0)
var speed = 3
var distance
var health = 2

func _ready():
	state_machine = $Node2D/AnimationTree.get("parameters/playback")
	$RayCast2D.add_exception($CollisonBox)

func _process(delta):
	#Calculate enemies location relative to player
	distance = cloud.player_LOC-global_position
	
	#Enemies basic movement
	if is_on_floor() != true:
		movement.y += ((cloud.GRAVITY)/delta)*1000
	
	if distance.x < 10 && distance.x > -10:
		state_machine.travel("idle")
		state = "paused"
		movement.x = 0
		yield(get_tree().create_timer(1),"timeout")
		travelState("idle")
	elif state != "paused":
		chase(delta)
		if state != "retreat":
			checkCollision()

	if health <= 0:
		self.queue_free()

	movement = move_and_slide(movement,Vector2(0,-1))


func _on_DetectionArea_body_entered(body):
	if body.name == "player":
		$Node2D/Hitbox.monitoring = true
		$Node2D/DetectionArea.monitoring = false

func _on_Hitbox_body_entered(body):
	if body.name == "player":
		travelState("attack")
		body.takingDamage(1,position,3)
		$Node2D/Hitbox.monitoring = false
		$Node2D/DetectionArea.monitoring = true
		yield(get_tree().create_timer(0.2),"timeout");
		state_machine.travel("idle")
		state = "retreat"
		$Timer.start()

func _on_Timer_timeout():
	travelState("idle")

func travelState(targetstate):
	state = targetstate
	state_machine.travel(targetstate)

func chase(delta):
	if state == "running":
		if global_position.x < cloud.player_LOC.x:
			$Node2D.scale.x = -1
			movement.x = speed/delta
		elif global_position.x > cloud.player_LOC.x:
			$Node2D.scale.x = 1
			movement.x = -speed/delta
	if state == "retreat":
		if global_position.x < cloud.player_LOC.x:
			$Node2D.scale.x = -1
			movement.x = -speed/delta
		elif global_position.x > cloud.player_LOC.x:
			$Node2D.scale.x = 1
			movement.x = speed/delta

func checkCollision():
	if distance.length() < 400:
		$RayCast2D.cast_to = distance-Vector2(0,distance.y)
		if $RayCast2D.is_colliding() && state != "running":
			if $RayCast2D.get_collider().is_in_group("player"):
				travelState("running")
	else:
		travelState("idle")
		movement.x = 0

func takingDamage(damageTaken,enemyLoc,knockbackStrength):
	health-=damageTaken
	state_machine.travel("idle")
	state = "retreat"
	$Timer.start()
