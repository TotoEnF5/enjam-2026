extends Control


@onready var _prenom = $PanelContainer/VBoxContainer/RichTextLabel
@onready var _mort = $PanelContainer/VBoxContainer/RichTextLabel2
@onready var _rip = $PanelContainer/VBoxContainer/Label
@onready var _gertrude = $PanelContainer/VBoxContainer/TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MusicPlayer.play_gertrude()

	_prenom.text = _prenom.text.replace("[Prénom]", Globals.cool_name)
	_gertrude.texture = ImageTexture.create_from_image(Globals.painting)

	if Globals.pronouns == "il":
		_mort.text = "[b][shake rate=20.0 level=50 connected=1]MORT[/shake][/b]"
	if Globals.pronouns == "elle":
		_mort.text = "[b][shake rate=20.0 level=50 connected=1]MORTE[/shake][/b]"
	if Globals.pronouns == "iel":
		_mort.text = "[b][shake rate=20.0 level=50 connected=1]MORT.E[/shake][/b]"
	if Globals.pronouns == "autre chose":
		_mort.text = "[b][shake rate=20.0 level=50 connected=1]MORT.E[/shake][/b]"

	await get_tree().create_timer(3).timeout
	_prenom.visible = true
	await get_tree().create_timer(2).timeout
	_mort.visible = true
	await get_tree().create_timer(2).timeout
	_rip.visible = true
	_gertrude.visible = true
	await get_tree().create_timer(1).timeout
	$Button.visible = true


func _on_button_pressed() -> void:
	$ColorRect.mouse_filter = MOUSE_FILTER_STOP
	var tween = get_tree().create_tween()
	tween.tween_property($ColorRect, "color", Color.BLACK, 1)
	tween.tween_callback(func ():
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file("res://scenes/house.tscn")
	)
