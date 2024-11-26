extends Node2D

# Функция для обработки подбора ключа
func _on_key_body_entered(body):
	if body.name == "badlik":  # Проверка, является ли объект игроком "badlik"
		Global.has_key = true  # Устанавливаем переменную has_key в true
		queue_free()  # Удаляем ключ из сцены (если это необходимо)
		print("Ключ подобран!")  # Сообщение о том, что ключ был подобран
