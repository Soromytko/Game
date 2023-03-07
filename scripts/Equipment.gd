class_name Equipment
extends RigidBody

export var b = false


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

		
func playA():
	$AnimationPlayer.playback_speed = 2
	$AnimationPlayer.play("Axe")

func _process(delta):
	if Input.is_action_pressed("Click"):
		playA()
