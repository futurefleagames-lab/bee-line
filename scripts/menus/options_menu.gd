extends Control

func _ready() -> void:
	%Quit.grab_focus()

#this script ought to handle most, if not everything in the options menu


#CONTROL

var assignment_change: StringName = &""
var button_change: Button
const THRESHOLD := .5

func rebind(action: StringName, button: Button):
	assignment_change = action
	button_change = button
	button.text = "Press a key"
	

func _input(event):
	if assignment_change == &"":
		return
	var valid := false
	
	#keyboard
	if event is InputEventKey:
		valid = event.pressed and not event.echo
	
	#mouse
	elif event is InputEventMouseButton:
		valid = event.pressed
	
	#controller buttons
	elif event is InputEventJoypadButton:
		valid = event.pressed
	
	#controller sticks/triggers
	elif event is InputEventJoypadMotion:
		valid = abs(event.axis_value) >= THRESHOLD
	
	if not valid:
		return
	
	#replace old binding with new
	InputMap.action_erase_events(assignment_change)
	InputMap.action_add_event(assignment_change, event)
	
	button_change.text = event.as_text()
	assignment_change = &""
	button_change = null
	
	#don't let this input continue into the UI/game
	get_viewport().set_input_as_handled()

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



#VIDEO



#AUDIO



#return player to start scene
func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
	
