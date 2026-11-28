extends Control

func _ready() -> void:
	%Quit.grab_focus()
	load_video_settings()
	load_audio_settings()

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
func _on_display_mode_item_selected(index: int) -> void:
	if index == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		SaveSystem.temporary_keys["display mode"] = "windowed"
	elif index ==1:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		SaveSystem.temporary_keys["display mode"] = "fullscreen"
		
	SaveSystem.save_file()
	

func update_vsync_color():
	if %VSync.button_pressed:
		%VSync.self_modulate = Color.LAWN_GREEN
	else:
		%VSync.self_modulate = Color.WHITE




#AUDIO
func change_volume(bus_name: String, value: float):
	var bus_index = AudioServer.get_bus_index(bus_name)
	
	if bus_index == -1:
		return
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value / 100.0))
	AudioServer.set_bus_mute(bus_index, value == 0)
	
func load_audio_settings():
	%MasterVolume.set_value_no_signal(
		SaveSystem.temporary_keys["master volume"]
	)
	%MusicVolume.set_value_no_signal(
		SaveSystem.temporary_keys["music volume"]
	)
	%SFXVolume.set_value_no_signal(
		SaveSystem.temporary_keys["sfx volume"]
	)
	# test case
	#print("master: ", SaveSystem.temporary_keys["master volume"])
	#print("music: ", SaveSystem.temporary_keys["music volume"])
	#print("SFX: ", SaveSystem.temporary_keys["sfx volume"])



#return player to start scene
func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
	


#func _on_display_mode_item_selected(index: int) -> void:
	#pass # Replace with function body.

const FPS_OPTIONS = [30, 60, 120, 144, 0]
func _on_frame_rate_item_selected(index: int) -> void:
	Engine.max_fps = FPS_OPTIONS[index]
	SaveSystem.temporary_keys["frame rate"] = FPS_OPTIONS[index]
	SaveSystem.save_file()
	
func load_video_settings():
	var mode = SaveSystem.temporary_keys["display mode"]
	var fps = SaveSystem.temporary_keys["frame rate"]
	
	if mode == "fullscreen":
		%DisplayMode.select(1)
	else:
		%DisplayMode.select(0)
		
	var fps_index = FPS_OPTIONS.find(fps)
	
	if fps_index != -1:
		%FrameRate.select(fps_index)
	else:
		%FrameRate.select(1)
		
	%VSync.set_pressed_no_signal(SaveSystem.temporary_keys["vsync"])
	update_vsync_color()
	
	


func _on_v_sync_toggled(toggled_on: bool) -> void:
	SaveSystem.temporary_keys["vsync"] = toggled_on
	
	if toggled_on:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		
	SaveSystem.save_file()
	
	update_vsync_color()


	

	


func _on_master_volume_value_changed(value: float) -> void:
	change_volume("Master", value)
	SaveSystem.temporary_keys["master volume"] = value
	SaveSystem.save_file()
	
	
func _on_music_volume_value_changed(value: float) -> void:
	change_volume("Music", value)
	SaveSystem.temporary_keys["music volume"] = value
	SaveSystem.save_file()
	
func _on_sfx_volume_value_changed(value: float) -> void:
	change_volume("SFX", value)
	SaveSystem.temporary_keys["sfx volume"] = value
	SaveSystem.save_file()
