extends FiniteStateMachineState
class_name EnemyState

export var _enemy: int
@export var number: int = 5

enum State { WALK, PURSUIT, LOOK_AROUND }


func _init(state_name, enemy : Enemy).(state_name):
	_enemy = enemy
	

#class EnemyPursueState extends EnemyState:
#	func _on_update(delta):
#		_enemy.animation_player.playback_speed = 2
#		_enemy.animation_player.play("EnemyWalk")
#
#		if _enemy._check_player():
#			_enemy.nav_agent.set_target_location(_enemy.target.global_transform.origin)
#
#	#	if nav_agent.is_target_reachable() && nav_agent.distance_to_target() > 1:
#		if _enemy.nav_agent.distance_to_target() > 1:
#			var next_location = _enemy.nav_agent.get_next_location()
#			var velocity = (next_location - _enemy.global_transform.origin).normalized() * _enemy.move_speed
#			_enemy.move_and_slide(velocity, Vector3.UP)
#			_enemy.rotation.y = lerp_angle(_enemy.rotation.y, atan2(velocity.x, velocity.z), 5 * delta)
#
#	#		var velocity = global_transform.origin.direction_to(target).normalized() * move_speed
#		#	https://godotengine.org/article/navigation-server-godot-4-0/
#			_enemy.nav_agent.set_velocity(velocity)
#
#		else:
#			return State.WALK
#
#
#class LookAround extends EnemyState:
#	var looking_time : float = 5
#
#	func _on_update(delta):
#		_enemy.animation_player.playback_speed = 2
#		_enemy.animation_player.play("EnemyIdle")
#
#		if looking_time <= 0:
#			looking_time = 5
#			return State.WALK
#			return
#		else:
#			looking_time -= delta
#
#
#		if _enemy._check_player():
#			return State.PURSUIT

