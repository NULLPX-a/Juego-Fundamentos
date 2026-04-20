extends State


@export var state_air : State
@export var audioDoubleJump : AudioStreamPlayer2D

func on_enter():
	audioDoubleJump.play()

func on_animatedSprite2D_anim_finish(_anim_name):
	if _anim_name == "double_jump":
		next_state = state_air
