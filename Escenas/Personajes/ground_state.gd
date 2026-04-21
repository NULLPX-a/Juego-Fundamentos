extends State

class_name groundState


@export var state_air : AirState
@export var state_shuriken : State
@export var coyoteTimer : Timer
@export var audioJump : AudioStreamPlayer2D

var resbala = false
var delta_resbala = 3

func on_enter():
	animatedSprite2D.play("idle")

func state_process(_delta):
	detect_resbala()
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

func detect_resbala():
	var raycast_resbala : RayCast2D = character.rayCastResbala
	if raycast_resbala.is_colliding():
		if raycast_resbala.get_collider().is_in_group("resbala"):
			resbala = true
		else:
			resbala = false

func get_delta_move_toward():
	if not resbala:
		return SPEED
	else:
		return delta_resbala
