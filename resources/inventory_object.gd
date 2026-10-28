class_name InventoryObject
extends Resource


@export var inventory_image: Texture2D
@export var placeable_object: PackedScene


func _init(texture: Texture2D = null, object: PackedScene = null) -> void:
	inventory_image = texture
	placeable_object = object
