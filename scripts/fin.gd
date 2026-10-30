extends Control

# Références réelles vers tes nœuds
@onready var _prenom: RichTextLabel = $VBoxContainer/RichTextLabel
@onready var _mort: RichTextLabel = $VBoxContainer/RichTextLabel2
@onready var _gertrude: TextureRect = %TextureRect
@onready var _color_rect: ColorRect = $ColorRect


func _ready() -> void:
	MusicPlayer.play_gertrude()

	if Globals.painting:
		_gertrude.texture = ImageTexture.create_from_image(Globals.painting)

	_prenom.text = _prenom.text.replace("[Prénom]", Globals.cool_name)
	_mort.text = "n'est plus là, mais vous avez eu l'occasion de garder ses souvenirs avec vous. Lui avez-vous fait une place dans votre vie bien remplie ?"

func _on_button_pressed() -> void:
	$ColorRect.mouse_filter = MOUSE_FILTER_STOP
	var tween = get_tree().create_tween()
	tween.tween_property($ColorRect, "color", Color.BLACK, 1)
	tween.tween_callback(func ():
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file("res://scenes/house.tscn")
	)
