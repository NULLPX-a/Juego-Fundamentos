extends CanvasLayer

@onready var menuPopUp = $menuPopUp

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	inicia_sliders()
	menuPopUp.visible = false
	$MenuButton.disabled = false
	$ColorRect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	if get_parent().has_node("new_ninja"):
		$health_ProgressBar.value = get_parent().get_node("new_ninja").health
		$FruitPointsLabel.text = "FruitPoints: " + str(get_parent().get_node("new_ninja").fruitCount)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$health_ProgressBar.value = get_parent().get_node("new_ninja").health
	$FruitPointsLabel.text = "FruitPoints: " + str(get_parent().get_node("new_ninja").fruitCount)
	var currentTime = Time.get_time_dict_from_system()
	if currentTime.minute < 10:
		$Clock.text = str(Time.get_datetime_dict_from_system().hour) + ":0" + str(Time.get_datetime_dict_from_system().minute)
	else:
		$Clock.text = str(Time.get_datetime_dict_from_system().hour) + ":" + str(Time.get_datetime_dict_from_system().minute)

##Menu de pausa
func _on_menu_button_pressed() -> void:
	get_tree().paused = true
	menuPopUp.visible = get_tree().paused

func _on_resume_pressed() -> void:
	get_tree().paused = false
	menuPopUp.visible = false

func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_sounds_pressed() -> void:
	pass # Replace with function body.

func _on_music_pressed() -> void:
	pass # Replace with function body.
##Menu de pausa


func _on_music_slider_value_changed(_value: float) -> void:
	AudioServer.set_bus_volume_db(1,_value - 100)
	if _value == 50:
		AudioServer.set_bus_mute(1, true)
	else:
		AudioServer.set_bus_mute(1, false)

func _on_sound_slider_value_changed(_value: float) -> void:
	AudioServer.set_bus_volume_db(2,_value - 100)
	if _value == 50:
		AudioServer.set_bus_mute(2, true)
	else:
		AudioServer.set_bus_mute(2, false)

func inicia_sliders():
	for slider in menuPopUp.get_children():
		if slider is HSlider:
			slider.value = 100
