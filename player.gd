extends CharacterBody2D

class_name Player

enum State {
	IDLE,
	ACTIVE,
	DEAD
} 

# Animation parameters
var amplitude: float = 10.0   # How high the sprite will move
var frequency: float = 2.0    # Speed of the movement
var time_passed = 0.0
var start_position = Vector2()

@export var current_state: State = State.IDLE;
@export var gravity = 900.0
@export var jump_force: int = -300
var max_speed = 400
var rotation_speed = 2

func _ready():
	hide();
	$AnimatedSprite2D.play()

func _process(delta):	
	if(Input.is_action_just_pressed("JUMP")):
		current_state = State.ACTIVE
		jump()
	match current_state:
		State.IDLE:						# Increment time
			idle(delta);
		State.ACTIVE:
			active(delta);

func start(pos: Vector2):
	position = pos
	start_position = position
	show()
	$CollisionShape2D.disabled = false

func idle(delta):	
	time_passed += delta			
	# Calculate vertical displacement using sine wave
	var displacement = sin(time_passed * frequency) * amplitude			
	# Apply the new position
	position.y = start_position.y + displacement
	
func active(delta):
	velocity.y += gravity * delta
	if velocity.y > max_speed:
		velocity.y = max_speed
	move_and_collide(velocity * delta)
	rotate_boo()
	return;
	
func rotate_boo():
	# Rotate downwards when falling
	if velocity.y > 0 and rad_to_deg(rotation) < 90:
		rotation += rotation_speed * deg_to_rad(1)
	# Rotate upwards when rising
	elif velocity.y < 0 and rad_to_deg(rotation) > -30:
		rotation -= rotation_speed * deg_to_rad(1)

func jump():
	velocity.y = jump_force
	rotation = deg_to_rad(-30)
