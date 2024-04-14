class_name MainMenu
extends Control

@onready var start_button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Start_Button as Button
@onready var exit_button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Exit_Button as Button
@onready var info_button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Info_button as Button

var start_level = preload("res://Scenes/tips_new.tscn") as PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	start_button.button_down.connect(on_start_pressed)
	exit_button.button_down.connect(on_exit_pressed)
	info_button.button_down.connect(on_info_pressed)
	pass # Replace with function body.

func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)

func on_exit_pressed() -> void:
	get_tree().quit()

func on_info_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/info.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
