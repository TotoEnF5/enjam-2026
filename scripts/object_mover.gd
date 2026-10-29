extends Node3D


@export var inventory: Control
@export var camera: Camera3D
@export var raycast_length: float = 1000


const _OBJECT_MASK: int = 0b1
const _SNAPPER_MASK: int = 0b10

var _current_object: Node3D = null
var _targeted_object: Node3D = null

var _targeted_snapper: Node3D = null

var _initial_object_pos: Vector3


func set_current_object(object: Node3D) -> void:
	_current_object = object
	_initial_object_pos = _current_object.position
	_current_object.take()


func _input(event: InputEvent) -> void:
	if event is not InputEventMouse:
		return

	if event is InputEventMouseMotion:
		if _current_object != null:
			if _targeted_snapper == null:
				var mouse_pos = get_viewport().get_mouse_position()
				var pos = camera.project_ray_origin(mouse_pos)
				_current_object.position = pos + camera.project_ray_normal(mouse_pos) * 2
			else:
				if _targeted_snapper != null:
					_current_object.position = _targeted_snapper.position


	if event is InputEventMouseButton:
		if not event.pressed:
			return

		if event.button_index == MOUSE_BUTTON_LEFT:
			if _current_object == null and _targeted_object != null:
				set_current_object(_targeted_object)
			else:
				if _targeted_snapper != null:
					_current_object.position = _targeted_snapper.position
					_current_object.untake()
					_current_object = null
					_targeted_snapper = null

		if event.button_index == MOUSE_BUTTON_RIGHT:
			if _current_object == null:
				return

			inventory.place_item(_current_object.item)
			_current_object.queue_free()
			_current_object = null


func _physics_process(delta: float) -> void:
	if _current_object == null:
		var object = _raycast(_OBJECT_MASK)
		if object != null:
			if _targeted_object != null:
				_targeted_object.untarget()

			_targeted_object = object
			_targeted_object.target()
		else:
			if _targeted_object != null:
				_targeted_object.untarget()
			_targeted_object = null
	else:
		var snapper = _raycast(_SNAPPER_MASK)
		_targeted_snapper = snapper

	
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
