extends Area2D
var next_level_path = ""

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("virtual"):
		print("collision")
		var current_scene_file = get_tree().current_scene.scene_file_path
		if current_scene_file =="res://Escenas/Pantallas/escena1.tscn":
			next_level_path = "res://Escenas/Escenarios/escena2.tscn"
		elif current_scene_file == "res://Escenas/Escenarios/escena2.tscn":
			next_level_path = "res://Escenas/Escenarios/Nivel 3/nivel3.tscn"
		elif current_scene_file == "res://Escenas/Escenarios/Nivel 3/nivel3.tscn":
			next_level_path = "res://Escenas/Pantallas/escena1.tscn"
		
		get_tree().change_scene_to_file(next_level_path)
	#cambio de nivel
	
