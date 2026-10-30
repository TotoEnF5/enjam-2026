extends Node3D


@export var is_portrait: bool = false

var item: InventoryObject
var inventory_index: int

@onready var _static_body = $StaticBody3D


func _ready() -> void:
	if is_portrait:
		var mesh: MeshInstance3D = get_child(0).get_child(0)
		var material: StandardMaterial3D = mesh.get_active_material(1)
		material.albedo_texture = ImageTexture.create_from_image(Globals.painting)


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
