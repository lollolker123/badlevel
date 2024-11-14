extends StaticBody2D




func _on_visible_on_screen_notifier_screen_entered():
	match randi()%2:
		0:
			$Hideeffect.play()
			$AnimationPlayer.play("hide_anim")
		1:
			pass
	$VisibleOnScreenNotifier.queue_free()

func _on_hideeffect_finished():
	queue_free()

func _on_crush_area_body_entered(body):
	if body.name == "badlik":
		Global.set_shader("hatch", true)
		$Crusheffect.play()

func _on_crusheffect_finished():
	get_tree().quit()

func _on_liveeffect_finished():
	$Liveeffect.play()
