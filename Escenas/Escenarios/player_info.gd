extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_parent().has_node("virtual_guy"):
		$health_ProgressBar.value = get_parent().get_node("virtual_guy").health
		$FruitPointsLabel.text = "FruitPoints: " + str(get_parent().get_node("virtual_guy").fruitCount)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$health_ProgressBar.value = get_parent().get_node("new_ninja").health
	$FruitPointsLabel.text = "FruitPoints: " + str(get_parent().get_node("new_ninja").fruitCount)
	var currentTime = Time.get_time_dict_from_system()
	if currentTime.minute < 10:
		$Clock.text = str(Time.get_datetime_dict_from_system().hour) + ":0" + str(Time.get_datetime_dict_from_system().minute)
	else:
		$Clock.text = str(Time.get_datetime_dict_from_system().hour) + ":" + str(Time.get_datetime_dict_from_system().minute)
