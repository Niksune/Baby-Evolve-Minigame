extends Node

@onready var TextsNode = %TextsNode

signal launch_dialog(main_text, button_text)

var TP1 = false
var TP2 = false

var dialog_list_fr = [
	"DEBUG",
	"Bienvenue dans MiniBonk !\n 
Je vous offre une première balle, elle vous rapportera des points en bounçant sur les murs.\n
Amusez vous bien !",
"Félicitations ! Vous avez accumulé 10 points !\n
Vous pouvez acheter à gauche une amélioration qui doublera les points données par un bounce.",
"Une balle en plus peut être ?",
"Bonk ?",
"Mais, c'est quoi un bonk ?\n
Cela peut prendre un peu de temps pour arriver.\n
Un son ce produira à ce moment là."
]

var button_list_fr = [
	"DEBUG",
	"Cliquez ici pour continuer",
	"Continuer"
]

var dialog_list_en = [
	"DEBUG",
	"Welcome to Minibonk !\n
I offer you a first ball, it will give you points by bouncing on the walls.\n
Have fun !",
"Congratulation ! You got 10 points !\n
You can buy on the left an evolve that will double the points you get on each bounce.",
"Interested in an other ball maybe ?",
"Bonk ?",
"But, what is a bonk ?\n
It may take time to happen.\n 
A sound will ring out when it hits."
]

var button_list_en = [
	"DEBUG",
	"Click here to continue",
	"Continue"
]


func points_change(current_points, total_points):
	if total_points >= 2 && TP2 == false:
		TP2 = true
		execute_dialog(2)

	
func execute_dialog(ID):
	var dialog_list = dialog_list_fr
	var button_list = button_list_fr
	if GLOBAL.lang == "en":
		dialog_list = dialog_list_en
		button_list = button_list_en
	match ID :
		0:
			launch_dialog.emit(dialog_list[0], button_list[0])
		1:
			launch_dialog.emit(dialog_list[1], button_list[1])
		2:
			launch_dialog.emit(dialog_list[2], button_list[1])
		

