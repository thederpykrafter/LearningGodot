extends CharacterBody3D

@onready var head = %Head
@onready var camera = %Camera3D
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@export_group("Movement")
@export var speed = 5 # m/s
@export var jump_speed = 5 # m/s

@export_group("Camera")

@export var mouse_sensitivity = 0.002
@export var joy_sensitivity = 4


var target_velocity = Vector3.ZERO

func move_player(delta):
	# Apply Gravity
	velocity.y += -gravity * delta
	
	var input = Input.get_vector("Move_Left", "Move_Right", "Move_Forward", "Move_Backward", 0.1)
	var direction = transform.basis * Vector3(input.x, 0, input.y)
	
	# Ground Velocity
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	
	# Moving the Character
	move_and_slide()
	
	# Jumping
	if is_on_floor() and Input.is_action_just_pressed("Jump"):
		velocity.y = jump_speed

func rotate_player(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		head.rotate_x(-event.relative.y * mouse_sensitivity)
		head.rotation.x = clampf(head.rotation.x, -deg_to_rad(70), deg_to_rad(70))
		
func joy_rotation(delta):
	var joy_input = Input.get_vector("Look_Left", "Look_Right", "Look_Up", "Look_Down", 0.1)
	#var joy_direction = transform.basis * Vector3(joy_input.x, 0, joy_input.y)
	rotate_y(-joy_input.x * joy_sensitivity * delta)
	head.rotate_x(-joy_input.y * joy_sensitivity * delta)
	head.rotation.x = clampf(head.rotation.x, -deg_to_rad(70), deg_to_rad(70))
	
	

func _input(event):
	rotate_player(event)
	
	if Input.is_action_just_pressed("Capture"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		elif Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	move_player(delta)
	joy_rotation(delta)
	
	
	

