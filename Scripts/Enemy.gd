extends KinematicBody
class_name Enemy

export var move_speed : float = 5

onready var nav_agent = $"NavigationAgent"
onready var raycast = $"RayCast"
onready var animation_player = $"AnimationPlayer"

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
	
#	fsm.add_state(EnemyWalkState.new(State.WALK, self))
#	fsm.add_state(EnemyPursueState.new(State.PURSUIT, self))
#	fsm.add_state(EnemyWalkState.new(State.LOOK_AROUND, self))
#
#	fsm.switch_state(State.WALK)
	

	

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
