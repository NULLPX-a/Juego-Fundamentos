extends Node2D
#Tamaño de cada anilla: 13 px
var floorDetected = false
var rayCastInitValue = 90
 #Pixeles inciales del raycast
var safeTimeOut = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$raycast_floor_detection.target_position.y = rayCastInitValue
	$safeTime.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if not floorDetected && safeTimeOut:
		$raycast_floor_detection.target_position.y += 13
		if $raycast_floor_detection.is_colliding():
			floorDetected = true
			$raycast_floor_detection.target_position.y -= 13
			init_spikeball()
	$SpikedBall.rotation = self.rotation
func init_spikeball():
	var numberOfChains = ($raycast_floor_detection.target_position.y - rayCastInitValue) / 13
	$SpikedBall.position.y += (numberOfChains * 13)
	for i in range(numberOfChains):
		var newRing = preload("res://Escenas/Escenarios/Enemigos/one_chain.tscn").instantiate()
		newRing.position = Vector2(0,(13 * (i + 1)))
		self.add_child(newRing)
	
	
	$animation_rotation.play("regular_move")



func _on_safe_time_timeout() -> void:
	safeTimeOut = true


func _on_area_collision_with_map_body_entered(_body: Node2D) -> void:
	$animation_rotation.speed_scale *= -1
