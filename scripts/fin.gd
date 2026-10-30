extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%TextureRect.texture = ImageTexture.create_from_image(Globals.painting)
