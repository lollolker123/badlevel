extends Area2D

# Переменные для настройки
@export var speed: float = 200.0
@export var distance: float = 100.0
@export var activation_radius: float = 50.0 # Радиус активации
@export var is_moving: bool = false  # Статус движения

enum Direction {
	UP, DOWN, LEFT, RIGHT
}

# Выбор направления
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

func _process(delta):
	if is_moving:
		if !moving_towards_target:
			position += direction.normalized() * speed * delta

			# Проверка, достигли ли мы целевой позиции
			if position.distance_to(target_position) <= speed * delta:
				position = target_position  # Устанавливаем позицию точно на целевую
				moving_towards_target = true  # Подготовка к возврату
				direction = -direction  # Меняем направление
				target_position = start_position + (direction.normalized() * distance)
		else:
			# Движение обратно к начальной позиции
			position += direction.normalized() * speed * delta

			# Проверка, достигли ли мы начальной позиции
			if position.distance_to(start_position) <= speed * delta:
				position = start_position  # Устанавливаем позицию точно на начальную
				moving_towards_target = false  # Готовимся двигаться снова
				direction = -direction  # Меняем направление обратно на целевую
				target_position = start_position + (direction.normalized() * distance)

func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.name == "badlik":
		body.applyDMG(10)

func _on_area_entered(area):
	if area.name == "Player":  # Замените на имя объекта игрока
		is_moving = true  # Активируем движение

func _on_area_exited(area):
	if area.name == "Player":  # Замените на имя объекта игрока
		is_moving = false  # Деактивируем движение

