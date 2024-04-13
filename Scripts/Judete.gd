class_name Judete
extends Node2D

@onready var rng = RandomNumberGenerator.new()

@onready var timer = $"../../Timer" as Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		child.set_meta("Pollution",0)
	#for child in get_children():
	#	print(child.name," ",child.get_meta("Pollution"))
	timer.connect("timeout",increase_pollution)

func increase_pollution():
	var sprite = get_child(rng.randi_range(0, get_children().size()-1))
	sprite.set_meta("Pollution",sprite.get_meta("Pollution") +1)
	print(sprite.name, " ", sprite.get_meta("Pollution"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#print( rng.randi_range(0,get_children().size() - 1) );


func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index==MOUSE_BUTTON_LEFT:
			for child in get_children():
				if child is Sprite2D:
					var global_position = child.global_position
					var size = child.texture.get_size()
					var rect = Rect2(global_position,size)
					if rect.has_point(get_global_mouse_position()):
						print("Clicked on: ",child.name)
