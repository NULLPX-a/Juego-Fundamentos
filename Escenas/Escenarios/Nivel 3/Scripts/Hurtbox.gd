class_name HurtBox

extends Area2D

signal recieved_damage(damage: int)

@export var health = Health  

func _on_area_entered(hitbox : HitBox) -> void:
	if hitbox != null:
		health.health -= hitbox.damage
		received.damage.emit(hitbox.damage)


func _ready():
	connect("area_entered", _on_area_entered)
