extends Node2D
@onready var video_stream_player: VideoStreamPlayer = $VideoStreamPlayer

func _on_start_pressed() -> void:
	video_stream_player.play()

func _on_quit_pressed() -> void:
	print("quit")

func _on_quit_released() -> void:
	get_tree().quit() # 关闭游戏


func _on_video_stream_player_finished() -> void:
	get_tree().change_scene_to_file("res://snce/Fristlevel/main.tscn")
