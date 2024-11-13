class_name Door
extends Node2D


@export var next_scene : String


func _on_nextlevel_body_entered(body):
	if body.name != "badlik":
		return
	Global.change_location()
	get_tree().change_scene_to_file(next_scene)


