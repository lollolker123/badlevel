extends Node2D

# Подключаемые узлы и переменные
var player = null
var block = null
var teleport_radius = 500

func _ready():
	# Получаем ссылки на узлы игрока (badlik) и блока
	player = $badlik  # Замените на правильный путь, если необходимо
	block = $tpblock   # Замените на путь к вашему блоку

func _process(delta):
	# Проверка нажатия клавиши "Enter" или "Space"
	if Input.is_action_just_pressed("ui_select"):  
		# Проверяем, находится ли игрок в пределах блока
		if tpblock.get_global_rect().has_point(player.global_position):
			teleport_player()  # Вызов функции телепортации

func teleport_player():
	# Генерируем случайные координаты для телепортации
	var random_x = randf_range(player.position.x - teleport_radius, player.position.x + teleport_radius)
	var random_y = randf_range(player.position.y - teleport_radius, player.position.y + teleport_radius)

	# Ограничиваем положение игрока в пределах игрового окна
	random_x = clamp(random_x, 0, get_viewport().size.x)
	random_y = clamp(random_y, 0, get_viewport().size.y)

	# Установка новой позиции игрока
	player.position = Vector2(random_x, random_y)
