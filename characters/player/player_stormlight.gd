extends KinematicBody2D

const GRAVITY = 0.15
var movement_speed = 3
var jump_speed = 5.5
var movement = Vector2()
var action

func _process(delta):
	movement_input(delta)
	#action_pressed()
	movement = move_and_slide(movement,Vector2(0,-1))
	

func movement_input(delta):
	#check for gravity (only effects if not on the floor)

	if Input.is_action_pressed("ui_right"):
		movement.x += (GRAVITY)/delta
	if Input.is_action_pressed("ui_left"):
		movement.x += (GRAVITY)/delta*-1
	if Input.is_action_pressed("ui_down"):
		movement.y += (GRAVITY)/delta
	if Input.is_action_pressed("ui_up"):
		movement.y += (GRAVITY)/delta*-1
	else:
		movement.y += (GRAVITY)/delta

func action_pressed():
	if Input.is_action_pressed("ui_down"):
		$light_oculder.texture_scale = 3;
		$universal_timer.start(3);
		action = "shine";

func _on_universal_timer_timeout():
	if action == "shine":
		$light_oculder.texture_scale = 1;
