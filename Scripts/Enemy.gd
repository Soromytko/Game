class_name Enemy
extends KinematicBody

export var move_speed : float = 5

onready var nav_agent = $"NavigationAgent"
onready var raycast = $"RayCast"
onready var animation_player = $"AnimationPlayer"

enum State { WALK, PURSUIT, LOOK_AROUND }

var state = State.WALK
var target = null
var is_player_invisible : bool = false

var fsm = FiniteStateMachine.new()

func _input(event):
	if Input.is_action_just_pressed("Alt"):
		is_player_invisible = !is_player_invisible
		var player = get_node("/root/Spatial/Player/Skin")
		var material = player.get_surface_material(0)
#			print(material.transparency)
		if is_player_invisible:
			material.albedo_color = Color(1, 1, 1, 0.2)
		else:
			material.albedo_color = Color(1, 1, 1, 1)
		player.set_surface_material(0, material)


func move_to(target : Vector3):
	nav_agent.set_target_location(target)
	

func _ready():
	nav_agent.set_navigation(get_node("/root/Spatial/Navigation"))
	move_to(global_transform.origin)

	fsm.add_state_auto(State.WALK, self, "_process_walk")
	fsm.add_state_auto(State.PURSUIT, self, "_process_pursuit")
	fsm.add_state_auto(State.LOOK_AROUND, self, "_process_look_around")
	fsm.switch_state(State.WALK)


func _physics_process(delta):
	fsm.update(delta)
	 
	
func _process_walk_start():
	print("WALK")
	

func _process_walk(delta):
	animation_player.playback_speed = 1
	animation_player.play("EnemyWalk")
	
	if _check_player():
		fsm.switch_state(State.PURSUIT)
		return
	
	if nav_agent.distance_to_target() < 1 && nav_agent.is_target_reachable():
		var rng = RandomNumberGenerator.new()
		var t = OS.get_time().second
		rng.seed = hash(str(t))
#		rng.seed = hash("Godot")
#		rng.state = 100
		var max_l = 10
		var new_location = Vector3(rng.randf_range(-max_l, max_l), rng.randf_range(-max_l, max_l), rng.randf_range(-max_l, max_l))
		new_location += global_transform.origin
		new_location.y = global_transform.origin.y
		nav_agent.set_target_location(new_location)
		fsm.switch_state(State.LOOK_AROUND)
		return
	else:
		var next_location = nav_agent.get_next_location()
		var velocity = (next_location - global_transform.origin).normalized() * move_speed / 2
		move_and_slide(velocity, Vector3.UP)
		rotation.y = lerp_angle(rotation.y, atan2(velocity.x, velocity.z), 5 * delta)
	pass
	
func _process_pursue_start():
	print("PURSUIT")
	

func _process_pursue(delta):
	animation_player.playback_speed = 2
	animation_player.play("EnemyWalk")
	
	if _check_player():
		nav_agent.set_target_location(target.global_transform.origin)
	
#	if nav_agent.is_target_reachable() && nav_agent.distance_to_target() > 1:
	if nav_agent.distance_to_target() > 1:
		var next_location = nav_agent.get_next_location()
		var velocity = (next_location - global_transform.origin).normalized() * move_speed
		move_and_slide(velocity, Vector3.UP)
		rotation.y = lerp_angle(rotation.y, atan2(velocity.x, velocity.z), 5 * delta)
		
#		var velocity = global_transform.origin.direction_to(target).normalized() * move_speed
	#	https://godotengine.org/article/navigation-server-godot-4-0/
		nav_agent.set_velocity(velocity)
		
	else:
		fsm.switch_state(State.WALK)


func _process_look_around_start():
	print("LOOK_AROUND")
	

var looking_time : float = 5
func _process_look_around(delta):
	animation_player.playback_speed = 2
	animation_player.play("EnemyIdle")
#	if animation_player.

	if looking_time <= 0:
		looking_time = 5
		fsm.switch_state(State.WALK)
		return
	else:
		looking_time -= delta
		
		
	if _check_player():
		fsm.switch_state(State.PURSUIT)

	pass
	

func _check_player():
	if is_player_invisible: return false
	
	if target != null:
		var target_look = target.global_transform.origin
		target_look.y = global_transform.origin.y
		raycast.look_at(target_look, Vector3.UP)
		if raycast.is_colliding():
			if raycast.get_collider() is Player:
				return true
			
	return false
	

func _on_Area_body_entered(body):
	if body is Player:
		target = body
		
	
func _on_Area_body_exited(body):
	if body is Player:
		target = null


func _on_Area2_body_entered(body):
	if body is Player:
		target.take_damage(10)
	pass # Replace with function body.
