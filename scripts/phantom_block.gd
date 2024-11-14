class_name PhantomBlock
extends CharacterBody2D


@export var one_shot : bool = true
var activated : bool = false


func _physics_process(delta):
	velocity = Vector2(0,0)
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().name == "badlik" and not activated: 
			$AnimationPlayer.play("hide_anim")
			$CollideTimer.start()
			activated = true
		else:
			if not one_shot:
				$RegenTimer.start()
	
	move_and_slide()

func _on_collide_timer_timeout():
	$Collidier.disabled = true

func _on_regen_timer_timeout():
	$AnimationPlayer.play_backwards("hide_anim")
	$Collidier.disabled = false
	activated = false
