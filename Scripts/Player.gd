class_name Player
extends KinematicBody

signal move_event(position)

onready var camera = get_node("/root/Spatial/CameraController")

export var walk_speed : float = 10
export var sprint_speed : float = 30
export var rotation_speed : float = 10
export var jump_force : float = 25
export var gravity : float = 5

var handle_speed = walk_speed
var velocity = Vector3.ZERO
var move_direction = Vector3.ZERO
var stamina_bar_value : float = 1
const G = 9.8


func get_input() -> Vector3:
	var input = Vector3.ZERO
	input.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input.z = Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
	return input.normalized() if input.length() > 1 else input

func move(direction : Vector3):
	velocity.x = direction.x * handle_speed
#	velocity.y = direction.y * 10
	velocity.z = direction.z * handle_speed
	velocity = move_and_slide(velocity, Vector3.UP)
	
var is_build_mode = false
func set_build_mode(active):
	var axe_cur = $Hand.get_node("Axe")
	if axe_cur != null:
		axe_cur.visible = !active
	is_build_mode = active
	pass
	
func jump():
	if(is_on_floor()):
		velocity.y += jump_force
		
func _input(event):
	if Input.is_action_just_pressed("jump"):
		jump()
	if Input.is_action_just_pressed("Click") and not is_build_mode:
		if $Hand.get_child_count() > 0:
			if $RayCast.is_colliding():
				var collider = $RayCast.get_collider()
				if collider is TreeWooden:
					collider.destroy()
		
var a : float = 1	
		
func _process(delta):
	var stamina = get_node("/root/Spatial/Control/Stamina/Bar")
	
	if Input.is_action_pressed("sprint"):
		stamina_bar_value = move_toward(stamina_bar_value, 0, delta / 2)
		if stamina_bar_value > 0:
			handle_speed = sprint_speed
		else:
			handle_speed = walk_speed
	else:
		stamina_bar_value = move_toward(stamina_bar_value, 1, delta / 5)
	if Input.is_action_just_released("sprint"):
		handle_speed = walk_speed
		
	stamina.rect_scale.x = stamina_bar_value

func _physics_process(delta):
	var input = get_input()
	var direction = camera.transform.basis.x * input.x + camera.transform.basis.z * input.z
#	rotation_degrees.y = camera.rotation_degrees.y
#	print(Quat(camera.global_transform.basis))


	
	if (input != Vector3.ZERO):
		rotation.y = lerp_angle(rotation.y, atan2(-direction.x, -direction.z), rotation_speed * delta)
	
#	print(rad2deg(direction.angle_to(Vector3.FORWARD)))
#	rotation_degrees.y = rad2deg(direction.angle_to(Vector3.FORWARD))
	
#	direction = -transform.basis.z if input != Vector3.ZERO else Vector3.ZERO

	velocity.y -= gravity * G * delta
	move(direction)
	emit_signal("move_event", self.transform.origin)
	pass
