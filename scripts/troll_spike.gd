class_name TrollSpike
extends Area2D


@export var one_shot : bool = false

var activated : bool = false


func _on_interact_area_body_entered(body):
	if body.has_method("applyDMG") and not activated:
		activated = true
		$AnimationPlayer.play("attack_anim")
		if not one_shot:
			$HideTimer.start()

func _on_body_entered(body):
	if body.has_method("applyDMG") and activated:
		body.applyDMG(10)
		if not one_shot:
			activated = false

func _on_hide_timer_timeout():
	activated = false
	$AnimationPlayer.play_backwards("attack_anim")
