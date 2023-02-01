extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var sensitivity = 0.4
var acceleration = 20
var v_min = -75
var v_max = +75
var instant_mouse = Vector2(0, 0)
var smoothed_mouse = Vector2(0, 0)

func follow(target):
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
#	$Pivot/Camera.add_exeption(get_parent())
	pass # Replace with function body.


func _input(event):
	if event is InputEventMouseMotion:
		instant_mouse.x += -event.relative.x * sensitivity
		instant_mouse.y += -event.relative.y * sensitivity
		instant_mouse.y = clamp(instant_mouse.y, v_min, v_max)
	if event is InputEventKey:
		if event.scancode == KEY_ESCAPE:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
		
func _physics_process(delta):
	var speed = acceleration * delta
	smoothed_mouse.x = lerp(smoothed_mouse.x, instant_mouse.x, speed)
	smoothed_mouse.y = lerp(smoothed_mouse.y, instant_mouse.y, speed)
	smoothed_mouse = instant_mouse
	$Pivot.rotation_degrees.x = smoothed_mouse.y
	$Pivot.rotation_degrees.y = smoothed_mouse.x
