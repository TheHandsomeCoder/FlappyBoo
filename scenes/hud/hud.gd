extends CanvasLayer

class_name HUD

@onready var score_label: Label = $ScoreLabel
@onready var scoreboard: CanvasLayer = $Scoreboard
@onready var startLabel: Label = $StartMessage

func _ready():
	scoreboard.visible = false
	set_score(0)

func start():
	startLabel.visible = false

func set_score(score):
	score_label.text = str(score)

func reset():
	set_score(0)
	scoreboard.visible = false

func show_scoreboard(score, high_score):
	scoreboard.get_node("HighScore").text = "Highscore: " + str(high_score)
	scoreboard.get_node("CurrentScore").text = "Score: " + str(score)
	scoreboard.visible = true
	startLabel.visible = true
