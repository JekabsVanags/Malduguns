extends KinematicBody2D

var movement_speed = 6
var jump_speed = 11
var movement = Vector2()
var action

var cantmove = false

signal damage_taken

func _ready():
	pass # Replace with function body.


func _process(delta):
	#check for talking
	if get_parent().talking != true && cantmove == false:
		movement_input(delta)
		action_pressed()
	elif get_parent().talking == true:
		if is_on_floor() != true:
			movement.y += (cloud.GRAVITY)/delta
		movement.x = 0
	movement = move_and_slide(movement,Vector2(0,-1))
	cloud.player_LOC = self.global_position
	

func movement_input(delta):
	#check for gravity (only effects if not on the floor)
	if is_on_floor() != true:
		movement.y += (cloud.GRAVITY)/delta

	#check for basic movement, resets movement if no input
	if is_on_floor() == true && Input.is_action_just_pressed("ui_accept"):
		movement.y = jump_speed/delta*-1
	elif Input.is_action_just_released("ui_accept"):
		movement.y = movement.y/2 

	if Input.is_action_pressed("ui_right"):
		movement.x = movement_speed/delta
	elif Input.is_action_pressed("ui_left"):
		movement.x = movement_speed/delta*-1
	else:
		movement.x = 0

func action_pressed():
#shining
	if Input.is_action_just_pressed("ui_down") && cloud.player_SP > 0 && action != "shine":
		$light_oculder.texture_scale = 6
		cloud.player_SP -= 1
		$universal_timer.start(3)
		action = "shine"
		cloud.shine = true

#resting
	if Input.is_action_just_pressed("ui_up"):
		$light_oculder.texture_scale = 1.4
		$universal_timer.start(1)
		movement_speed = 4
		action = "rest"
	if Input.is_action_just_released("ui_up"):
		action = "-"
		movement_speed = 6
		$light_oculder.texture_scale = 2

func takingDamage(damageTaken,enemyLoc,knockbackStrength):
	cloud.player_HP-=damageTaken
	emit_signal("damage_taken")
	$sprite_frames.modulate = Color(1,0,0)
	$light_oculder.texture_scale = 3
	cantmove = true
	var trajectory = Vector2(position.x-enemyLoc.x,position.y-enemyLoc.y)
	movement = Vector2(0,0)
	movement = trajectory*knockbackStrength
	action = "damaged"
	$universal_timer.start(0.3)


func _on_universal_timer_timeout():
	if action == "shine":
		$light_oculder.texture_scale = 2
		cloud.shine = false
		action = "-"
	elif action == "rest":
		if cloud.player_SP < 10:
			cloud.player_SP += 1
	elif action == "damaged":
			$sprite_frames.modulate = Color(1,1,1)
			$light_oculder.texture_scale = 2
			cantmove = false
			action = "-"
	else:
		pass
