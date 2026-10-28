extends Node3D


@onready var _mesh = $MeshInstance3D


func target() -> void:
	var material = _mesh.get_surface_override_material(0)
	material.albedo_color = Color.RED


func untarget() -> void:
	var material = _mesh.get_surface_override_material(0)
	material.albedo_color = Color.WHITE
