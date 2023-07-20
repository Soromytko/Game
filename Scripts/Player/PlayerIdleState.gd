class_name PlayerIdleState extends PlayerState

func _on_update(delta):
	print("sdsd")
	return
	if !player.is_on_floor():
		return State.FALL
	
	var input = player.get_input()
	if input != Vector3.ZERO:
		return State.WALK
		
	if Input.is_action_just_pressed("jump"):
		return State.JUMP
		
	return State.IDLE
	

func _on_physics_update(delta):
	pass
	
