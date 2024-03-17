extends CanvasLayer

func _ready():
	BackgroundMusic.play()

func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/eat.tscn")


func _on_quit_pressed():
	get_tree().quit()
