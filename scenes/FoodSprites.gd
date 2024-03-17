extends Node2D
# Food Sprites
@onready var doughnut = $Doughnut1/AnimationPlayer
@onready var apple = $Apple1/AnimationPlayer
@onready var cake = $Cake1/AnimationPlayer
@onready var roll = $Roll1/AnimationPlayer
@onready var pizza = $Pizza1/AnimationPlayer
@onready var beans = $Beans1/AnimationPlayer
@onready var yn = $CanvasLayer/AnimationPlayer
@onready var yes = $CanvasLayer/Yes
@onready var no = $CanvasLayer/No
@onready var humen = $"../../Humen/AnimatedSprite2D"

# Variables
@export var anim_playing : bool = false
@export var yn_playing : bool = false
var nutrition = 0
var sprite = 0
var rng = RandomNumberGenerator.new()
var times : int = 0
var parasite : bool = false
var sp = 0
var repeat : int = 0
var animation = 0
var button = 0
var ran = 0

func random():
		sp = rng.randi_range(1, 6)
		if sp == 1:
			sp = doughnut
			sprite = %Doughnut1
		elif sp == 2:
			sp = apple
			sprite = %Apple1
		elif sp == 3:
			sp = cake
			sprite = %Cake1
		elif sp == 4:
			sp = roll
			sprite = %Roll1
		elif sp == 5:
			sp = pizza
			sprite = %Pizza1
		elif sp == 6:
			sp = beans
			sprite = %Beans1
			
		if sp == pizza:
			pass
		else:
			if rng.randi_range(1,3) == 3:
				if sp == beans:
					ran = rng.randi_range(1,2)
					if ran == 1:
						sprite.animation = "partial"
						print("partial")
						parasite = true
					else:
						sprite.animation = "parasite"
						print("parasite")
						parasite = true
				else:
					sprite.animation = "parasite"
					print("parasite")
					parasite = true
			else:
				sprite.animation = "normal"
				print("normal")
				parasite = false

func add_nutrition(spritez):
	if spritez == doughnut:
		nutrition += rng.randi_range(-1,1)
	elif spritez == apple:
		nutrition += rng.randi_range(1,2)
	elif spritez == cake:
		nutrition += rng.randi_range(-1,1)
	elif spritez == roll:
		nutrition += rng.randi_range(1,2)
	elif spritez == pizza:
		nutrition += rng.randi_range(-1,1)
	elif spritez == beans:
		nutrition += rng.randi_range(1,3)
	else:
		print('UNKNOWN SPRITEZ')
	print("Nutrition")
	%NutritionLabel.text = "Nutrition: " + str(nutrition)

func _ready():
	yes.visible = false
	no.visible = false
	%Doughnut1.visible = false
	%Apple1.visible = false
	%Cake1.visible = false
	%Roll1.visible = false
	%Pizza1.visible = false
	%Beans1.visible = false
	%Doughnut1.scale = Vector2(2.5, 2.5)
	%Apple1.scale = Vector2(2.5, 2.5)
	%Cake1.scale = Vector2(2.5, 2.5)
	%Roll1.scale = Vector2(2.5, 2.5)
	%Beans1.scale = Vector2(2,2)
	await get_tree().create_timer(1).timeout
	random()
	spawn_character()

func _on_animation_player_animation_finished(yorn):
	if yorn == "YN":
		sp.play("continue")
		humen.play("eat")
		add_nutrition(sp)
		if parasite == true:
			if rng.randi_range(1,2) == 2:
				FoodSprites.score = nutrition
				BackgroundMusic.stop()
				get_tree().change_scene_to_file("res://scenes/game_over.tscn")
		await get_tree().create_timer(1.0).timeout
		random()
		spawn_character()

# Spawn new FoodSprite
func spawn_character():  
	sp.play("YN")
	yn.play("slide_in")

func _on_yes_pressed():
	yn.stop()
	sp.play("continue")
	humen.play("eat")
	add_nutrition(sp)
	if parasite == true:
		BackgroundMusic.stop()
		FoodSprites.score = nutrition
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	else:
		await get_tree().create_timer(1.2).timeout
		random()
		spawn_character()
	
func _on_no_pressed():
	sp.stop()
	sp.play("shrink")
	yn.stop()
	await get_tree().create_timer(1.2).timeout
	random()
	spawn_character()
