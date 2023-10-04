extends Node

@onready var TextsNode = %TextsNode

signal launch_dialog(main_text, button_text)

var dialog_list_fr = [
	"DEBUG",
	"Bienvenue dans MiniBonk !\n 
Je vous offre une première balle, elle vous rapportera des points en bounçant sur les murs.\n
Amusez vous bien !",

"Félicitations ! Vous avez accumulé GLOBAL1 points !\n
Vous pouvez acheter à gauche une amélioration qui doublera les points données par un bounce.",

"Peut être seriez vous interessés par une balle en plus ?",

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

"Congratulation ! You got GLOBAL1 points !\n
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

var dialog_passed = []
var dialog_list = dialog_list_fr
var button_list = button_list_fr

func _init():
	dialog_passed.resize(dialog_list_fr.size())
	dialog_passed.fill(false)
	if GLOBAL.lang == "en":
		dialog_list = dialog_list_en
		button_list = button_list_en
	for text_num in range(dialog_list.size()):
		dialog_list[text_num] = dialog_list[text_num].replace("GLOBAL1", str(GLOBAL.evolve_map["multi_bounce_1"].cost))



func points_change(current_points, total_points):
	if current_points >= GLOBAL.evolve_map["multi_bounce_1"].cost && !dialog_passed[2]:
		pass_and_execute_dialog(2)
	elif current_points >= GLOBAL.evolve_map["multi_bounce_1"].cost*2 && GLOBAL.evolve_map["multi_bounce_1"].bought && dialog_passed[2] && !dialog_passed[3]:
		pass_and_execute_dialog(3)


func pass_and_execute_dialog(dialog_ID):
	dialog_passed[dialog_ID] = true
	execute_dialog(dialog_ID)


func execute_dialog(ID):
	match ID :
		0:
			launch_dialog.emit(dialog_list[0], button_list[0])
		1:
			launch_dialog.emit(dialog_list[1], button_list[1])
		2:
			launch_dialog.emit(dialog_list[2], button_list[2])
		3:
			launch_dialog.emit(dialog_list[3], button_list[2])
		4:
			launch_dialog.emit(dialog_list[4], button_list[2])
		5:
			launch_dialog.emit(dialog_list[5], button_list[2])
		

