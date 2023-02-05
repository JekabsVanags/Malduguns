extends Area2D

func _on_damageArea_body_entered(body):
	if body.has_method("takingDamage"):
		body.takingDamage(1,self.position,4)
