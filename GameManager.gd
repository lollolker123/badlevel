extends Node


var background_textures : Array[CompressedTexture2D] = [
	preload("res://sprites/Sprite-0004.png")
]


func _ready():
	$CanvasLayer/TextureRect.texture = background_textures.pick_random()

func change_location():
	$CanvasLayer/TextureRect.texture = background_textures.pick_random()

func _physics_process(delta):
	pass

func _on_texture_reverse_timer_timeout():
	$CanvasLayer/TextureRect/TextureReverseTimer.start()
	match randi()%2:
		0:
			$CanvasLayer/TextureRect.flip_h = true
		1:
			$CanvasLayer/TextureRect.flip_h = false
