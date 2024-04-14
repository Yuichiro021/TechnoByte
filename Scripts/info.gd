extends Control

@onready var back_button = $back_button as Button


# Called when the node enters the scene tree for the first time.
func _ready():
	back_button.button_down.connect(on_back_press)
	pass # Replace with function body.

func on_back_press():
	get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
