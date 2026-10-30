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
@export var title: String:
	set(value):
		title = _replace_desc("[b]" + value + "[/b]")
@export_multiline var description: String:
	set(value):
		description = _replace_desc(value)

@export var on_floor: bool = true
@export var on_etagere: bool = true
@export var on_wall: bool = false


func _init(texture: Texture2D = null, object: PackedScene = null, _title: String = "Title", _description: String = "Description") -> void:
	inventory_image = texture
	placeable_object = object
	title = _replace_desc(_title)
	description = _replace_desc(_description)
	

func _replace_desc(desc: String) -> String:
	var new_desc = desc.replace("[Prénom]", "[wave amp=20.0 freq=5.0 connected=1][b][color=deep_sky_blue]" + Globals.cool_name + "[/color][/b][/wave]")
	new_desc = new_desc.replace("[Pronom]", Globals.pronouns)
	return new_desc
