extends Node3D


@export var camera: Camera3D
@export var raycast_length: float = 1000


func _input(event: InputEvent) -> void:
	if event is not InputEventMouseButton:
		return

	var mouse_event: InputEventMouseButton = event
	if not mouse_event.pressed:
		_raycast(mouse_event.position)


func _raycast(mouse_pos: Vector2) -> void:
	var space = get_world_3d().direct_space_state
	var origin = camera.project_ray_origin(mouse_pos)
	var end = origin + camera.project_ray_normal(mouse_pos) * raycast_length

	var query = PhysicsRayQueryParameters3D.create(origin, end)
	var result = space.intersect_ray(query)

	if not result:
		return

	var object = result.collider.get_parent()
