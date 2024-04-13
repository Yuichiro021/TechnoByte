class_name Judete
extends Node2D

@onready var rng = RandomNumberGenerator.new()

@onready var timer = $"../../Timer" as Timer

@onready var points = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		child.set_meta("Pollution",0)
		child.self_modulate = Color(118.0/255.0, 137.0/255.0, 72.0/255.0, 0.0)
	#for child in get_children():
	#	print(child.name," ",child.get_meta("Pollution"))
	timer.connect("timeout",increase_pollution)

func increase_pollution():
	var sprite = get_child(rng.randi_range(0, get_children().size()-1))
	sprite.set_meta("Pollution",sprite.get_meta("Pollution") +1)
	print(sprite.name, " ", sprite.get_meta("Pollution"))
	sprite.self_modulate = Color(118.0/255.0, 137.0/255.0, 72.0/255.0, float(sprite.get_meta("Pollution"))/10.0)

func lower_pollution(sprite):
	sprite.set_meta("Pollution",0)
	points += 1
	var label := $"../../side_menu/MarginContainer/VBoxContainer/Label/Label2" as Label
	label.text = str(points)
	sprite.self_modulate = Color(118.0/255.0, 137.0/255.0, 72.0/255.0, float(sprite.get_meta("Pollution"))/10.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#print( rng.randi_range(0,get_children().size() - 1) );

var active_button = null

func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index==MOUSE_BUTTON_LEFT:
		if active_button !=null:
			active_button.queue_free()
		var click_registered = false
		for child in get_children():
			if child is Sprite2D:
				var collision_polygon = child.get_node("CollisionPolygon2D")
				if collision_polygon!=null:
					var global_points=[]
					for point in collision_polygon.polygon:
						global_points.append(point+ child.global_position)
					if Geometry2D.is_point_in_polygon(event.position,global_points):
						if not click_registered:
							print("Clicked on: ",child.get_name())
							create_child_button(child)
							lower_pollution(child)
							click_registered = true

func create_child_button(child):
	var button := Button.new()
	button.text = str("Creare Sediu")
	child.add_child(button)
	active_button = button
