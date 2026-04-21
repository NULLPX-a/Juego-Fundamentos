extends Area2D

@onready var escena = preload("res://Escenas/Escenarios/escena1.tscn").instantiate()
var permiso = true

func _on_body_entered(_body: Node2D) -> void:
	if permiso:
		permiso = false
		_body.block_nija = true
		$AnimationPlayer.play("to_black")
	else:
		queue_free()

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	if (_anim_name == "to_black"):
		get_parent().get_node("PlayerInfo").visible = false
		escena.get_node("AnimationPlayer").connect("animation_finished", on_escene_end)
		get_parent().add_child(escena)
		escena.get_node("Path2D/PathFollow2D/Camera2D").make_current()
		$AnimationPlayer.play("to_transparent")

func on_escene_end(anim_name):
	if (anim_name == "act1"):
		$AnimationPlayer.stop()
		escena.queue_free()
		$AnimationPlayer.play("to_transparent")
		get_parent().get_node("new_ninja").block_nija = false
		get_parent().get_node("PlayerInfo").visible = true
