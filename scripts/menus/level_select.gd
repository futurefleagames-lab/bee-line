extends Control


#with recent modifications (11/19/26), some nodes in the level_select scene
#may be unnecessary. Feel free to remove them if you identify such nodes
#For now, I am simply leaving them just in case - Nate

@onready var world_select = $VBoxContainer
@onready var level_select = $VBoxContainer2


var selected: int = 1

func _ready() -> void:
	world_select.show()
	level_select.hide()
	$VBoxContainer/World1.grab_focus()

func select_world(world: int) -> void:
	selected = world
	
	world_select.hide()
	level_select.show()
	
	$VBoxContainer2/Level1.grab_focus()
	


func _on_world_1_pressed() -> void:
	select_world(1)


func _on_world_2_pressed() -> void:
	select_world(2)


func _on_world_3_pressed() -> void:
	select_world(3)


func _on_level_1_pressed() -> void:
	LevelManager.load_level(selected, 1)


func _on_level_2_pressed() -> void:
	LevelManager.load_level(selected, 2)


func _on_level_3_pressed() -> void:
	LevelManager.load_level(selected, 3)
	
func _on_level_4_pressed() -> void:
	LevelManager.load_level(selected, 4)
	
func _on_level_5_pressed() -> void:
	LevelManager.load_level(selected, 5)


func _on_back_pressed() -> void:
	level_select.hide()
	world_select.show()
	$VBoxContainer/World1.grab_focus()


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
