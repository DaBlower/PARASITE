extends CanvasLayer


@onready var scoreLabel = $Score
@onready var highScoreLabel = $HighScore
@onready var audio = $"../AudioStreamPlayer"


var highScore : int

func _ready():
	scoreLabel.text = "Score: " + str(FoodSprites.score)
	if FoodSprites.score > highScore:
		highScore = FoodSprites.score
	highScoreLabel.text = "High Score: " + str(highScore)
	audio.play()

func _on_restart_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_quit_pressed():
	get_tree().quit()
