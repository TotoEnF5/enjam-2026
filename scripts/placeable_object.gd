extends Node3D


var item: InventoryObject
var inventory_index: int

@onready var _static_body = $StaticBody3D


func target() -> void:
	return


func untarget() -> void:
	return


func take() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	_static_body.collision_layer = 0b100


func untake() -> void:
	process_mode = Node.PROCESS_MODE_INHERIT
	_static_body.collision_layer = 0b1
