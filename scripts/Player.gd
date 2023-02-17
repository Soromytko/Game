extends KinematicBody

signal move_event(position)

export var move_speed = 10

var velocity = Vector3.ZERO
var move_direction = Vector3.ZERO

func get_input() -> Vector3:
	var input = Vector3.ZERO
	input.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input.z = Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
	return input.normalized() if input.length() > 1 else input

func move(direction : Vector3):
	velocity.x = direction.x * move_speed
#	velocity.y = direction.y * 10
	velocity.z = direction.z * move_speed
	velocity = move_and_slide(velocity, Vector3.UP)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	pass
	
func _physics_process(delta):
	var input = get_input()
	velocity.y -= 1
	move(input)
	print(is_on_floor())
	emit_signal("move_event", self.transform.origin)
	pass
