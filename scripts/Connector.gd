extends Node

onready var player = get_node("/root/Spatial/Player")
onready var camera = get_node("/root/Spatial/CameraController")

func _ready():
	player.connect("move_event", camera, "on_follow")
