class_name Player
extends CharacterBody2D

var death = false
var SPEED : float = 200.0
var ACCELERATION : float = 175.0
var MAX_SPEED : float = 310.0
var JUMP_VELOCITY : float = -425.0
var health = 10

@onready var sprite = $AnimatedSprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var step_sound_allow : bool = true
var current_speed = 200


func applyDMG(dmg: int):
	health -= dmg
	if health <= 0 and not death:
		death = true
		health = 0
		sprite.play("death")
		$deathtimer.start()
		$CollisionShape2D.disabled = true

func _ready():
	if get_parent().you_are_an_idiot:
		Global.set_shader("glitch", true)
	else:
		Global.set_shader("glitch", false)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if death:
		return
	
	if not $sfx/youareanidiot.playing and get_parent().you_are_an_idiot:
		$sfx/youareanidiot.play()
	
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
	
	if get_parent().inversion:
		direction = Input.get_axis("stepright", "stepleft")
	
	if direction:
		if get_parent().acceleration:
			current_speed = min(current_speed + ACCELERATION * delta, MAX_SPEED)
			velocity.x = direction * current_speed
		else:
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
