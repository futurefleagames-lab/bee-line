extends CanvasLayer

@export var medal_ui_scene: PackedScene

#to modify
@onready var menu: Control = $Control
@onready var time_label: Label = $Control/PanelContainer/VBoxContainer/time
@onready var medal_label: Label = $Control/PanelContainer/VBoxContainer/medal

@onready var placeholder1: Label = $Control/PanelContainer/VBoxContainer/placeholder1
@onready var reward_spacer: Label = $Control/PanelContainer/VBoxContainer/placeholder2
@onready var placeholder3: Label = $Control/PanelContainer/VBoxContainer/placeholder3
@onready var placeholder4: Label = $Control/PanelContainer/VBoxContainer/placeholder4


@onready var fade: Control = $"../LevelHud/Fade"
@onready var fade_animation: AnimationPlayer = $"../LevelHud/Fade/AnimationPlayer"

var medal_ui: CanvasLayer

func _ready() -> void:
	
	placeholder1.hide()
	placeholder3.hide()
	placeholder4.hide()
	reward_spacer.custom_minimum_size = Vector2(0, 108)

	if medal_ui_scene == null:
		push_warning("need medal.tscn")
		return

	var instance := medal_ui_scene.instantiate()
	if not instance is CanvasLayer:
		push_error("The medal_ui.tscn still need")
		instance.queue_free()
		return

	medal_ui = instance as CanvasLayer
	add_child(medal_ui)

func results(completion: float, medal: String) -> void:
	time_label.text = "Time: %.2f" % completion

	var earned := medal.strip_edges().to_lower()
	medal_label.text = "" if earned == "none" else earned.capitalize() + " Medal"

	menu.show()
	$Control/PanelContainer/VBoxContainer/next.grab_focus()
	await get_tree().process_frame

	if medal_ui == null:
		return

	medal_ui.call("hide_medal")
	
	if earned == "bronze":
		medal_ui.call("show_medal_at", reward_spacer.get_global_rect().get_center())
		

func _on_restart_pressed() -> void:
	get_tree().paused = true
	fade.show()
	fade_animation.play("fade_out")
	await fade_animation.animation_finished
	fade.hide()
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_next_pressed() -> void:
	get_tree().paused = true
	fade.show()
	fade_animation.play("fade_out")
	await fade_animation.animation_finished
	fade.hide()
	LevelManager.next()


func _on_exit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menus/level_select.tscn")
