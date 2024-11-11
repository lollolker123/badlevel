extends CharacterBody2D


var death = false
const SPEED = 200.0
@onready var sprite = $AnimatedSprite2D
const JUMP_VELOCITY = -425.0
var health = 10

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var step_sound_allow : bool = true


func applyDMG(dmg : int):
	health -= dmg
	if health <= 0:
		$deathtimer.start()
		$CollisionShape2D.disabled = true
		death = true
		health = 0
		sprite.play("death")

func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if death:
		return
	
	if sprite.animation == "jump" and is_on_floor():
		sprite.play("idle")
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		sprite.play("jump")
		$sfx/jump.play()
	
	if Input.is_action_just_pressed("restart"):
		Global.change_location()
		get_tree().reload_current_scene()
	
	var direction = Input.get_axis("stepleft", "stepright")
	if direction:
		velocity.x = direction * SPEED
		if is_on_floor():
			sprite.play("step")
			if not $sfx/step.playing and step_sound_allow:
				step_sound_allow = false
				$sfx/steptimer.start()
				$sfx/step.play()
		else:
			sprite.play("jump")
	if not direction:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction > 0:
		sprite.flip_h = false
	if direction < 0:
		sprite.flip_h = true
	move_and_slide()

func _on_animated_sprite_2d_animation_finished():
	if not death:
		sprite.play("idle")

func _on_deathtimer_timeout():
	Global.change_location()
	get_tree().reload_current_scene()

func _on_steptimer_timeout():
	step_sound_allow = true
