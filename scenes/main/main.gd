extends Node

class_name Main

enum GameState {
	IDLE,
	ACTIVE,
	GAME_OVER
}

var score = 0
var game_state: GameState = GameState.IDLE

func _ready():
	SignalBus.connect("point_scored", Callable(self, "increment_score"))
	SignalBus.connect("player_death", Callable(self, "_on_Player_death"))
	$Player.init($StartPosition.position)

func _process(delta): 
	match game_state:
		GameState.IDLE:
			if(Input.is_action_just_pressed("JUMP")):
				_start_game()
		GameState.ACTIVE:
			# Game is active, do nothing here
			pass
		GameState.GAME_OVER:
			if(Input.is_action_just_pressed("JUMP")):
				_reset_game()

func increment_score():
	score += 1
	print("Score incremented: ", score)
	$Hud/ScoreLabel.text = str(score)

func _on_Player_death():
	$Ground.stop()
	$PipeSpawner.stop()
	game_state = GameState.GAME_OVER

func _start_game():
	$Player.start()
	game_state = GameState.ACTIVE
	$PipeSpawner.start()

func _reset_game():
	$Player.reset()
	$PipeSpawner.reset()
	game_state = GameState.IDLE
	score = 0
	$Hud/ScoreLabel.text = str(score)
	$Ground.start()
	print("Game reset")
