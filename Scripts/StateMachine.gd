class_name StateMachine extends Node

var states = {}
var current_state_name
var current_state

func _ready():
	for child in get_children():
		if child is StateMachineState:
			add_state(child.state_name, child)


func add_state(name, state : StateMachineState):
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
	

