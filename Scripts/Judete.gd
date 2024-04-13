extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var waiting := get_children()
	while not waiting.is_empty():
		var node:=waiting.pop_back() as Sprite2D
		node.set_meta("Pollution",1)
		#print(node.name,' ',node.get_meta("Pollution"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
