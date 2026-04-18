extends CollisionShape2D



func _ready() -> void:
	#body_entered.connect(_on_body_entered)
	pass

func _on_area_entered(area:Area2D) -> void:
	if area.is_in_grou("Hazard") or area.name.to_lower().contains("pinchos"):
		owner.dead=true


func _on_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		owner.dead = true
