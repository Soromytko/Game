class_name StateMachineState
extends Node

var state_name = null:
	get:
		return state_name

func _init(state_name):
	self.state_name = state_name


func _on_enter():
	pass
	
	
func _on_update(delta):
	pass
	
	
func _on_exit():
	pass
