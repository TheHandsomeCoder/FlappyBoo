extends Node

class_name Main
var score = 0

func _ready():
	SignalBus.connect("point_scored", Callable(self, "increment_score"))
	SignalBus.connect("player_death", Callable(self, "_on_Player_death"))
	$Player.start($StartPosition.position)

func increment_score():
	score += 1
	print("Score incremented: ", score)
	$Hud/ScoreLabel.text = str(score)

func _on_Player_death():
	score = 0
	$Hud/ScoreLabel.text = str(score)

