extends Node


var _audio_player: AudioStreamPlayer
var _menu = load("res://assets/audio/Menu + création perso.ogg")
var _iter = [ load("res://assets/audio/Période 1.ogg"), load("res://assets/audio/Période 2.ogg"), load("res://assets/audio/Période 3.ogg") ]
var _gertrude = load("res://assets/audio/Décès Gertrude.ogg")


func _ready() -> void:
	_audio_player = AudioStreamPlayer.new()
	add_child(_audio_player)


func play_menu() -> void:
	_audio_player.stream = _menu
	_audio_player.play()


func play_gertrude() -> void:
	_audio_player.stream = _gertrude
	_audio_player.play()


func play_iter(index: int) -> void:
	_audio_player.stream = _iter[index]
	_audio_player.play()
