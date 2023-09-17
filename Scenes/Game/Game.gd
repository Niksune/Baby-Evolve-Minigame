extends Node2D

@onready var UI = %UI
@onready var EvolveManager = %EvolveManager
@onready var DialogManager = %DialogManager


var current_points : int = 100
var total_points : int = 0



func _ready():
	DialogManager.execute_dialog(1)



func add_points(points_to_add):
	current_points += points_to_add
	total_points += points_to_add
	send_update_points()
	
func remove_points(points_to_remove):
	current_points -= points_to_remove
	send_update_points()

func send_update_points():
	UI.points_change(current_points, total_points)
	DialogManager.points_change(current_points, total_points)



func create_new_evolve_button(ID_evolve):
	UI.create_new_button(ID_evolve, EvolveManager.give_text(ID_evolve), EvolveManager.give_price(ID_evolve))


func check_buying(ID_evolve):
	var evolve = EvolveManager.evolve_map[ID_evolve]
	if(!evolve.is_total_points):
		if(evolve.cost <= current_points):
			remove_points(evolve.cost)
			EvolveManager.new_evolve_bought(ID_evolve)
			UI.buy_button_suppr(ID_evolve)
		else:
			print(ID_evolve," too expensive")
	else:
		pass
		
	

func _on_wall_bounce():
	add_points(EvolveManager.points_from_bounce())


func _on_ui_buy_button_pressed(ID_evolve):
	check_buying(ID_evolve)

