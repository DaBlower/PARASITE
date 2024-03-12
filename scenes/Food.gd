extends Node2D
@onready var food_sprites = $FoodSprites


var rng = RandomNumberGenerator.new()
var times : int = 0
var parasite : bool = false
var sprite : int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	random()
func random():
	if times >= 30:
		return
	else:
		@warning_ignore("narrowing_conversion")
		sprite = rng.randi_range(1, 3)
		times += 1
		if rng.randf_range(1,5) == 5:
			parasite = true
		else:
			parasite = false
		food_sprites.animation = str(rng.randi_range(1, 3))
		print(food_sprites.animation)
		print(parasite)
