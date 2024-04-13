extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		child.set_meta("Pollution",1)
	for child in get_children():
		print(child.name," ",child.get_meta("Pollution"))
		#print(node.name,' ',node.get_meta("Pollution"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for child in get_children():
		pass
