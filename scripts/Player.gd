extends Node

#onready var camera = get_node("/root/Spatial/CameraController")

signal move_event(position)
var valicity = Vector3.DOWN

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	print(camera)
	emit_signal("move_event", self.transform.origin)
#	camera.follow(self)
	pass
	
func _physics_rocess(delta):
	move_and_slide()
