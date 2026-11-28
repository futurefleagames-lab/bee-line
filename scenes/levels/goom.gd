extends Node2D


#goom.




@export var goom_normal: Texture2D
@export var goom_pleased: Texture2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var label: Label = $goomtext

func _ready() -> void:
	#don't uncomment unless you wish for the game to believe the player has 15 gold medals for this session
	#for world in range(1, 4):
		#for level in range(1, 6):
			#SaveSystem.temporary_keys["%d-%d medal" % [world, level]] = "Gold"

	if SaveSystem.all_gold():
		sprite.texture = goom_pleased
		label.text = 'This is Goom. He stands in awe of your displayed perseverance and determination in earning a "Gold Medal" in every course!'
	else:
		sprite.texture = goom_normal
		label.text = 'This is Goom. He recognizes your accomplishments, however, he is disappointed that you did not achieve a "Gold Medal" in every course! If you wish to please him, attain a "Gold Medal" in every course!'
