extends State

class_name AirState

@export var state_ground : State
@export var state_double_jump : State
@export var state_shuriken : State
@export var state_wall : State
@export var rayCastWallJump : RayCast2D
var DOUBLE_JUMP_VELOCITY = -300
var canDoubleJump = false

func state_process(_delta):
	
	if character.is_on_floor():
		next_state = state_ground
	
	if character.velocity.y < 0:
		animatedSprite2D.play("jump_up")
	elif character.velocity.y > 0:
		animatedSprite2D.play("jump_down")

	if rayCastWallJump.get_collider():
		if rayCastWallJump.get_collider().is_in_group("wall_jump"):
			if character.velocity.y > 0:
				next_state = state_wall
		pass

func state_input(event: InputEvent):
	if event.is_action_pressed("jump"):
		if canDoubleJump:
			character.velocity.y = JUMP_VELOCITY
			animatedSprite2D.play("double_jump")
			next_state = state_double_jump
			canDoubleJump = false
	elif event.is_action_pressed("shuriken"):
		next_state = state_shuriken

func on_exit():
	canDoubleJump = false
