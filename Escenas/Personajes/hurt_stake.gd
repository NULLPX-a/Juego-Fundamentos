extends State

@export var state_ground : State

func on_animatedSprite2D_anim_finish(_anim_name):
	if _anim_name == "hit":
		next_state = state_ground
