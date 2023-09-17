extends Node

signal add_ball(number_balls)
signal add_new_evolve(ID, text, price)

var Evolve = load("res://Scenes/Game/Evolve.gd")

var evolve_map = {
	"multi_bounce_1" : Evolve.new("multi_bounce", 2, 5, false),
	"multi_bounce_2" : Evolve.new("multi_bounce", 2, 5, false),
	"multi_bounce_3" : Evolve.new("multi_bounce", 2, 5, false),
	"add_ball_1" : Evolve.new("add_ball", 1, 5, false),
	"add_ball_2" : Evolve.new("add_ball", 1, 5, false),
	"add_ball_3" : Evolve.new("add_ball", 1, 5, false),
	"activate_bonk" : Evolve.new("activate_bonk", 0, 100, false, "Activer le BONK")
}

func add_new_evolves():
	for ID_evolve in evolve_map:
		var evolve = evolve_map[ID_evolve]
		if evolve.buyable :
			continue
		match ID_evolve:
			"multi_bounce_1":
				create_new_evolve(ID_evolve)
			"add_ball_1":
				if evolve_map["multi_bounce_1"].bought:
					create_new_evolve(ID_evolve)
			"multi_bounce_2":
				if evolve_map["add_ball_1"].bought:
					create_new_evolve(ID_evolve)
			"multi_bounce_3":
				if evolve_map["multi_bounce_2"].bought:
					create_new_evolve(ID_evolve)
			"add_ball_2":
				if evolve_map["add_ball_1"].bought:
					create_new_evolve(ID_evolve)
			"add_ball_3":
				if evolve_map["add_ball_2"].bought:
					create_new_evolve(ID_evolve)
			"activate_bonk":
				if evolve_map["multi_bounce_3"].bought && evolve_map["add_ball_3"].bought:
					create_new_evolve(ID_evolve)
		



var bounce_wall_multiplicator = 1




func _ready():
	create_new_evolve("multi_bounce_1")
	
	
	

func create_new_evolve(ID_evolve):
	evolve_map[ID_evolve].buyable = true
	add_new_evolve.emit(ID_evolve,evolve_map[ID_evolve].text,evolve_map[ID_evolve].cost)




func points_from_bounce():
	return 1 * bounce_wall_multiplicator
	


func new_evolve_bought(ID_evolve):
	evolve_map[ID_evolve].bought = true
	process_evolve(ID_evolve)
	add_new_evolves()
	

	

func process_evolve(ID_evolve):
	match evolve_map[ID_evolve].modifier:
		"multi_bounce" : 
			bounce_wall_multiplicator *= evolve_map[ID_evolve].factor
		"add_ball" : 
			add_ball.emit(evolve_map[ID_evolve].factor)

