extends State

@export var state_ground : State
@export var state_air : State

@export var shuriken_Scene : PackedScene

func on_enter():
	animatedSprite2D.play("shuriken_launch")
	put_shuriken()

func on_animatedSprite2D_anim_finish(_anim_name):
	if _anim_name == "shuriken_launch":
		next_state = state_ground if character.is_on_floor() else state_air

func put_shuriken():
	if character.got_shuriken: return
	character.got_shuriken = true
	var newShuriken = shuriken_Scene.instantiate()
	newShuriken.position = character.position
	newShuriken.isflip = animatedSprite2D.flip_h
	newShuriken.connect("shuriken_destroyed", _on_shuri_destroyed)
	add_sibling(newShuriken)



func _on_shuri_destroyed():
	character.got_shuriken = false
