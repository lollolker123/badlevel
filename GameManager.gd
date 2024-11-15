extends Node


var background_textures : Array[CompressedTexture2D] = [
	preload("res://sprites/sprFunnyFace1.png")
]


func _ready():
	$CanvasLayer/TextureRect.texture = background_textures.pick_random()

func change_location():
	$CanvasLayer/TextureRect.texture = background_textures.pick_random()

func set_shader(shader_name: String, set_type: bool):
	if set_type:
		get_node("ShaderCanvas").get_node(shader_name).show()
	if not set_type:
		get_node("ShaderCanvas").get_node(shader_name).hide()

func _physics_process(_delta):
	if Input.is_action_just_pressed("escape"):
		get_tree().change_scene_to_file("res://levels/menu.tscn")

func _on_texture_reverse_timer_timeout():
	$CanvasLayer/TextureRect/TextureReverseTimer.start()
	match randi()%2:
		0:
			$CanvasLayer/TextureRect.flip_h = true
		1:
			$CanvasLayer/TextureRect.flip_h = false
