extends Label

@export var machineState : MachineState



func _process(_delta: float) -> void:
	self.text = machineState.current_state.name
