extends Node

export onready var player = get_node("/root/Spatial/Player")
export onready var camera = get_node("/root/Spatial/CameraController")

func getPlayer():
	print("yes")
	pass

func _ready():
	player.connect("move_event", camera, "on_follow")
	
