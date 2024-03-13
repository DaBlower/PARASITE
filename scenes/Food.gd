extends Node2D
@onready var food_sprites = $FoodSprites


var rng = RandomNumberGenerator.new()
var times : int = 0
var parasite : bool = false
var sprite : int = 0
var repeat : int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	random()
	await get_tree().create_timer(1.0).timeout # Create timer
	if repeat < 100:
		food_sprites.position += Vector2(10, 2)
		await get_tree().create_timer(0.5).timeout
		repeat += 1
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
