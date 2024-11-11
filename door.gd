extends Node2D


@export var next_scene : String


func _on_animate_body_entered(body):
	if body.name != "badlik":
		return
	$open.show()

func _on_animate_body_exited(body):
	if body.name != "badlik":
		return
	$open.hide()


func _on_nextlevel_body_entered(body):
	if body.name != "badlik":
		return
	Global.change_location()
	get_tree().change_scene_to_file(next_scene)


