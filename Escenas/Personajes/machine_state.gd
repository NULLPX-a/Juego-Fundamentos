extends Node

class_name MachineState

@export var character : CharacterBody2D
@export var animatedSprited2D : AnimatedSprite2D
@export var audio_dmg : AudioStreamPlayer2D
@export var current_state : State
@export var hurt_stake : State
var arrayStates : Array[State]

func _ready() -> void:
	animatedSprited2D.play("appear")
	for child in self.get_children():
		if child is State:
			child.character = character
			child.animatedSprite2D = animatedSprited2D
			arrayStates.append(child)

func _physics_process(_delta: float) -> void:
	if current_state.next_state != null:
		change_state(current_state.next_state)
		
	current_state.state_process(_delta)
func _input(event):
	current_state.state_input(event)

func change_state(new_state : State):
	current_state.on_exit()
	current_state.next_state = null
	current_state = new_state
	current_state.on_enter()

func _on_animaciones_animation_finished() -> void:
	current_state.on_animatedSprite2D_anim_finish(animatedSprited2D.animation)

func _on_damage_detection_area_shape_entered(_area_rid: RID, _area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	audio_dmg.play()
	character.velocity.y = -250
	animatedSprited2D.play("hit")
	character.health -= 10
	current_state.next_state = hurt_stake


func _on_damage_detection_body_entered(body: Node2D) -> void:
	audio_dmg.play()
	character.velocity.y = -250
	animatedSprited2D.play("hit")
	character.health -= 10
	current_state.next_state = hurt_stake
