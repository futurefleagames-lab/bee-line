extends Node2D


#this is a placeholder scene for whenever 
#we are ready to create a level/course


# level assigns different medal reward depending level completion time from completion area trigger

#these values can be reconfigured in the level scenes by accessing:
#LevelTemplate node -> inspector
@export var gold_time: float = 20.0
@export var silver_time: float = 30.0
@export var bronze_time: float = 45.0

var elapsed_time: float = 0.0
var level_finished = false

@onready var timer_label: Label = $LevelHud/timerlabel
@onready var complete = $LevelComplete

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not level_finished:
		elapsed_time += delta
	timer_label.text = "%.2f" % elapsed_time

func finish_level():
	if level_finished:
		return

	level_finished = true
	var medal_earned: String = "none"

	if elapsed_time <= gold_time:
		medal_earned = "Gold"
		

	elif elapsed_time <= silver_time:
		medal_earned = "Silver"
		

	elif elapsed_time <= bronze_time:
		medal_earned = "Bronze"
		
	complete.results(elapsed_time, medal_earned)
	get_tree().paused = true

func _ready() -> void:
	print("Running: ", scene_file_path)
	
