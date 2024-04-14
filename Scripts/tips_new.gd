extends Control

var lista_texte = [
"Colectatul selectiv al deșeurilor ajută la conservarea resurselor finite, garanteaza, de asemenea că deșeurile nu ajung în ape sau în natură.", #1 
"Dacă folosești bicicleta în loc de masină, faci o mare favoare mediului. Dacă nu, ajută și mijlocul de transport in comun.", #2
"Se spune că în viață trebuie să faci măcar trei lucruri: să plantezi un copac, să clădești o casă și să faci măcar un copil!Așa că ia exemplul și plantează un copac.", #3
"Renunțând la produsele din plastic de unică folosință, poți reduce cantitatea de deșeuri plastice care poluează oceanele și mediul", #4
"Încearcă să reciclezi gunoiul, totuși, dacă nu poți să-l reciclezi măcar aruncă-l într-un loc amenajat.",#5
"Încearcă pe distanțe scurte să nu folosești un autovehicul personal. încearcă să dai acest sfat și altora Deoarece doar împreună putem schimba această problemă in amintire",#6
]

var nr_text=randi_range(0, lista_texte.size()-1)

@onready var back_button := $TextureRect/MarginContainer/VBoxContainer/HBoxContainer/back_button as Button
@onready var start_button := $TextureRect/MarginContainer/VBoxContainer/HBoxContainer/start_button as Button

@onready var level := preload("res://Scenes/level1.tscn") as PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	var label = $TextureRect/MarginContainer/VBoxContainer/Label2
	label.text = lista_texte[nr_text]
	start_button.button_down.connect(press_start_button)
	back_button.button_down.connect(press_back_button)
	
func press_back_button():
	get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")
	
func press_start_button():
	get_tree().change_scene_to_packed(level)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
