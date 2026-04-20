extends CharacterBody2D
var health = 100
var fruitCount = 0
var got_shuriken = false
@export var animationes : AnimatedSprite2D
@export var machine_state : MachineState
@export var rayCastWallJump : RayCast2D
func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	if not is_on_floor():
		velocity.y += machine_state.current_state.get_GRAVITY() * delta

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction && machine_state.current_state.can_move:
		velocity.x = direction * machine_state.current_state.get_SPEED()
	else:
		velocity.x = move_toward(velocity.x, 0, machine_state.current_state.get_SPEED())

	move_and_slide()
	flip_or_not(direction)

func flip_or_not(direction):
	if direction < 0:
		animationes.flip_h = true
		rayCastWallJump.ray_flip = true
	elif  direction > 0:
		animationes.flip_h = false
		rayCastWallJump.ray_flip = false
