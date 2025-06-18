extends Node2D

# Accepts a scene to spawn and an interval for spawning
@export var spawn_scene: PackedScene
@export var spawn_interval_max: float = 1.8
@export var spawn_interval_min: float = 1.2

@onready var timer = $SpawnTimer

func _ready():
	timer.timeout.connect(_spawn_obstacle)

func _spawn_obstacle():
	var instance = spawn_scene.instantiate()
	add_child(instance)
	timer.start(_get_random_spawn_interval())

func _get_random_spawn_interval():
	# Randomize the spawn interval for the next obstacle
	return randf_range(spawn_interval_min, spawn_interval_max)

func start():
	# Start the timer to spawn obstacles
	timer.start(_get_random_spawn_interval())

func stop():
	# Stop the timer to prevent spawning obstacles
	timer.stop()
	# Get all children of type $pack_scene and call stop on them
	for child in get_children():
		if child is Obstacle:
			child.stop()

func reset():
	# Reset the timer and remove all obstacles
	timer.stop()
	for child in get_children():
		if child is Obstacle:
			child.queue_free()
