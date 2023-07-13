extends Node

const FiniteStateMachine := preload("res://Scripts/FiniteStateMachine.gd")

var fsm = FiniteStateMachine.new()

func _process_walk_start():
	pass

func _process_walk(delta):
	pass

func _process_walk_end():
	pass
	
	
func _ready():
#	fsm.add_state(0, funcref(self, "_stateOne"), funcref(self, "_pre_stateOne"))
	fsm.add_state_auto(0, self, "_process_walk")
	fsm.switch_state(0)
	pass
	
	
func _process(delta):
	fsm.update(delta)
	pass


