extends Control

#this script ought to handle most, if not everything in the options menu


#handle keybindings
var assignment_change: StringName = &""
var button_change: Button

func rebind(action: StringName, button: Button):
	assignment_change = action
	button_change = button
	button.text = "Press a key"
	
func _input(event):
	if assignment_change == &"":
		return
	if event is InputEventKey and event.pressed:
		InputMap.action_erase_events(assignment_change)
		InputMap.action_add_event(assignment_change, event)
		button_change.text = event.as_text()
		assignment_change = &""
		button_change = null
		

func _on_upbutton_pressed():
	rebind(&"up", %upbutton)


func _on_downbutton_pressed():
	rebind(&"down", %downbutton)


func _on_rightbutton_pressed():
	rebind(&"right", %rightbutton)


func _on_leftbutton_pressed():
	rebind(&"left", %leftbutton)


func _on_dashbutton_pressed():
	rebind(&"dash", %dashbutton)


func _on_resetbutton_pressed():
	rebind(&"reset", %resetbutton)

#return player to start scene
func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/main_menu.tscn")
	
