extends Sprite2D

var _texto:String = ""
var index:int = 0

@export var texto:String:
	set(value):
		# 🔥 Reiniciar TODO para evitar bugs en siguientes diálogos
		$Timer.stop()
		$Timer_escondeB.stop()

		_texto = value
		visible = true

		$Label.text = ""
		index = 0

		$Timer.start()
	get:
		return _texto


func mostrar_texto(nuevo_texto:String):
	texto = nuevo_texto


func _on_timer_timeout() -> void:
	if index >= _texto.length():
		$Timer.stop()
		$Timer_escondeB.start()
	else:
		$Label.text += _texto[index]
		index += 1


func _on_timer_esconde_b_timeout() -> void:
	visible = false
	$Label.text = ""
	index = 0
