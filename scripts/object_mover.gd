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

var _place_audio: AudioStreamPlayer
var _yeet_audio: AudioStreamPlayer


func set_current_object(object: Node3D) -> void:
	_current_object = object
	_initial_object_pos = _current_object.position
	_current_object.take()



func _ready() -> void:
	_place_audio = AudioStreamPlayer.new()
	_yeet_audio = AudioStreamPlayer.new()
	add_child(_place_audio)
	add_child(_yeet_audio)


func _input(event: InputEvent) -> void:
	if event is not InputEventMouse:
		return

	if event is InputEventMouseMotion:
		if _current_object != null:
			if _targeted_snapper == null:
				var mouse_pos = get_viewport().get_mouse_position()
				var pos = camera.project_ray_origin(mouse_pos)
				_current_object.position = pos + camera.project_ray_normal(mouse_pos) * 10
			else:
				if _targeted_snapper != null:


					if _targeted_snapper.has_object:
						var mouse_pos = get_viewport().get_mouse_position()
						var pos = camera.project_ray_origin(mouse_pos)
						_current_object.position = pos + camera.project_ray_normal(mouse_pos) * 10
						return

						if _targeted_snapper.is_poubelle \
					or (_targeted_snapper.is_floor \
					and _current_object.item.on_floor) \
					or (_targeted_snapper.is_etagere \
					and _current_object.item.on_etagere) \
					or (_targeted_snapper.is_wall \
					and _current_object.item.on_wall):
						_current_object.global_position = _targeted_snapper.global_position
						_current_object.global_rotation = _targeted_snapper.global_rotation
					else:
						var mouse_pos = get_viewport().get_mouse_position()
						var pos = camera.project_ray_origin(mouse_pos)
						_current_object.position = pos + camera.project_ray_normal(mouse_pos) * 10
		else:
			if _targeted_object != null:
				inventory.item_hovered(_targeted_object.item)
			else:
				inventory.item_not_hovered()


	if event is InputEventMouseButton:
		if not event.pressed:
			return

		if event.button_index == MOUSE_BUTTON_LEFT:
			if _current_object == null and _targeted_object != null:
				set_current_object(_targeted_object)
				_targeted_snapper.has_object = false
			else:
				if _targeted_snapper != null:

					if _targeted_snapper.has_object:
						return
					if _targeted_snapper.is_poubelle \
					or (_targeted_snapper.is_floor \
					and _current_object.item.on_floor) \
					or (_targeted_snapper.is_etagere \
					and _current_object.item.on_etagere) \
					or (_targeted_snapper.is_wall \
					and _current_object.item.on_wall):
						_current_object.global_position = _targeted_snapper.global_position
						_current_object.global_rotation = _targeted_snapper.global_rotation
						if _targeted_snapper.is_poubelle:
							_yeet_audio.stream = _current_object.item.yeet_audio_streams
							_yeet_audio.play()
							_current_object.queue_free()
							_current_object = null
							_targeted_snapper = null
						else:
							_place_audio.stream = _current_object.item.place_audio_streams
							_place_audio.play()
							_current_object.global_position = _targeted_snapper.global_position
							_current_object.global_rotation = _targeted_snapper.global_rotation
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
