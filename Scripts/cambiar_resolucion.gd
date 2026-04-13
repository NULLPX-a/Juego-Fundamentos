extends Node

## Target aspect ratio for initial window (16:9 standard)
const TARGET_ASPECT := 16.0 / 9.0
## How much of the screen the window should cover (0.0 - 1.0)
const SCREEN_COVERAGE := 0.90
## Fallback minimum window size
const MIN_WIDTH := 800
const MIN_HEIGHT := 600

func _ready() -> void:
	_apply_adaptive_window()

func _apply_adaptive_window() -> void:
	# Get current screen info (fallback to primary screen 0 if needed)
	var screen_index := DisplayServer.window_get_current_screen()
	if screen_index < 0: screen_index = 0
	
	var screen_size := DisplayServer.screen_get_size(screen_index)
	var screen_pos := DisplayServer.screen_get_position(screen_index)

	# Calculate base size from coverage percentage
	var width := int(screen_size.x * SCREEN_COVERAGE)
	var height := int(screen_size.y * SCREEN_COVERAGE)

	# Snap to target aspect ratio
	if float(width) / float(height) > TARGET_ASPECT:
		width = int(height * TARGET_ASPECT)
	else:
		height = int(width / TARGET_ASPECT)

	# Enforce minimum size
	width = maxi(width, MIN_WIDTH)
	height = maxi(height, MIN_HEIGHT)

	# Apply size & center window on the correct monitor
	DisplayServer.window_set_size(Vector2i(width, height))
	var center_pos := Vector2i(
		screen_pos.x + (screen_size.x - width) / 2,
		screen_pos.y + (screen_size.y - height) / 2
	)
	DisplayServer.window_set_position(center_pos)

	print("🖥️ Window adapted: %dx%d | Screen: %dx%d" % [width, height, screen_size.x, screen_size.y])

# ─────────────────────────────────────────────────────────────
# CALL THESE FROM SETTINGS MENUS, DEBUG CONSOLES, OR HOTKEYS
# ─────────────────────────────────────────────────────────────

func set_resolution(width: int, height: int) -> void:
	DisplayServer.window_set_size(Vector2i(width, height))
	_center_on_current_screen(Vector2i(width, height))

func toggle_fullscreen() -> void:
	var current := DisplayServer.window_get_mode()
	var new_mode := DisplayServer.WINDOW_MODE_FULLSCREEN if current != DisplayServer.WINDOW_MODE_FULLSCREEN else DisplayServer.WINDOW_MODE_WINDOWED
	DisplayServer.window_set_mode(new_mode)

func _center_on_current_screen(size: Vector2i) -> void:
	var screen_index := DisplayServer.window_get_current_screen()
	if screen_index < 0: screen_index = 0
	var rect := DisplayServer.screen_get_size(screen_index)
	var pos := DisplayServer.screen_get_position(screen_index)
	var final_pos := Vector2i(
		pos.x + (rect.x - size.x) / 2,
		pos.y + (rect.y - size.y) / 2
	)
	DisplayServer.window_set_position(final_pos)
