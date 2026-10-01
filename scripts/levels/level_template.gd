extends Node2D


#this is a placeholder scene for whenever 
#we are ready to create a level/course


# level assigns different medal reward depending level completion time from completion area trigger

@export var gold_time: float = 20.0
@export var silver_time: float = 30.0
@export var bronze_time: float = 45.0

var elapsed_time: float = 0.0
var level_finished = false

@onready var medal_ui = $MedalUI
@onready var timer_label: Label = $LevelHud/timerlabel

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not level_finished:
		elapsed_time += delta
	timer_label.text = "%.2f" % elapsed_time

func finish_level():
	if level_finished:
		return

	level_finished = true

	if elapsed_time <= gold_time:
		print("Level complete - gold medal")
		#medal_ui.show_medal("gold")

	elif elapsed_time <= silver_time:
		print("Level complete - silver medal")
		#medal_ui.show_medal("silver")

	elif elapsed_time <= bronze_time:
		print("Level complete - bronze medal")
		#medal_ui.show_medal("bronze")

	else:
		print("Level complete - no medal")
