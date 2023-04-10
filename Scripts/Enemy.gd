class_name Enemy
extends KinematicBody

export var move_speed : float = 5

onready var nav_agent = $"NavigationAgent"

var target

func move_to(target : Vector3):
	nav_agent.set_target_location(target)
	pass

func _ready():
	move_to(global_transform.origin)
	move_to(Vector3.ZERO)

func _physics_process(delta):
	if target == null:
		print(target)
		return
	else:
		move_to(target.global_transform.origin)
	
	if nav_agent.is_target_reachable():
		if nav_agent.distance_to_target() > 1:
			var next_location = nav_agent.get_next_location()
			var velocity = (next_location - global_transform.origin).normalized() * move_speed
			move_and_slide(velocity, Vector3.UP)
			rotation.y = lerp_angle(rotation.y, atan2(velocity.x, velocity.z), 5 * delta)
			
	#		var velocity = global_transform.origin.direction_to(target).normalized() * move_speed
		#	https://godotengine.org/article/navigation-server-godot-4-0/
			nav_agent.set_velocity(velocity)
		
	 



func _on_Area_body_entered(body):
	if body is Player:
		target = body
	
func _on_Area_body_exited(body):
	print(body)
	if body is Player:
		target = null
	pass
