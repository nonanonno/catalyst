# Phantom camera script. The camera is controlled like a FPS.
extends Camera3D

@export_range(0, 10, 0.01) var sensitivity: float = 3
@export_range(1, 100, 1) var acceleration: float = 10
@export_range(0, 100, 1) var max_speed: float = 50

@onready var window_planar_rot: Vector2 = Vector2.ZERO
@onready var last_direction: Vector3 = Vector3.ZERO
@onready var last_elevation: float = 0
@onready var speed: float = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if not current:
		return

	# Change camera direction if the mode is captured (aka FPS movement)
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			# Limit camera pitch to avoid flipping
			window_planar_rot.y = clamp(window_planar_rot.y - event.relative.y / 1000 * sensitivity, -PI / 2, PI / 2)
			window_planar_rot.x = fmod(window_planar_rot.x - event.relative.x / 1000 * sensitivity, 2 * PI)

			transform.basis = Basis()
			rotate_object_local(Vector3(0, 1, 0), window_planar_rot.x) # first rotate in Y
			rotate_object_local(Vector3(1, 0, 0), window_planar_rot.y) # then rotate in X

	# Switch capture mode
	if event is InputEventKey and event.is_action_pressed("Menu"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED else Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	if not current:
		return

	# Do not move the camera if the mouse is visible mode (i.e. GUI)
	if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		return

	# Capture the control order
	var direction = Vector3(
		float(Input.is_action_pressed("Right")) - float(Input.is_action_pressed("Left")),
		float(Input.is_action_pressed("Up")) - float(Input.is_action_pressed("Down")),
		float(Input.is_action_pressed("Back")) - float(Input.is_action_pressed("Forward"))
	)

	var boost = float(Input.is_action_pressed("Boost"))

	# Change the speed
	if direction.length() > 0:
		speed = min(max_speed * (boost + 1), speed + acceleration * (boost + 2) * delta)
	else:
		speed = 0

	if direction.length() > 0:
		direction = direction.normalized()
		last_direction = direction
	else:
		direction = last_direction

	# Move the camera
	direction = direction.rotated(Vector3.UP, window_planar_rot.x)
	global_translate(direction * speed * delta)
