class_name PlayerWalkState extends PlayerState

var _jump_force : float = 0.3

func _on_update(delta):
	var input = player.get_input()
	var relative_input = player.get_relative_input(input)
	
	if player.is_on_floor():
		if Input.is_action_just_pressed("jump"):
			return State.JUMP
	
	player.upply_gravity()
	
	player.move_and_slide()
	
	return State.WALK
