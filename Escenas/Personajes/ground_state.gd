extends State

class_name groundState


@export var state_air : AirState
@export var state_shuriken : State
@export var coyoteTimer : Timer
@export var audioJump : AudioStreamPlayer2D

func on_enter():
	animatedSprite2D.play("idle")

func state_process(_delta):
	if character.velocity.x != 0:
		animatedSprite2D.play("run")
	else :
		animatedSprite2D.play("idle")
	
	if !character.is_on_floor():
		if coyoteTimer.is_stopped():
			coyoteTimer.start()

func state_input(event: InputEvent):
	if event.is_action_pressed("jump"):
		jump()
	elif event.is_action_pressed("shuriken"):
		next_state = state_shuriken
		


func _on_coyote_timer_timeout() -> void:
	next_state = state_air


func jump():
	audioJump.play()
	character.velocity.y = JUMP_VELOCITY
	state_air.canDoubleJump = true
	next_state = state_air
