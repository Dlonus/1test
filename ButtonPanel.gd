extends Spatial

signal button_pressed

var player_in_range := false

func _on_Area_body_entered(body):
	if body.name == "playuh":
		player_in_range = true

func _on_Area_body_exited(body):
	if body.name == "playuh":
		player_in_range = false

func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		emit_signal("button_pressed")







