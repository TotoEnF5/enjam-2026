extends Node3D


@export var camera: Camera3D
@export var raycast_length: float = 1000


const _OBJECT_MASK: int = 0b1
const _SNAPPER_MASK: int = 0b01

var _current_object: Node3D = null
var _targeted_object: Node3D = null


func _input(event: InputEvent) -> void:
	if event is not InputEventMouse:
		return

	if event.is_pressed():
		if _targeted_object != _current_object:
			_current_object = _targeted_object


	if _current_object != null:
		var mouse_pos = get_viewport().get_mouse_position()
		var pos = camera.project_ray_origin(mouse_pos)
		_current_object.position = pos + camera.project_ray_normal(mouse_pos) * 2


func _physics_process(delta: float) -> void:
	var object = _raycast(_OBJECT_MASK)
	if object != null:
		if _targeted_object != null:
			_targeted_object.untarget()
		_targeted_object = object
		_targeted_object.target()
	else:
		if _targeted_object != null:
			_targeted_object.untarget()

func _raycast(mask: int) -> Node3D:
	var mouse_pos = get_viewport().get_mouse_position()
	var space = get_world_3d().direct_space_state
	var origin = camera.project_ray_origin(mouse_pos)
	var end = origin + camera.project_ray_normal(mouse_pos) * raycast_length

	var query = PhysicsRayQueryParameters3D.create(origin, end, mask)
	var result = space.intersect_ray(query)

	if not result:
		return null

	var object = result.collider.get_parent()
	return object
