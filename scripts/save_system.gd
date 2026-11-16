extends Node

const SAVE_PATH = "user://save_file.json"

var temporary_keys: Dictionary = {
	#level medals and times
	"1-1 medal": "none",
	"1-1 best time": -1.0,
	"1-2 medal": "none",
	"1-2 best time": -1.0,
	"1-3 medal": "none",
	"1-3 best time": -1.0,
	"1-4 medal": "none",
	"1-4 best time": -1.0,
	"1-5 medal": "none",
	"1-5 best time": -1.0,
	
	"2-1 medal": "none",
	"2-1 best time": -1.0,
	"2-2 medal": "none",
	"2-2 best time": -1.0,
	"2-3 medal": "none",
	"2-3 best time": -1.0,
	"2-4 medal": "none",
	"2-4 best time": -1.0,
	"2-5 medal": "none",
	"2-5 best time": -1.0,
	
	"3-1 medal": "none",
	"3-1 best time": -1.0,
	"3-2 medal": "none",
	"3-2 best time": -1.0,
	"3-3 medal": "none",
	"3-3 best time": -1.0,
	"3-4 medal": "none",
	"3-4 best time": -1.0,
	"3-5 medal": "none",
	"3-5 best time": -1.0,
	
	#audio settings
	"music volume": 100.0,
	"sfx volume": 100.0,
	"master volume": 100.0,
	
	#video settings
	"display mode": "windowed",
	"frame rate": 60
}

func save_file():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(temporary_keys.duplicate())
	file.close()

func load_file():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		var data = file.get_var()
		file.close()
		
		var save_data = data.duplicate()
		temporary_keys.set("1-1 medal", save_data.get("1-1 medal"))
		temporary_keys.set("1-1 best time", save_data.get("1-1 best time"))
		temporary_keys.set("1-2 medal", save_data.get("1-2 medal"))
		temporary_keys.set("1-2 best time", save_data.get("1-2 best time"))
		temporary_keys.set("1-3 medal", save_data.get("1-3 medal"))
		temporary_keys.set("1-3 best time", save_data.get("1-3 best time"))
		temporary_keys.set("1-4 medal", save_data.get("1-4 medal"))
		temporary_keys.set("1-4 best time", save_data.get("1-4 best time"))
		temporary_keys.set("1-5 medal", save_data.get("1-5 medal"))
		temporary_keys.set("1-5 best time", save_data.get("1-5 best time"))
		
		temporary_keys.set("2-1 medal", save_data.get("2-1 medal"))
		temporary_keys.set("2-1 best time", save_data.get("2-1 best time"))
		temporary_keys.set("2-2 medal", save_data.get("2-2 medal"))
		temporary_keys.set("2-2 best time", save_data.get("2-2 best time"))
		temporary_keys.set("2-3 medal", save_data.get("2-3 medal"))
		temporary_keys.set("2-3 best time", save_data.get("2-3 best time"))
		temporary_keys.set("2-4 medal", save_data.get("2-4 medal"))
		temporary_keys.set("2-4 best time", save_data.get("2-4 best time"))
		temporary_keys.set("2-5 medal", save_data.get("2-5 medal"))
		temporary_keys.set("2-5 best time", save_data.get("2-5 best time"))
		
		temporary_keys.set("3-1 medal", save_data.get("3-1 medal"))
		temporary_keys.set("3-1 best time", save_data.get("3-1 best time"))
		temporary_keys.set("3-2 medal", save_data.get("3-2 medal"))
		temporary_keys.set("3-2 best time", save_data.get("3-2 best time"))
		temporary_keys.set("3-3 medal", save_data.get("3-3 medal"))
		temporary_keys.set("3-3 best time", save_data.get("3-3 best time"))
		temporary_keys.set("3-4 medal", save_data.get("3-4 medal"))
		temporary_keys.set("3-4 best time", save_data.get("3-4 best time"))
		temporary_keys.set("3-5 medal", save_data.get("3-5 medal"))
		temporary_keys.set("3-5 best time", save_data.get("3-5 best time"))
		
		temporary_keys.set("music volume", save_data.get("music volume"))
		temporary_keys.set("sfx volume", save_data.get("sfx volume"))
		temporary_keys.set("master volume", save_data.get("master volume"))
		
		temporary_keys.set("display mode", save_data.get("display mode"))
		temporary_keys.set("frame rate", save_data.get("frame rate"))

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_file()
	save_file()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
