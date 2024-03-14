extends Node2D
# Food Sprites
@onready var doughnut = $Doughnut
@onready var egg = $Egg
@onready var pear = $Pear
@onready var tomato = $Tomato
@onready var pizza = $Pizza


# Variables
var rng = RandomNumberGenerator.new()
var times : int = 0
var parasite : bool = false
var sprite = 0
var repeat : int = 0

# Spawn new FoodSprite
func spawn_character(fs):  
	add_child(fs)

func despawn_character(fs):  
	remove_child(fs)

func _ready():
	random()
	add_child(sprite)

func random():
	if times >= 20:
		return
	else:
		sprite = rng.randi_range(1, 5)
		if sprite == 1:
			sprite = doughnut
		elif sprite == 2:
			sprite = egg
		elif sprite == 3:
			sprite = pear
		elif sprite == 4:
			sprite = tomato
		elif sprite == 5:
			sprite = pizza
			
		times += 1
		if rng.randf_range(1,5) == 5:
			parasite = true
		else:
			parasite = false
		
func _on_animation_player_animation_finished(anim_name):
	despawn_character(sprite)
	random()
	spawn_character(sprite)

