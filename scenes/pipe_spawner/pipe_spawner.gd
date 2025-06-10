extends Node2D

# Accepts a scene to spawn and an interval for spawning
@export var spawn_scene: PackedScene
@export var spawn_interval: float = 2.0

var _timer := 0.0

func _process(delta):
	_timer += delta
	if _timer >= spawn_interval:
		_timer = 0.0
		_spawn_obstacle()

func _spawn_obstacle():
	if spawn_scene:
		var instance = spawn_scene.instantiate()
		add_child(instance)


