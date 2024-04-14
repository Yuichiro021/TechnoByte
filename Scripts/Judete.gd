class_name Judete
extends Node2D

@onready var rng = RandomNumberGenerator.new()

@onready var timer = $"../../Timer" as Timer
@onready var timer_random_event = $"../../Timer_random_event" as Timer


@onready var points = 5

@onready var reputation=100

var mesaj_pe_ecran = false



# Called when the node enters the scene tree for the first time.
func _ready():
	change_points(0)
	change_reputation(0)
	for child in get_children():
		child.set_meta("Pollution",rng.randi_range(3,10))
		child.self_modulate = Color(118.0/255.0, 137.0/255.0, 72.0/255.0, float(child.get_meta("Pollution"))/20.0)
		child.set_meta("sediu",false)
	#for child in get_children():
	#	print(child.name," ",child.get_meta("Pollution"))
	timer.connect("timeout",increase_pollution)
	timer_random_event.wait_time = rng.randi_range(10, 20)
	timer_random_event.connect("timeout",generate_event)

var sedii=[]

func change_points(val):
	if points+val>0:
		points+=val
	var label := $"../../MarginContainer/VBoxContainer/Label/Label2" as Label
	label.text = str(points)

func change_reputation(val):
	if reputation+val>0:
		reputation+=val
	else:
		reputation = 0
	var label := $"../../MarginContainer/VBoxContainer/Label2/Label2" as Label
	label.text = str(reputation)

func increase_pollution():
	var sum=0
	for child in get_children():
		if child.has_meta("Pollution"):
			sum+=child.get_meta("Pollution")
	change_reputation(-sum/50)
	if !sedii.is_empty():
		for sediu in sedii:
			lower_pollution(sediu)
	change_points(randi_range(1, 7)+len(sedii))
	var sprite = get_child(rng.randi_range(0, get_children().size()-1))
	sprite.set_meta("Pollution",sprite.get_meta("Pollution") +1)
	print(sprite.name, " ", sprite.get_meta("Pollution"))
	sprite.self_modulate = Color(118.0/255.0, 137.0/255.0, 72.0/255.0, float(sprite.get_meta("Pollution"))/20.0)
	change_reputation(0)
	var rand = randi_range(1,5)
	

func lower_pollution(sprite):
	if sprite.get_meta("Pollution") >0:
		sprite.set_meta("Pollution",sprite.get_meta("Pollution")-1)
		change_points(1)
		sprite.self_modulate = Color(118.0/255.0, 137.0/255.0, 72.0/255.0, float(sprite.get_meta("Pollution"))/20.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#print( rng.randi_range(0,get_children().size() - 1) );

var active_button = null

var child1 = null

var sediu_exista = false

func create_sediu():
	if sediu_exista:
		change_points(-40)
		timer_random_event.start()
	sedii.append(child1)
	sediu_exista = true
	var sediu := TextureRect.new()
	var textura = load("res://resources/level/sediu.png")
	sediu.texture=textura
	child1.add_child(sediu)
	child1.set_meta("sediu",true)
	timer.start()
	timer_random_event.start()

func clear_all_buttons():
	var ok=true
	if active_button !=null:
		ok=false
		active_button.queue_free()
	if not butoane_sediu.is_empty():
		for buton in butoane_sediu:
			buton.queue_free()
			butoane_sediu=[]
			ok=false
	return ok
func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index==MOUSE_BUTTON_LEFT and not mesaj_pe_ecran:
		for child in get_children():
			if child is Sprite2D:
				var collision_polygon = child.get_node("CollisionPolygon2D")
				if collision_polygon!=null:
					var global_points=[]
					for point in collision_polygon.polygon:
						global_points.append(point+ child.global_position)
					if is_point_inside_concave_shape(event.position,global_points):
						if(clear_all_buttons()):
							if child.get_meta("sediu")==false and (sediu_exista==false or points>=40):
								print("Clicked on: ",child.get_name())
								
								create_child_button(child)
							if sediu_exista==true and child.get_meta("sediu")==true:
								meniu_sediu(child)

func create_child_button(child):
	var button := Button.new()
	button.text = "Creare Sediu"
	button.add_theme_font_size_override("font_size",32)
	button.size = Vector2(50,50)
	button.position.y+=50
	button.position.x-=100
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
	change_points(-4)
	change_reputation(4)

func buton_tree():
	change_points(-2)
	change_reputation(2)

func buton_pesticide():
	change_points(-3)
	change_reputation(3)

func buton_water():
	change_points(-5)
	change_reputation(5)

func buton_factory():
	change_points(-6)
	change_reputation(6)

var eventCaller = null

var event_list = [[event1, ""]]

func generate_event():
	var event = event_list[rng.randi_range(0,event_list.size()-1)]
	createMessage(event[0],event[1])
	timer_random_event.wait_time = rng.randi_range(10, 20)
	

func createMessage(event,text):
	mesaj_pe_ecran = true
	timer.stop()
	timer_random_event.stop()
	var box := TextureRect.new()
	var textura = load("res://resources/backgrounds/black.png")
	box.texture=textura
	box.z_index = 15
	box.size = Vector2(400,100)
	box.position = Vector2(130,200)
	self.add_child(box)
	var label := Label.new()
	label.text = text
	label.add_theme_font_size_override("font_size",15)
	box.add_child(label)
	var button := Button.new()
	button.text="OK"
	button.position = Vector2(box.size.x-50,box.size.y-50)
	button.button_down.connect(event)
	box.add_child(button)
	eventCaller = box

func event1():
	if eventCaller != null:
		eventCaller.queue_free()
	mesaj_pe_ecran=false
	timer.start()
	timer_random_event.start()
	
func event2():
	if eventCaller != null:
		eventCaller.queue_free()
	mesaj_pe_ecran=false
	timer.start()
	timer_random_event.start()
	
func event3():
	if eventCaller != null:
		eventCaller.queue_free()
	mesaj_pe_ecran=false
	timer.start()
	timer_random_event.start()
	
func event4():
	if eventCaller != null:
		eventCaller.queue_free()
	mesaj_pe_ecran=false
	timer.start()
	timer_random_event.start()
	
func event5():
	if eventCaller != null:
		eventCaller.queue_free()
	mesaj_pe_ecran=false
	timer.start()
	timer_random_event.start()
