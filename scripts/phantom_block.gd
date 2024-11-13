extends CharacterBody2D





func _physics_process(delta):
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().name == "badlik": 
			$AnimationPlayer.play("transparency_anim")
			$Collidier.disabled = true
	
	move_and_slide()
