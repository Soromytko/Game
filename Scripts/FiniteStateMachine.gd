extends Node
class_name FiniteStateMachine

var states = {}
var current_state_name
var current_state setget , get_current_state

func get_current_state():
	return current_state


func add_state(name, state : FiniteStateMachineState):
	states[name] = state
	
	
func switch_state(name):
	if !states.has(name):
		print(name, "is a not state")
		return
	if current_state: current_state._on_end()
	current_state = states[name]
	current_state._on_start()
	
	
func update(delta):
	if current_state:
		var new_state_name = current_state._on_update(delta)
		if states.has(new_state_name):
			var new_state = states[new_state_name]
			if new_state != current_state:
				switch_state(new_state_name)
	

