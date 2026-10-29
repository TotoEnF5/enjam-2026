extends Control

signal oui_pressed


@onready var _warning = $PanelContainer2


func _on_fini_pressed() -> void:
	_warning.visible = true
	_warning.mouse_filter = MOUSE_FILTER_STOP


func _on_non_pressed() -> void:
	_warning.visible = false
	_warning.mouse_filter = MOUSE_FILTER_IGNORE


func _on_oui_pressed() -> void:
	_warning.visible = false
	_warning.mouse_filter = MOUSE_FILTER_IGNORE
	oui_pressed.emit()
