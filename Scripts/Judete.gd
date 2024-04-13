class_name Judete
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		child.set_meta("Pollution",1)
	for child in get_children():
		print(child.name," ",child.get_meta("Pollution"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index==MOUSE_BUTTON_LEFT:
			for child in get_children():
				if child is Sprite2D:
					var global_position = child.global_position
					var size = child.texture.get_size()
					var rect = Rect2(global_position,size)
					if rect.has_point(get_global_mouse_position()):
						print("Clicked on: ",child.name)
