extends Area2D

export var strength = 4
var modulation = 1

func _on_crumpleDetector_body_entered(body):
	if body.name == 'player':
		$Timer.start()

func _on_Timer_timeout():
	if strength == 0:
		self.queue_free()
	strength -= 1
	modulation -= modulation-0.25
	$Sprite.modulate = Color(1,1,1,modulation)
