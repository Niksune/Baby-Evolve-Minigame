extends Node2D

@onready var UI = %UI
@onready var EvolveManager = %EvolveManager
@onready var DialogManager = %DialogManager


var current_points : int = 0

var total_points : int = 0



func _ready():
	UI.create_new_button("double_wall_1", "Doublez les gains")
	UI.create_new_button("add_ball_1", "Ajoute une balle")
	DialogManager.execute_dialog(1)



func add_points(points_to_add):
	current_points += points_to_add
	total_points += points_to_add
	UI.points_change(current_points, total_points)
	DialogManager.points_change(current_points, total_points)



func _on_wall_bounce():
	add_points(EvolveManager.points_from_bounce())


func evolve_button_pressed(text):
	print(text)




func _on_ui_buy_button_pressed(ID_evolve):
	EvolveManager.new_evolve(ID_evolve)
	UI.buy_button_suppr(ID_evolve)
