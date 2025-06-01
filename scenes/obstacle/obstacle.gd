extends Node2D

class_name Obstacle

var speed: float = Global.speed

func _process(delta):
    # Move the obstacle to the left
    global_position.x += speed * delta

func _on_scoring_area_body_entered(body: Node2D) -> void:
    print("I'm scoring!")
