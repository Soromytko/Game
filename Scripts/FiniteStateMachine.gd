class_name FiniteStateMachine
extends Node

var states = {}
var current_state

class State:
	var pre_action : FuncRef
	var action : FuncRef
	var after_action : FuncRef
	
	func process_start():
		if pre_action.is_valid(): pre_action.call_func()
	
	func process_update(delta = 0):
		if action.is_valid(): action.call_func(delta)
	
	func process_end() :
		if after_action.is_valid(): after_action.call_func()


func add_state(name, action : FuncRef, pre_action : FuncRef = null, after_action: FuncRef = null):
	var state = State.new()
	state.pre_action = pre_action if pre_action else FuncRef.new()
	state.action = action if action else FuncRef.new()
	state.after_action = after_action if after_action else FuncRef.new()
	states[name] = state
	

func add_state_auto(name, object, func_name):
	var pre_action = funcref(object, func_name + "_start")
	var action = funcref(object, func_name)
	var after_action = funcref(object, func_name + "_end")
	add_state(name, action, pre_action, after_action)
	
	
func switch_state(name):
	if !states.has(name):
		print(name, "is a not state")
		return
	if current_state: current_state.process_end()
	current_state = states[name]
	current_state.process_start()
	
	
func update(delta):
	if current_state: current_state.process_update(delta)
	

