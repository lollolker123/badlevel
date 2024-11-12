extends Area2D

# Настройка для времени исчезновения блока
@export var disappear_time: float = 2.0  # Время в секундах
var timer: Timer

func _ready():
	# Создаем таймер
	timer = Timer.new()
	timer.wait_time = disappear_time
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)  # Подключаем сигнал таймера
	add_child(timer)

	# Подключаем сигнал на вход в область
	self.area_entered.connect(_on_area_entered)

func _on_area_entered(area):  # Изменяем название метода для Godot 4
	# Проверяем, что в блок вошел игрок
	if area.is_in_group("badlik"):  # Убедитесь, что у игрока есть соответствующая группа
		if !timer.is_stopped():
			timer.start()  # Запуск таймера

func _on_timer_timeout():
	# Убираем блок из сцены
	queue_free()


