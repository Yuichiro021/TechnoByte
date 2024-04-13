extends Node2D

var lista_texte = [
"Colectatul selectiv al deșeuri-
lor ajută la conservarea re-
surselor finite, garanteaza, de
asemenea că deșeurile nu
ajung în ape sau în natură.", 
"Dacă folosești bicicleta în
loc de masină, faci o mare fa-
voare mediului. Dacă nu, ajută
și mijlocul de transport in comun.",
"Se spune că în viață trebuie să 
faci măcar trei lucruri: să plan-
tezi un copac, să clădești o casă
și să faci măcar un copil!Așa că 
ia exemplul și plantează un copac."
]

var nr_text=randi_range(0, lista_texte.size()-1)

# Called when the node enters the scene tree for the first time.
func _ready():
	var label = $Label2
	label.text = lista_texte[nr_text]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
