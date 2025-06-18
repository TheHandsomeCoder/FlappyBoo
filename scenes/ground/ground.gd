extends Node2D

class_name Ground

signal bird_crashed

var speed = Global.speed

@onready var sprite1 = $Ground1/Sprite2D
@onready var sprite2 = $Ground2/Sprite2D

func _ready():
	$Ground1.connect("body_entered", Callable(self, "_body_entered"))
	$Ground2.connect("body_entered", Callable(self, "_body_entered"))

	sprite2.global_position.x = sprite1.global_position.x + sprite1.texture.get_width()

func _physics_process(delta):
	sprite1.global_position.x += speed * delta
	sprite2.global_position.x += speed * delta
	
	# If Sprite1 has completely left the screen, move it to the right of Sprite2
	if sprite1.global_position.x < -sprite1.texture.get_width():
		sprite1.global_position.x = sprite2.global_position.x + sprite2.texture.get_width()

	# If Sprite2 has completely left the screen, move it to the right of Sprite1
	if sprite2.global_position.x < -sprite2.texture.get_width():
		sprite2.global_position.x = sprite1.global_position.x + sprite1.texture.get_width()


func _body_entered(body):
	SignalBus.emit_signal("bird_crashed")
	(body as Player).die()

func start():
	# Start the ground movement
	speed = Global.speed

func stop():
	speed = 0 #

