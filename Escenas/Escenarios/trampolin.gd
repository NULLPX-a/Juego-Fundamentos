extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _process(_delta: float) -> void:
	pass



func _on_activation_area_body_entered(_body: Node2D) -> void:
	$audioTrampolin.play()
	$Animaciones_trampolin.play("launch")
	_body.velocity.y = -800
