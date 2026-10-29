extends Control


@onready var _hobbies = $VBoxContainer/HBoxContainer4
@onready var _finish_button = $VBoxContainer/Button

var _name_ok: bool = false
var _age_ok: bool = false
var _pronouns_ok: bool = false
var _ok: bool = false


func _on_button_pressed() -> void:
	Globals.cool_name = %NameEdit.text
	Globals.pronouns = %Pronouns.get_item_text(%Pronouns.selected)
	Globals.age = %Age.get_item_text(%Age.selected)

	for i in _hobbies.get_child_count():
		if i == 0:
			continue
		var checkbox = _hobbies.get_child(i)
		if checkbox.button_pressed:
			if checkbox.text == "Musique":
				Globals.hobbies.push_back(InventoryObject.Hobby.HOBBY_MUSIC)
			if checkbox.text == "Pêche":
				Globals.hobbies.push_back(InventoryObject.Hobby.HOBBY_FISHING)
			if checkbox.text == "Drague":
				Globals.hobbies.push_back(InventoryObject.Hobby.HOBBY_FLIRT)
			if checkbox.text == "Mafia":
				Globals.hobbies.push_back(InventoryObject.Hobby.HOBBY_MAFIA)
			if checkbox.text == "Films":
				Globals.hobbies.push_back(InventoryObject.Hobby.HOBBY_MOVIES)
			if checkbox.text == "Jeux":
				Globals.hobbies.push_back(InventoryObject.Hobby.HOBBY_GAMES)
			if checkbox.text == "Lecture":
				Globals.hobbies.push_back(InventoryObject.Hobby.HOBBY_READING)
			if checkbox.text == "Couture":
				Globals.hobbies.push_back(InventoryObject.Hobby.HOBBY_COUTURE)
			if checkbox.text == "Sport":
				Globals.hobbies.push_back(InventoryObject.Hobby.HOBBY_SPORT)

	get_tree().change_scene_to_file("res://scenes/paint/paint_root.tscn")


func _on_name_edit_text_changed(new_text: String) -> void:
	if new_text.length() > 0:
		_name_ok = true
	_ok = _name_ok and _age_ok and _pronouns_ok
	_finish_button.disabled = not _ok


func _on_age_item_selected(index: int) -> void:
	if index != -1:
		_age_ok = true
	_ok = _name_ok and _age_ok and _pronouns_ok
	_finish_button.disabled = not _ok


func _on_pronouns_item_selected(index: int) -> void:
	if index != -1:
		_pronouns_ok = true
	_ok = _name_ok and _age_ok and _pronouns_ok
	_finish_button.disabled = not _ok
