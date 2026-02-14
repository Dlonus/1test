extends KinematicBody

export var speed := 6.0
export var gravity := -9.8
export var mouse_sensitivity := 0.002

onready var head := $head

var velocity := Vector3.ZERO
var pitch := 0.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	# ESC: release mouse (so you can move your cursor again)
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	# Left click: recapture mouse (so you can look around again)
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	# Only mouse-look when captured
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED and event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		pitch = clamp(pitch - event.relative.y * mouse_sensitivity, deg2rad(-80), deg2rad(80))
		head.rotation.x = pitch

func _physics_process(delta):
	var direction := Vector3.ZERO

	if Input.is_action_pressed("ui_up"):
		direction -= transform.basis.z
	if Input.is_action_pressed("ui_down"):
		direction += transform.basis.z
	if Input.is_action_pressed("ui_left"):
		direction -= transform.basis.x
	if Input.is_action_pressed("ui_right"):
		direction += transform.basis.x

	direction = direction.normalized()

	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	velocity.y += gravity * delta

	velocity = move_and_slide(velocity, Vector3.UP)


func _on_Area_body_entered(body):
	pass # Replace with function body.


func _on_Area_body_exited(body):
	pass # Replace with function body.
