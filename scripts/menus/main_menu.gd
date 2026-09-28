extends Control


func _on_quitbutton_pressed() -> void:
	get_tree().quit()

func _on_playbutton_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/level_select.tscn") # Replace with function body.


func _on_optionsbutton_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/options_menu.tscn") # Replace with function body.
