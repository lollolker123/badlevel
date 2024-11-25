extends Area2D

# Скорость скольжения
var slide_speed = 200

func _on_body_entered(body):
	if body.is_in_group("badlik"):  # Проверяем, что это персонаж игрока
		body.slide_on_ice(slide_speed)  # Вызываем метод слайда

func _on_body_exited(body):
	if body.is_in_group("badlik"):
		body.stop_sliding()  # Останавливаем скольжение, когда выходим с льда






