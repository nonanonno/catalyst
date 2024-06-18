extends Camera3D

@export_range(0, 10, 0.01) var sensitivity: float = 3
@export_range(0, 10, 0.01) var speed_scale: float = 1.17
@export_range(1, 100, 0.1) var boost_speed_multiplier: float = 3.0

@onready var _velocity = 3
@onready var rot_x = 0
@onready var rot_y = 0

func _input(event):
	if not current:
		return
	
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			rot_x -= event.relative.x / 1000 * sensitivity
			rot_y -= event.relative.y / 1000 * sensitivity
			rot_y = clamp(rot_y, -PI/2, PI/2)
			transform.basis = Basis()
			rotate_object_local(Vector3(0,1,0), rot_x)
			rotate_object_local(Vector3(1,0,0), rot_y)
			
	
	if event is InputEventMouseButton:
		match event.button_index:
			MOUSE_BUTTON_RIGHT:
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED if event.pressed else Input.MOUSE_MODE_VISIBLE
			MOUSE_BUTTON_WHEEL_UP:
				_velocity = clamp(_velocity * speed_scale, 0.2, 1000)
			MOUSE_BUTTON_WHEEL_DOWN:
				_velocity = clamp(_velocity / speed_scale, 0.2, 1000)


func _process(delta):
	if not current:
		return
	
	var direction = Vector3(
		float(Input.is_physical_key_pressed(KEY_D)) - float(Input.is_physical_key_pressed(KEY_A)),
		0,
		float(Input.is_physical_key_pressed(KEY_S)) - float(Input.is_physical_key_pressed(KEY_W))
	).normalized()
	
	if Input.is_physical_key_pressed(KEY_SHIFT):
		translate(direction * _velocity * delta * boost_speed_multiplier)
		global_translate(Vector3(0,float(Input.is_physical_key_pressed(KEY_SPACE)) - float(Input.is_physical_key_pressed(KEY_CTRL)),0) * _velocity * delta * boost_speed_multiplier)
	else:
		translate(direction * _velocity * delta)
		global_translate(Vector3(0,float(Input.is_physical_key_pressed(KEY_SPACE)) - float(Input.is_physical_key_pressed(KEY_CTRL)),0) * _velocity * delta)
