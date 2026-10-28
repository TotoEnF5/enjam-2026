extends Control
@export var anim : AnimationPlayer

var cred : bool = false

func _on_button_play_pressed() -> void:
	pass # Replace with function body.


func _on_button_credits_pressed() -> void:
	if cred == false :
		anim.play("Spawn_credits")
		cred = true
	elif cred == true :
		cred = false
		anim.play_backwards("Spawn_credits")

	pass # Replace with function body.


func _on_button_quit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.


func _on_button_pressed() -> void:
	anim.play_backwards("Spawn_credits")

	pass # Replace with function body.
