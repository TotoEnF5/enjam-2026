extends Control

signal item_selected(item_scene: PackedScene)


@export var items: Array[PackedScene]

@onready var _buttons_container = $HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var i: int = 0
	for button in _buttons_container.get_children():
		button.pressed.connect(func ():
			item_selected.emit(items[i])
		)
		i += 1
