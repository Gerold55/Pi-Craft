extends Node3D

@export var move_speed: float = 5.0  # Speed of movement
@export var look_sensitivity: float = 0.1  # Mouse sensitivity
var rotation_v = Vector3()  # Initialize the Vector3 with default values (0, 0, 0)
onready var camera: Camera3D = $Camera3D  # Ensure this points to the Camera3D node

func _ready() -> void:
	# Capture the mouse for rotation
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	# Handle mouse movement for looking around
	if event is InputEventMouseMotion:
		rotation_v.y -= event.relative.x * look_sensitivity  # Horizontal rotation
		rotation_v.x -= event.relative.y * look_sensitivity  # Vertical rotation
		rotation_v.x = clamp(rotation_v.x, -90, 90)  # Prevent flipping upside-down
		rotation_degrees = Vector3(rotation_v.x, rotation_v.y, 0)

func _process(delta: float) -> void:
	# Handle WASD movement
	var direction = Vector3.ZERO
	if Input.is_action_pressed("move_forward"):
		direction -= transform.basis.z
	if Input.is_action_pressed("move_backward"):
		direction += transform.basis.z
	if Input.is_action_pressed("move_left"):
		direction -= transform.basis.x
	if Input.is_action_pressed("move_right"):
		direction += transform.basis.x

	# Normalize direction vector and move the node
	if direction != Vector3.ZERO:
		direction = direction.normalized()
	translation += direction * move_speed * delta
