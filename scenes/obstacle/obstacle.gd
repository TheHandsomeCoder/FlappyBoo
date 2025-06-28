extends Node2D

class_name Obstacle

var speed: float = Global.speed

func _ready():
    $ScoringArea.connect("body_entered", Callable(self, "_on_scoring_area_body_entered"))
    # Set the initial height of the obstacle randomly between 80 and 248px
    global_position.y = randf_range(80, 248);

func _physics_process(delta):
    # Move the obstacle to the left when speed > 0
    global_position.x += speed * delta

func _on_scoring_area_body_entered(_body: Node2D) -> void:
    # Emit a signal when the player passes through the scoring area
    SignalBus.emit_signal("point_scored")
    print_debug("Point scored by player!")

func start():
    speed = Global.speed
func stop():
    speed = 0
