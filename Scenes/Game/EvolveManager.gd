extends Node

signal add_ball(number_balls)
signal add_new_evolve(ID, text, price)

var Evolve = load("res://Scenes/Game/Evolve.gd")

var bounce_wall_multiplicator = 1

var multi_bounce_counter = 1
var add_ball_counter = 1

var evolve_map = {
	"multi_bounce_1" : Evolve.new("multi_bounce", 2, 10, false),
	"multi_bounce_2" : Evolve.new("multi_bounce", 2, 5, false),
	"multi_bounce_3" : Evolve.new("multi_bounce", 2, 5, false),
	"add_ball_1" : Evolve.new("add_ball", 1, 50, false),
	"add_ball_2" : Evolve.new("add_ball", 1, 5, false),
	"add_ball_3" : Evolve.new("add_ball", 1, 5, false),
	"activate_bonk" : Evolve.new("activate_bonk", 0, 100, false, "Activer le BONK")
}

func add_new_evolves():
	for ID_evolve in evolve_map:
		var evolve = evolve_map[ID_evolve]
		if !evolve.buyable :
			continue
		if evolve.buyable && evolve.in_store == false :
			create_new_evolve(ID_evolve)
			continue
		var IDbounce = "multi_bounce_"+str(multi_bounce_counter)
		var IDball = "add_ball_"+str(add_ball_counter)
		match ID_evolve:
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
			IDbounce, IDball:
				create_new_evolve(ID_evolve)



func _ready():
	#create_new_evolve("multi_bounce_1")
	pass


func points_change(current_points, total_points):
	if current_points >= 10 && evolve_map["multi_bounce_1"].buyable == false : 
		evolve_map["multi_bounce_1"].buyable = true
		add_new_evolves()
	if current_points >= 20 && evolve_map["add_ball_1"].buyable == false : 
		evolve_map["add_ball_1"].buyable = true
		add_new_evolves()



func points_from_bounce():
	return 1 * bounce_wall_multiplicator
	



func create_new_evolve(ID_evolve):
	evolve_map[ID_evolve].in_store = true
	add_new_evolve.emit(ID_evolve,evolve_map[ID_evolve].text,evolve_map[ID_evolve].cost)


func new_evolve_bought(ID_evolve):
	print("Evolve : ",ID_evolve," bought")
	evolve_map[ID_evolve].bought = true
	process_infinite_evolves(ID_evolve)
	add_new_evolves()


func process_infinite_evolves(ID_evolve):
	match evolve_map[ID_evolve].modifier:
		"multi_bounce" : 
			bounce_wall_multiplicator *= evolve_map[ID_evolve].factor
			multi_bounce_counter += 1
			if multi_bounce_counter >= 3:
				evolve_map["multi_bounce_"+str(multi_bounce_counter)] = Evolve.new("multi_bounce", multi_bounce_counter, pow(10, multi_bounce_counter-1), false)
		"add_ball" : 
			add_ball.emit(evolve_map[ID_evolve].factor)
			add_ball_counter += 1
			if add_ball_counter >= 3:
				evolve_map["add_ball_"+str(add_ball_counter)] = Evolve.new("add_ball", add_ball_counter, pow(10, add_ball_counter-1), false)

