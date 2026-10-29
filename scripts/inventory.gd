extends Control

signal item_selected(item_scene: PackedScene, index: int)


@export var items: Array[InventoryObject]
@export var button_max_size: float = 128

@onready var _buttons_container = $HBoxContainer
@onready var _description = $PanelContainer


func take_item(index: int) -> void:
	_buttons_container.get_child(index).visible = false


func untake_item(index: int) -> void:
	_buttons_container.get_child(index).visible = true


func _ready() -> void:
	for item in items:
		var button = TextureButton.new()
		button.custom_maximum_size = Vector2(button_max_size, button_max_size)
		button.texture_normal = item.inventory_image
		button.texture_hover = item.inventory_image
		button.texture_pressed = item.inventory_image
		button.texture_focused = item.inventory_image
		button.texture_disabled = item.inventory_image
		button.stretch_mode = TextureButton.STRETCH_SCALE

		_buttons_container.add_child(button)

	var i: int = 0
	for button in _buttons_container.get_children():
		button.pressed.connect(func ():
			item_selected.emit(items[i].placeable_object, i)
		)

		button.mouse_entered.connect(func ():
			_set_description(i)
			_description.visible = true
		)

		button.mouse_exited.connect(func ():
			_description.visible = false
		)

		i += 1


func _input(event: InputEvent) -> void:
	if event is not InputEventMouseMotion:
		return

	_description.global_position = event.position
	_description.global_position.y -= _description.size.y


func _set_description(index: int) -> void:
	%Title.text = "[wave amp=30.0 freq=5.0 connected=1]" + items[index].title + "[/wave]"
	%Description.text = items[index].description
