extends Node3D


@onready var _objects = $Objects
@onready var _object_mover = $ObjectMover
@onready var _inventory = $CanvasLayer/Inventory


func _on_inventory_item_selected(item_scene: PackedScene, index: int) -> void:
	var object = item_scene.instantiate()
	object.inventory_index = index
	_objects.add_child(object)
	_object_mover.set_current_object(object)
	_inventory.take_item(index)
