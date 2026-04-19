extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -450
var health = 100
var fruitCount = 0
var allow_animation:bool = false
var leaved_floor: bool = false
var had_jump: bool = false
var max_jumps: int = 2
var count_jumps: int = 0
var double_jump: bool = false
var ray_cast_dimesion = 10.5
var direction
var gotShuriken = false
var block_nija = false
var stuck_on_wall : bool = false

@export var shuriken:PackedScene


var dead = false:
	set(value):
		dead=value
		if value == true:
			trigger_death()

func _physics_process(delta: float) -> void:
	
	if block_nija: return;
	
	if is_on_floor():
		#Esto es para ayudar a indicar que se reinicia el timer 
		leaved_floor = false
		had_jump = false
		count_jumps = 0
	
	# Add the gravity.
	if not is_on_floor():
		if not leaved_floor:
			$coyote_timer.start()
			leaved_floor = true
		velocity += get_gravity() * delta
	#Una vez el personaje deje el suelo activar el timer
	#Y hasta que no termine el timer se le dejara saltar el personaje
	#Con la variale leaved_floor lo que hacemos es que no se inicie el timer si no se necesita
	
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and right_to_jump():
		if count_jumps == 1:
			double_jump = true
			$audiodoublejump.play()
		else:
			$audiojump.play()
		count_jumps += 1
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if $rayCast_walljump.get_collider():
		if $rayCast_walljump.get_collider().is_in_group("wall_jump"):
			if velocity.y > 0:
				count_jumps = 0
				velocity.y = 0
				stuck_on_wall = true
		else:
			stuck_on_wall = false
	else: stuck_on_wall = false
		
	
	
	move_and_slide()
	decide_animation()

func _input(event):
	if event.is_action_pressed("shuriken"): #Tecla F lo activa
		if gotShuriken: return
		gotShuriken = true
		allow_animation = false
		$animaciones.play("shuriken_launch")
		var newShuriken = shuriken.instantiate()
		newShuriken.position = self.position
		newShuriken.isflip = $animaciones.flip_h
		newShuriken.connect("shuriken_destroyed", _on_shuri_destroyed)
		add_sibling(newShuriken)

func _on_shuri_destroyed():
	gotShuriken = false

func _ready():
	$animaciones.play("appear")
	$rayCast_walljump.target_position.x = ray_cast_dimesion


func decide_animation():
	if direction < 0:
		$animaciones.flip_h = true
		$rayCast_walljump.target_position.x = -ray_cast_dimesion
	elif direction > 0:
		$animaciones.flip_h = false
		$rayCast_walljump.target_position.x = ray_cast_dimesion
	
	#Programacion para que las fisicas del personaje se mueva a la izquierda y la derecha
	if double_jump:
		double_jump = false
		allow_animation = false
		$animaciones.play("double_jump")
	
	if not allow_animation: return
	#Eje de las x
	if stuck_on_wall:
		$animaciones.play("wall_jump")
	else:
		if velocity.x == 0:
			$animaciones.play("idle")
		elif velocity.x < 0:
			#izquierda
			$animaciones.play("run")
		elif  velocity.x > 0:
		#derecha
			$animaciones.play("run")
		#Eje de las Y
		if velocity.y > 0:
			$animaciones.play("jump_down")
		elif velocity.y < 0:
			$animaciones.play("jump_up")


func right_to_jump():
	#Programacion para que el personaje quede suspendido un tiempo despues de saltar
	if had_jump:
		if count_jumps < max_jumps: return true
		else: return false
	if is_on_floor() || stuck_on_wall:
		had_jump = true
		return true
	elif not  $coyote_timer.is_stopped():
		had_jump = true
		return true


func collectFruit(fruitType):
	var auxString = fruitType + "Points"
	var _gainedPoints = GeneralRules[auxString]
	fruitCount += _gainedPoints
	$audiodoublejump.play()


func _on_animaciones_animation_finished() -> void:
	allow_animation = true


func _on_coyote_timer_timeout() -> void:
	print("Booom!")


func _on_damage_detection_area_shape_entered(_area_rid: RID, _area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	$audioDamage.play()
	allow_animation = false
	$animaciones.play("hit")
	velocity.y = -250
	health -= 10


func trigger_death() ->void:
	
	pass
