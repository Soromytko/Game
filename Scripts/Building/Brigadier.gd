class_name Brigadier extends RayCast3D

var currnet_builder : Builder

@export var builder : Builder

func _physics_process(delta):
#	if Input.is_action_just_pressed("Click"):
#		current_builder.build()
	if is_colliding():
		var point = get_collision_point()
		builder.process_build(point)
