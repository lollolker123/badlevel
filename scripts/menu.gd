class_name Menu
extends Node




func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://levels/camera.tscn")

func _on_settings_button_pressed():
	$No_Access.play()

func _on_quit_button_pressed():
	get_tree().quit()