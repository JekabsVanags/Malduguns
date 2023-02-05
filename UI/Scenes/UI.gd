extends CanvasLayer

func _ready():
	$UI/HBoxContainer/HP.text = str(cloud.player_HP)

func _process(delta):
	$UI/HBoxContainer/SP.text = str(cloud.player_SP)

func _on_player_damage_taken():
	$UI/HBoxContainer/HP.text = str(cloud.player_HP)
