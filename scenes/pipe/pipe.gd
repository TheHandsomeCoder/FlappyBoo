extends Area2D

class_name Pipe

func player_collided(body: Node2D) -> void:
    print("player collided with pipe")
    (body as Player).die()

