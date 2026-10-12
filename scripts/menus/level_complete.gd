extends CanvasLayer

#to modify
@onready var menu: Control = $Control
@onready var time_label: Label = $Control/PanelContainer/VBoxContainer/time
@onready var medal_label: Label = $Control/PanelContainer/VBoxContainer/medal

func results(completion: float, medal: String) -> void:
	time_label.text = "Time: %.2f" % completion
	
	if medal == "none":
		medal_label.text = ""
	else:
		medal_label.text = medal.capitalize() + " Medal"
	menu.show()
	$Control/PanelContainer/VBoxContainer/next.grab_focus()
		

func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_next_pressed() -> void:
	LevelManager.next()


func _on_exit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menus/level_select.tscn")
