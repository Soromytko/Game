extends RayCast

# var camera = get_node("/root/Spatial/CameraController")

onready var player = get_node("/root/Spatial/Player")
onready var inventory = get_node("/root/Spatial/Player/Inventory")

var wall_scene = preload("res://Prefabs/Wall.tscn")

var is_build_mode = false
var wall_instance

func _ready():
	wall_instance = wall_scene.instance()
	get_node("/root/Spatial").call_deferred("add_child", wall_instance)
	wall_instance.visible = false
	wall_instance.get_node("CollisionShape").disabled = true
	wall_instance.get_node("CollisionShape2").disabled = true
	wall_instance.get_node("CollisionShape3").disabled = true
	wall_instance.get_node("CollisionShape4").disabled = true
	wall_instance.get_node("CollisionShape5").disabled = true
	
func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_1:
			is_build_mode = false
			print("build mode is disable")
			player.set_build_mode(false)
		elif event.scancode == KEY_2:
			print("build mode is enabled")
			is_build_mode = true
			player.set_build_mode(true)

func _physics_process(delta):
	wall_instance.visible = false
	if is_build_mode == false: return
	if inventory.wood_count < 2: return

	if is_colliding():
		var collider = get_collider()
		wall_instance.transform.origin = get_collision_point()
		wall_instance.rotation_degrees = get_parent().get_parent().get_parent().rotation_degrees
		wall_instance.visible = true
		if Input.is_action_just_pressed("Click"):
			inventory.remove_wood(2)
			var wall = wall_scene.instance()
			get_node("/root/Spatial").add_child(wall)
			wall.transform.origin = wall_instance.transform.origin
			wall.rotation_degrees = wall_instance.rotation_degrees
