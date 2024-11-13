class_name MovingBlock
extends CharacterBody2D


@export_enum("Up", "Down", "Right", "Left") var fly_direction : String

@export var speed : int = 250
var direction : Vector2

@export var out_of_bounds_despawn : bool = false
@export var colliding : bool = true
var activated : bool = false


func fly():
	match fly_direction:
		"Up":
			direction = Vector2.UP
		"Down":
			direction = Vector2.DOWN
		"Right":
			direction = Vector2.RIGHT
		"Left":
			direction = Vector2.LEFT
	activated = true

func _physics_process(_delta):
	if activated and not is_on_floor(): 
		velocity = direction * speed
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().name == "badlik" and not activated: 
			fly()
	
	move_and_slide()

func _on_visible_on_screen_notifier_2d_screen_exited():
	if out_of_bounds_despawn and activated:
		queue_free()

func _on_kill_area_body_entered(body):
	if body.has_method("applyDMG"):
		body.applyDMG(10)
		fly()
