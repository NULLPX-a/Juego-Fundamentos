extends State

@export var rayCastWallJump : RayCast2D
@export var audioJump : AudioStreamPlayer2D
@export var state_air : State

func on_enter():
	character.velocity.y = 0
	animatedSprite2D.play("wall_jump")

func state_input(event : InputEvent):
	if event.is_action_pressed("jump"):
		audioJump.play()
		character.velocity.y = JUMP_VELOCITY
		state_air.canDoubleJump = true
		next_state = state_air

func get_GRAVITY():
	return 0

func state_process(_delta):
	if not rayCastWallJump.get_collider():
		next_state = state_air
