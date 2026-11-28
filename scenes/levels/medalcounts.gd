extends Label


func _ready() -> void:
	var gold = SaveSystem.get_medalcount("Gold")
	var silver = SaveSystem.get_medalcount("Silver")
	var bronze = SaveSystem.get_medalcount("Bronze")

	text = "Gold Medals: %d\nSilver Medals: %d\nBronze Medals: %d" % [gold, silver, bronze]
