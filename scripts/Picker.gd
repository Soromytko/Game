class_name Picker
extends Area

onready var inventory = get_parent().get_node("Inventory")

func _on_Area_area_entered(area):
	pass
	
func _on_Area_body_entered(body):
	if body is Equipment:
		inventory.add_item(body)
#		body.queue_free()
	elif body is RigidBody:
		body.queue_free()
