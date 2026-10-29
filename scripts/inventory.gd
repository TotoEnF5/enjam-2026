extends Control

signal item_selected(item: InventoryObject, index: int)


@export var button_max_size: float = 128

@onready var _buttons_container = $PanelContainer2/HBoxContainer
@onready var _description = $PanelContainer

var _inventory: IterationInventory


func take_item(index: int) -> void:
	_buttons_container.get_child(index).queue_free()


func place_item(item: InventoryObject) -> void:
	_inventory.items.push_back(item)
	_create_button(item, _inventory.items.size() - 1)


func untake_item(index: int) -> void:
	_buttons_container.get_child(index).visible = true


func set_inventory(inventory: IterationInventory) -> void:
	_inventory = inventory

	var i = 0
	for item in _inventory.items:
		if item.hobby == InventoryObject.Hobby.HOBBY_ALL or Globals.hobbies.has(item.hobby):
			_create_button(item, i)
			i += 1


func clear() -> void:
	for button in _buttons_container.get_children():
		button.queue_free()


func _input(event: InputEvent) -> void:
	if event is not InputEventMouseMotion:
		return

	_description.global_position = event.position
	_description.global_position.y -= _description.size.y


func _set_description(item: InventoryObject) -> void:
	%Title.text = "[wave amp=30.0 freq=5.0 connected=1]" + item.title + "[/wave]"
	%Description.text = item.description


func _create_button(item: InventoryObject, index: int) -> void:
	var button = TextureButton.new()
	button.custom_maximum_size = Vector2(button_max_size, button_max_size)
	button.texture_normal = item.inventory_image
	button.texture_hover = item.inventory_image
	button.texture_pressed = item.inventory_image
	button.texture_focused = item.inventory_image
	button.texture_disabled = item.inventory_image
	button.stretch_mode = TextureButton.STRETCH_SCALE

	button.pressed.connect(func ():
		item_selected.emit(item, index)
		button.queue_free()
	)

	button.mouse_entered.connect(func ():
		_set_description(item)
		_description.visible = true
	)

	button.mouse_exited.connect(func ():
		_description.visible = false
	)

	_buttons_container.add_child(button)
