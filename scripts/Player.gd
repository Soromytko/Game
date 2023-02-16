extends Node

#onready var camera = get_node("/root/Spatial/CameraController")

signal move_event(position)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	print(camera)
	emit_signal("move_event", self.transform.origin)
#	camera.follow(self)
	pass
