extends Spatial

onready var door_l = $DoorL
onready var door_r = $DoorR
onready var tween = $Tween

var is_open = false
var slide_distance = 1.5
var duration = 0.6

func toggle_door():
	if is_open:
		close_door()
	else:
		open_door()

func open_door():
	if is_open:
		return

	is_open = true
	tween.stop_all()

	tween.interpolate_property(
		door_l,
		"translation:x",
		door_l.translation.x,
		door_l.translation.x - slide_distance,
		duration,
		Tween.TRANS_SINE,
		Tween.EASE_OUT
	)

	tween.interpolate_property(
		door_r,
		"translation:x",
		door_r.translation.x,
		door_r.translation.x + slide_distance,
		duration,
		Tween.TRANS_SINE,
		Tween.EASE_OUT
	)

	tween.start()

func close_door():
	if not is_open:
		return

	is_open = false
	tween.stop_all()

	tween.interpolate_property(
		door_l,
		"translation:x",
		door_l.translation.x,
		0,
		duration,
		Tween.TRANS_SINE,
		Tween.EASE_IN
	)

	tween.interpolate_property(
		door_r,
		"translation:x",
		door_r.translation.x,
		0,
		duration,
		Tween.TRANS_SINE,
		Tween.EASE_IN
	)

	tween.start()


func _on_ButtonPanel_button_pressed():
	toggle_door()
