extends Node2D
class_name Decoracao

@export_category("Variaveis")
@export var _textures_list: Array[String]

func _ready() -> void:
	for _filho in get_children():
		if _filho is Sprite2D:
			_filho.texture = load(
				_textures_list.pick_random()
			)
	pass
