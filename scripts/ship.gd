class_name Spike
extends Area2D


@export var speed: float = 200.0
@export var distance: float = 100.0
@export var activation_radius: float = 50.0
@export var is_moving: bool = false

enum Direction {UP, DOWN, LEFT, RIGHT}

@export var direction_choice: Direction = Direction.RIGHT

var direction: Vector2
var start_position: Vector2
var target_position: Vector2
var moving_towards_target: bool = false


func _ready():
	start_position = position
	match direction_choice:
		Direction.UP:
			direction = Vector2.UP
		Direction.DOWN:
			direction = Vector2.DOWN
		Direction.LEFT:
			direction = Vector2.LEFT
		Direction.RIGHT:
			direction = Vector2.RIGHT
	
	target_position = start_position + (direction.normalized() * distance)

func _physics_process(delta):
	if is_moving:
		if !moving_towards_target:
			position += direction.normalized() * speed * delta
			if position.distance_to(target_position) <= speed * delta:
				position = target_position
				moving_towards_target = true
				direction = -direction
				target_position = start_position + (direction.normalized() * distance)
		else:
			position += direction.normalized() * speed * delta
			if position.distance_to(start_position) <= speed * delta:
				position = start_position
				moving_towards_target = false
				direction = -direction
				target_position = start_position + (direction.normalized() * distance)

func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.name == "badlik":
		body.applyDMG(10)

func _on_area_entered(area):
	if area.name == "Player":
		is_moving = true

func _on_area_exited(area):
	if area.name == "Player":
		is_moving = false

