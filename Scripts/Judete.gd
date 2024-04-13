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
	if event is InputEventMouseButton:
		if event.button_index == 1:
			for child in get_children():
				print(child.position.x, " ", child.position.y)
