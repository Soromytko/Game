class_name PlayerJumpState extends PlayerState

func _on_enter():
	player.upply_jump()
	
	
func _on_update(delta):
	player.upply_gravity()
	
	if player.is_on_floor():
		return State.IDLE
