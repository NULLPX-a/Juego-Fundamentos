extends RayCast2D

var ray_cast_dimesion = 12
var ray_flip = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.target_position.x = ray_cast_dimesion

func _process(_delta: float) -> void:
	if ray_flip:
		self.target_position.x = -ray_cast_dimesion
	else:
		self.target_position.x = +ray_cast_dimesion
