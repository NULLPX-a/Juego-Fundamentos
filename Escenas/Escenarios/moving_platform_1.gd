extends AnimatableBody2D

@warning_ignore("unused_parameter")
func _process(_delta: float) -> void:
	global_position = get_parent().global_position
