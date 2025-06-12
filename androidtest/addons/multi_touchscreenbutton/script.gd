@icon("icon/icon.svg")
extends TextureButton

@export var action: String

@onready var _texture_normal := texture_normal
@onready var _texture_pressed := texture_pressed

func _gui_input(event):
	var event_pos_adjusted: Vector2 = event.position + global_position
	var inside: bool = event_pos_adjusted.x > position.x and event_pos_adjusted.y > position.y and event_pos_adjusted.x < position.x + size.x and event_pos_adjusted.y < position.y + size.y
	
	if event is InputEventScreenTouch and event.pressed and inside:
		if toggle_mode:
			toggled.emit()
			button_pressed = true
			texture_normal = _texture_pressed
		else:
			pressed.emit()
			button_down.emit()
		if action: Input.action_press(action)
		texture_normal = _texture_pressed
		
	elif (event is InputEventScreenTouch and inside) or (event is InputEventScreenTouch and !event.pressed and !inside):
		button_up.emit()
		button_pressed = false
		texture_normal = _texture_normal
		if action: Input.action_release(action)

