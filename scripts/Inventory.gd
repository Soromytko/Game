class_name Inventory
extends Node

onready var hand = get_parent().get_node("Hand")
onready var axe = get_node("/root/Spatial/Axe2")

func set_parent2(parent, child):
	child.get_parent().remove_child(child)
	parent.add_child(child)
	

	
func add_item(item):
	item.get_node("CollisionShape").disabled = true
	item.mode = RigidBody.MODE_STATIC
	TransformExtension.reparent(item, hand)
	item.rotation_degrees = Vector3.ZERO
#	item.b = true
	item.transform.origin = Vector3.ZERO
#	item.global_transform.origin = hand.global_transform.origin


