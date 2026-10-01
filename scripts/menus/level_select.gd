extends Control

func _ready() -> void:
	%Level0.grab_focus()

func _on_level_0_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_test.tscn") 

func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn") 

func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
