extends Node2D


# level assigns different medal reward depending level completion time from completion area trigger

#these values can be reconfigured in the level scenes by accessing:
#LevelTemplate node -> inspector
@export var gold_time: float = 20.0
@export var silver_time: float = 30.0
@export var bronze_time: float = 45.0

var elapsed_time: float = 0.0
var level_finished: bool = false

#string with last 3 characters before .tscn
@onready var level_id = (scene_file_path.right(8)).left(3)

var timer_paused: bool = false
var duration: int = 3

@onready var timer_label: Label = $LevelHud/timerlabel
@onready var medal_label: Label = $LevelHud/medallabel
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
	if (level_id.left(1)).is_valid_int():
		if elapsed_time < SaveSystem.temporary_keys.get(level_id + " best time") and SaveSystem.temporary_keys.get(level_id + " best time") != -1.0:
			medal_label.text = "Best time: " + "%.2f" % SaveSystem.temporary_keys.get(level_id + " best time")
		elif elapsed_time < gold_time:
			medal_label.text = "Gold time: " + "%.2f" % gold_time
		elif elapsed_time < silver_time:
			medal_label.text = "Silver time: " + "%.2f" % silver_time
		else:
			medal_label.text = "Bronze time: " + "%.2f" % bronze_time

#for time penalty boxes
func add_penalty(amount: float) -> void:
	if level_finished or timer_paused:
		return
	elapsed_time += amount


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
	
	if (level_id.left(1)).is_valid_int():
		if medal_earned == "Gold":
			SaveSystem.temporary_keys.set(level_id + " medal", medal_earned)
		elif medal_earned == "Silver" and SaveSystem.temporary_keys.get(level_id + " medal") != "Gold":
			SaveSystem.temporary_keys.set(level_id + " medal", medal_earned)
		elif medal_earned == "Bronze" and SaveSystem.temporary_keys.get(level_id + " medal") == "none":
			SaveSystem.temporary_keys.set(level_id + " medal", medal_earned)
		if SaveSystem.temporary_keys.get(level_id + " best time") > elapsed_time or SaveSystem.temporary_keys.get(level_id + " best time") == -1.0:
			SaveSystem.temporary_keys.set(level_id + " best time", elapsed_time)
		SaveSystem.save_file()
	complete.results(elapsed_time, medal_earned)
	get_tree().paused = true

func _ready() -> void:
	print("Running: ", scene_file_path)
	print(SaveSystem.temporary_keys.get(level_id + " medal"))
	print(SaveSystem.temporary_keys.get(level_id + " best time"))
	timer_paused = true
	get_tree().paused = true
	fade.show()
	if (level_id.left(1)).is_valid_int():
		if SaveSystem.temporary_keys.get(level_id + " medal") == "Gold":
			medal_label.text = "Best time: " + "%.2f" % SaveSystem.temporary_keys.get(level_id + " best time")
		else:
			medal_label.text = "Gold time: " + "%.2f" % gold_time
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
