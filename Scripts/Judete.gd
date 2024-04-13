class_name Judete
extends Node2D

@onready var rng = RandomNumberGenerator.new()

@onready var timer = $"../../Timer" as Timer

@onready var points = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		child.set_meta("Pollution",0)
		child.set_meta("sediu",false)
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
	points += sprite.get_meta("Pollution")
	sprite.set_meta("Pollution",0)
	var label := $"../../side_menu/MarginContainer/VBoxContainer/Label/Label2" as Label
	label.text = str(points)
	sprite.self_modulate = Color(118.0/255.0, 137.0/255.0, 72.0/255.0, float(sprite.get_meta("Pollution"))/10.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#print( rng.randi_range(0,get_children().size() - 1) );

var active_button = null

var child1 = null

var sediu_exista = false

func create_sediu():
	sediu_exista = true
	var sediu := TextureRect.new()
	var textura = load("res://resources/level/sediu.png")
	sediu.texture=textura
	child1.add_child(sediu)
	child1.set_meta("sediu",true)
	timer.start()

func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index==MOUSE_BUTTON_LEFT:
		for child in get_children():
			if child is Sprite2D:
				var collision_polygon = child.get_node("CollisionPolygon2D")
				if collision_polygon!=null:
					var global_points=[]
					for point in collision_polygon.polygon:
						global_points.append(point+ child.global_position)
					if is_point_inside_concave_shape(event.position,global_points):
						if active_button !=null:
							active_button.queue_free()
						elif not butoane_sediu.is_empty():
							for buton in butoane_sediu:
								buton.queue_free()
							butoane_sediu=[]
						else:
							if child.get_meta("sediu")==false and sediu_exista == false:
								print("Clicked on: ",child.get_name())
								create_child_button(child)
								lower_pollution(child)
							if sediu_exista==true and child.get_meta("sediu")==true:
								meniu_sediu(child)

func create_child_button(child):
	var button := Button.new()
	button.text = "Creare Sediu"
	button.add_theme_font_size_override("font_size",32)
	button.size = Vector2(50,50)
	button.position.x+=50
	child1 = child
	button.z_index=10
	button.button_down.connect(create_sediu)
	active_button = button
	child.add_child(button)

func is_point_inside_concave_shape(point, shape_points) -> bool:
	var intersections = 0

	for i in range(shape_points.size()):
		var p1 = shape_points[i]
		var p2 = shape_points[(i + 1) % shape_points.size()]

		# Check if the edge intersects with the horizontal line passing through the point
		if (p1.y < point.y && p2.y >= point.y) || (p2.y < point.y && p1.y >= point.y):
			# Calculate the intersection point's x-coordinate
			var intersection_x = p1.x + (point.y - p1.y) / (p2.y - p1.y) * (p2.x - p1.x)
			# Check if the intersection point is to the right of the point
			if intersection_x > point.x:
				intersections += 1

	# If the number of intersections is odd, the point is inside the shape
	return intersections % 2 == 1
	
var butoane_sediu = []

func create_sediu_button(xpoz,ypoz,function,path,child):
	var button = Button.new()
	button.icon = load(path)
	button.set_size(Vector2(25,25))
	button.z_index=10
	button.button_down.connect(function)
	button.position.y+=ypoz
	button.position.x-=xpoz
	butoane_sediu.append(button)
	child.add_child(button)

func meniu_sediu(child):
	create_sediu_button(150,50,buton_car,"res://resources/icons/car.png",child)
	create_sediu_button(75,50,buton_tree,"res://resources/icons/tree.png",child)
	create_sediu_button(0,50,buton_pesticide,"res://resources/icons/pesticide.png",child)
	create_sediu_button(-75,50,buton_water,"res://resources/icons/water.png",child)
	create_sediu_button(-150,50,buton_factory,"res://resources/icons/factory.png",child)

func buton_car():
	pass

func buton_tree():
	pass

func buton_pesticide():
	pass

func buton_water():
	pass

func buton_factory():
	pass
