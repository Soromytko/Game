class_name Brigadier extends Node3D

@export var state_machine : StateMachine

func _ready():
	state_machine.switch_state("FoundationBuilder")
