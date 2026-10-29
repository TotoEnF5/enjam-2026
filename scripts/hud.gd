extends Control


@onready var _next_button = $Button


func enable_go_to_next() -> void:
	_next_button.visible = true


func disable_go_to_next() -> void:
	_next_button.visible = true
