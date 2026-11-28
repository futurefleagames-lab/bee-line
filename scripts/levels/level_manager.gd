extends Node

#overall level management script. 

const LEVELS = [
	"res://scenes/levels/world_1/level_1-1.tscn",
	"res://scenes/levels/world_1/level_1-2.tscn",
	"res://scenes/levels/world_1/level_1-3.tscn",
	"res://scenes/levels/world_1/level_1-4.tscn",
	"res://scenes/levels/world_1/level_1-5.tscn",
	"res://scenes/levels/world_2/level_2-1.tscn",
	"res://scenes/levels/world_2/level_2-2.tscn",
	"res://scenes/levels/world_2/level_2-3.tscn",
	"res://scenes/levels/world_2/level_2-4.tscn",
	"res://scenes/levels/world_2/level_2-5.tscn",
	"res://scenes/levels/world_3/level_3-1.tscn",
	"res://scenes/levels/world_3/level_3-2.tscn",
	"res://scenes/levels/world_3/level_3-3.tscn",
	"res://scenes/levels/world_3/level_3-4.tscn",
	"res://scenes/levels/world_3/level_3-5.tscn"
]

#decide which level to load assuming player has selected 'next level'
func next() -> void:
	var current = get_tree().current_scene
	var where = LEVELS.find(current.scene_file_path)
	get_tree().paused = false
	
	if where >= 0 and where + 1 < LEVELS.size():
		get_tree().change_scene_to_file(LEVELS[where + 1])
	else:
		#we can possibly change this to a "victory" scene later, or something else
		get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")


#decide which level to load from level select menu
func load_level(world: int, level: int) -> void:
	var index = (world - 1) * 5 + (level - 1) #this will have to change if there are any more than 5 levels per world
	
	if index < 0 or index >= LEVELS.size():
		return
		
	get_tree().paused = false
	get_tree().change_scene_to_file(LEVELS[index])
	
func load_lounge() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/levels/winners_lounge.tscn")
