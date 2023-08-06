class_name PlayerWalkState extends PlayerState

var _jump_force : float = 0.3

func _on_update(delta):
	var input = player.get_input()
	var relative_input = player.get_relative_input(input)
	
	if player.is_on_floor():
		if Input.is_action_just_pressed("jump"):
			return _switch_state("PlayerJumpState")
	else:
		player.apply_gravity(delta)

	player.set_move_direction(relative_input)
	player.move(delta * 500)
	if input != Vector3.ZERO:
		player.rotate_to_direction(relative_input, delta)
