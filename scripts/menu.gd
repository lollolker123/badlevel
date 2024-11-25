class_name Menu
extends Node




func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://levels/camera.tscn")

func _on_settings_button_pressed():
	get_tree().change_scene_to_file("res://levels/settings_menu.tscn")

func _on_quit_button_pressed():
	get_tree().quit()

func _on_modding_button_pressed():
	get_tree().change_scene_to_file("res://levels/mod_menu.tscn")
