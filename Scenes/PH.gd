extends Area2D

func _on_area_entered(area):
	if area is CollisionPolygon2D:
		print("Shape clicked")
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("area_entered",self,"_on_area_entered")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
