extends Control


func _ready() -> void:
	%play.grab_focus()

func _on_quitbutton_pressed() -> void:
	get_tree().quit()


func _on_optionsbutton_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/options_menu.tscn")


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/level_select.tscn")
