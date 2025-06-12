@tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("MultiTouchScreenButton", "TextureButton", preload("script.gd"), preload("icon/icon.svg"))

func _exit_tree():
	remove_custom_type("MultiTouchScreenButton")
