@tool
extends Node2D

@export_enum("apple", "banana", "cherry", "Kiwi", "melon", "orange", "strawberry", "pineapple") var fruitType:String="apple":
	set(value):
		fruitType = value
		$animations.animation = fruitType

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not Engine.is_editor_hint():
		$animations.play(fruitType)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_collect_body_entered(body: Node2D) -> void:
	if body.has_method("collectFruit"):
		body.collectFruit(fruitType)
	$animations.play("collected")


func _on_animations_animation_finished() -> void:
	self.queue_free()
