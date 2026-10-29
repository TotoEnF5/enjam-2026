class_name InventoryObject
extends Resource


@export var inventory_image: Texture2D
@export var placeable_object: PackedScene
@export var title: String
@export_multiline var description: String


func _init(texture: Texture2D = null, object: PackedScene = null, _title: String = "Title", _description: String = "Description") -> void:
	inventory_image = texture
	placeable_object = object
	title = _title
	description = _description
