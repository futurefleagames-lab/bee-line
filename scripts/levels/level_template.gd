extends Node2D


# level assigns different medal reward depending level completion time from completion area trigger

#these values can be reconfigured in the level scenes by accessing:
#LevelTemplate node -> inspector
@export var gold_time: float = 20.0
@export var silver_time: float = 30.0
@export var bronze_time: float = 45.0

var elapsed_time: float = 0.0
var level_finished: bool = false

var timer_paused: bool = false
var duration: int = 3

@onready var timer_label: Label = $LevelHud/timerlabel
@onready var complete = $LevelComplete

@onready var fade: Control = $LevelHud/Fade
@onready var fade_animation: AnimationPlayer = $LevelHud/Fade/AnimationPlayer
@onready var overlay: Control = $LevelHud/Countdown
@onready var cdlabel: Label = $LevelHud/Countdown/cdlabel


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not level_finished and not timer_paused:
		elapsed_time += delta
	timer_label.text = "%.2f" % elapsed_time



func countdown_start() -> void:
	timer_paused = true
	overlay.show()
	get_tree().paused = true
	run_countdown()

func run_countdown() -> void:
	
	for number in range(duration, 0, -1):
		cdlabel.text = str(number)
		await get_tree().create_timer(0.5, true).timeout
	overlay.hide()
	timer_paused = false
	get_tree().paused = false #resume gameplay

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
	timer_paused = true
	get_tree().paused = true
	fade.show()
	fade_animation.play("fade_in")
	await fade_animation.animation_finished
	fade.hide()
	if State.skip_countdown:
		State.skip_countdown = false
		overlay.hide()
		timer_paused = false
		get_tree().paused = false
	else:
		countdown_start()
	#timer_paused = false
	#get_tree().paused = false
