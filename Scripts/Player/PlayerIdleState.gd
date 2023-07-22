class_name PlayerIdleState extends PlayerState

func _on_update(delta):
	
	player.apply_gravity()
	player.apply_velocity()
	
#	if !player.is_on_floor():
#		return _switch_state("FALL")
	
	var input = player.get_input()
	if input != Vector3.ZERO:
		print("dsdsf")
		return _switch_state("PlayerWalkState")
		
		
	if Input.is_action_just_pressed("jump"):
		return State.JUMP
		

func _on_physics_update(delta):
	pass
	
