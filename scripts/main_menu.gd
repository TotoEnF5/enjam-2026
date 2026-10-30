extends Control
@export var anim : AnimationPlayer
@export var anim2 : AnimationPlayer

var cred : bool = false
var t_haut : bool = false
var t_mid : bool = false
var t_bas : bool = false


func _ready() -> void:
	MusicPlayer.play_menu()


func _on_button_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/character_creator.tscn")


func _on_button_credits_pressed() -> void:
	if cred == false :
		anim2.play("Spawn_credits")
		cred = true
	elif cred == true :
		anim2.play_backwards("Spawn_credits")
		cred = false
	pass # Replace with function body.


func _on_button_quit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.


func _on_button_pressed() -> void:
	anim.play_backwards("Spawn_credits")
	cred = false
	pass # Replace with function body.


func _on_button_play_mouse_entered() -> void:
	if t_haut == false :
		anim.play("tiroir_haut")
		t_haut = true
	pass # Replace with function body.


func _on_button_play_mouse_exited() -> void:
	if t_haut == true :
		anim.play_backwards("tiroir_haut")
		t_haut = false
	pass # Replace with function body.


func _on_button_credits_mouse_entered() -> void:
	if t_mid == false :
		anim.play("tiroir_mid")
		t_mid = true
	pass # Replace with function body.


func _on_button_credits_mouse_exited() -> void:
	if t_mid == true :
		anim.play_backwards("tiroir_mid")
		t_mid = false
	pass # Replace with function body.


func _on_button_quit_mouse_entered() -> void:
	if t_bas == false :
		anim.play("tiroir_bas")
		t_bas = true
	pass # Replace with function body.


func _on_button_quit_mouse_exited() -> void:
	if t_bas == true :
		anim.play_backwards("tiroir_bas")
		t_bas = false
	pass # Replace with function body.
