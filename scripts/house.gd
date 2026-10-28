extends Node3D


@onready var _objects = $Objects
@onready var _object_mover = $ObjectMover


func _on_inventory_item_selected(item_scene: PackedScene) -> void:
	var object = item_scene.instantiate()
	_objects.add_child(object)
	_object_mover.set_current_object(object)
