extends Node2D

var velocidad = Vector2(450,-200)
var gravity = 9.8
signal shuriken_destroyed
var isflip = false


func _ready() -> void:
	$Timer.start()
	if  isflip:
		velocidad.x *= -1


func _process(_delta: float) -> void:
	velocidad.y += gravity
	position += velocidad * _delta


func _on_hit_box_body_entered(_body: Node2D) -> void:
	$AnimationPlayer.stop()
	velocidad = Vector2(0,0)
	$shurikenSprite.play("die")


func _on_shuriken_sprite_animation_finished() -> void:
	destroy_myself()


func _on_timer_timeout() -> void:
	destroy_myself()
	
func destroy_myself():
	emit_signal("shuriken_destroyed")
	self.queue_free()
