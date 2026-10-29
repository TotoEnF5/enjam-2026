class_name InventoryObject
extends Resource


enum Hobby {
	HOBBY_ALL,
	HOBBY_MUSIC,
	HOBBY_FISHING,
	HOBBY_FLIRT,
	HOBBY_MAFIA,
	HOBBY_MOVIES,
	HOBBY_GAMES,
	HOBBY_READING,
	HOBBY_COUTURE,
	HOBBY_SPORT,
}


@export var inventory_image: Texture2D
@export var placeable_object: PackedScene
@export var hobby: Hobby
@export var title: String
@export_multiline var description: String


func _init(texture: Texture2D = null, object: PackedScene = null, _title: String = "Title", _description: String = "Description") -> void:
	inventory_image = texture
	placeable_object = object
	title = _title
	description = _description
