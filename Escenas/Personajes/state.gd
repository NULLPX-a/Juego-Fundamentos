extends Node

class_name State

const SPEED = 300
const JUMP_VELOCITY = -400.0
const  GRAVITY = 980
@export var can_move = true

var character : CharacterBody2D
var animatedSprite2D : AnimatedSprite2D

var next_state : State = null

func on_enter():
	pass
	
func on_exit():
	pass

func update_direction(_direction):
	pass

func state_process(_delta):
	pass

func state_input(_event: InputEvent):
	pass

func get_SPEED():
	return SPEED
	
func get_JUMP_VELOCITY():
	return JUMP_VELOCITY

func get_GRAVITY():
	return GRAVITY

func on_animatedSprite2D_anim_finish(_anim_name):
	pass
