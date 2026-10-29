extends Control


@onready var _hobbies = $VBoxContainer/HBoxContainer4


func _on_button_pressed() -> void:
	Globals.cool_name = %NameEdit.text
	Globals.pronouns = %Pronouns.get_item_text(%Pronouns.selected)
	Globals.age = %Age.get_item_text(%Age.selected)

	for i in _hobbies.get_child_count():
		if i == 0:
			continue
		var checkbox = _hobbies.get_child(i)
		if checkbox.button_pressed:
			Globals.hobbies.push_back(checkbox.text)

	get_tree().change_scene_to_file("res://scenes/paint/paint_root.tscn")
