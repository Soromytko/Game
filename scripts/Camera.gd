extends Spatial

export var sensitivity = 0.4
export var acceleration = 20
export var v_min = -80
export var v_max = +75
const instant_mouse = Vector2(0, 0)
const smoothed_mouse = Vector2(0, 0)

func on_follow(point):
	transform.origin = lerp(transform.origin, point, 0.1)
	pass

func follow(target):
	transform.origin.x = lerp(transform.origin.x, target.transform.origin.x, 0.1)
	transform.origin.y = lerp(transform.origin.y, target.transform.origin.y, 0.1)
	transform.origin.z = lerp(transform.origin.z, target.transform.origin.z, 0.1)
	
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
			get_tree().quit()
#			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
		
func _physics_process(delta):
	var speed = acceleration * delta
	smoothed_mouse.x = lerp(smoothed_mouse.x, instant_mouse.x, speed)
	smoothed_mouse.y = lerp(smoothed_mouse.y, instant_mouse.y, speed)
	$Pivot.rotation_degrees.x = smoothed_mouse.y
#	$Pivot.rotation_degrees.y = smoothed_mouse.x
	rotation_degrees.y = smoothed_mouse.x
