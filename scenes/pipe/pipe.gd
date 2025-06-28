extends Area2D

class_name Pipe

func _ready():
    # Connect the body_entered signal to the player_collided function
    connect("body_entered", Callable(self, "player_collided"))

func player_collided(body: Node2D) -> void:
	print_debug("player collided with pipe")
	(body as Player).die()

