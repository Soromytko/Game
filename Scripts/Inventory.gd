class_name Inventory
extends Node

onready var hand = get_parent().get_node("Hand")
# onready var axe = get_node("/root/Spatial/Axe2")
onready var wood_count_text = get_node("/root/Spatial/Control/WoodCount")
onready var foliage_count_text = get_node("/root/Spatial/Control/LeafCount")

signal wood_count_changed(count)
signal foliage_count_changed(count)

var wood_count = 0
var foliage_count = 0

var items = []

func _on_wood_count_changed(count):
	wood_count_text.text = str(count)
	
func _on_foliage_count_changed(count):
	foliage_count_text.text = str(count)

func _ready():
	self.connect("wood_count_changed", self, "_on_wood_count_changed")
	self.connect("foliage_count_changed", self, "_on_foliage_count_changed")
	

func set_parent2(parent, child):
	child.get_parent().remove_child(child)
	parent.add_child(child)
	
	
func add_item0(item : Item):
	items.append(item)
	if item is Wood:
		wood_count += 1
		emit_signal("wood_count_changed", wood_count)
	if item is Foliage:
		foliage_count += 1
		emit_signal("foliage_count_changed", foliage_count)
	
	
func add_item(item):
	item.get_node("CollisionShape").disabled = true
	item.mode = RigidBody.MODE_STATIC
	TransformExtension.reparent(item, hand)
	item.rotation_degrees = Vector3.ZERO
#	item.b = true
	item.transform.origin = Vector3.ZERO
#	item.global_transform.origin = hand.global_transform.origin


