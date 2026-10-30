extends Node3D


@export var inventories: Array[IterationInventory]

@onready var _objects = $Objects
@onready var _object_mover = $ObjectMover
@onready var _inventory = $CanvasLayer/Inventory
@onready var _hud = $CanvasLayer/HUD
@onready var _color_rect = $CanvasLayer/ColorRect

var _current_iteration: int = 0


func _ready() -> void:
	MusicPlayer.play_iter(0)
	_inventory.set_inventory(inventories[_current_iteration])
	_hud.oui_pressed.connect(_go_to_next_iteration)


func _go_to_next_iteration() -> void:
	_color_rect.mouse_filter = Control.MOUSE_FILTER_STOP
	var tween = get_tree().create_tween()
	tween.tween_property(_color_rect, "color", Color.BLACK, 1)
	tween.tween_callback(func ():
		await get_tree().create_timer(1).timeout

		_current_iteration += 1
		if _current_iteration > 1:
			get_tree().change_scene_to_file("res://scripts/fin.tscn")
			return

		_inventory.clear()
		_inventory.set_inventory(inventories[_current_iteration])

		var clear_tween = get_tree().create_tween()
		clear_tween.tween_property(_color_rect, "color", Color(0, 0, 0, 0), 1)
		clear_tween.tween_callback(func ():
			_color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
			MusicPlayer.play_iter(_current_iteration)
		)
	)


func _on_inventory_item_selected(item: InventoryObject, index: int) -> void:
	var object = item.placeable_object.instantiate()
	object.inventory_index = index
	object.item = item
	_objects.add_child(object)
	_object_mover.set_current_object(object)
