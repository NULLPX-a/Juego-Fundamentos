extends State

@export var ground_state : State




func on_animatedSprite2D_anim_finish(_anin_name):
	next_state = ground_state
