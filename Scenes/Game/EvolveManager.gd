extends Node

signal add_ball(number_balls)
signal add_new_evolve(ID, text, price)

var Evolve = load("res://Scenes/Game/Evolve.gd")

var bounce_wall_multiplicator = 1

var multi_bounce_counter = 1
var add_ball_counter = 1



func _ready():
	#create_new_evolve("multi_bounce_1")
	pass



func points_from_bounce():
	return 1 * bounce_wall_multiplicator



func points_change(current_points, total_points):
	if current_points >= GLOBAL.evolve_map["multi_bounce_1"].cost && !GLOBAL.evolve_map["multi_bounce_1"].buyable : 
		GLOBAL.evolve_map["multi_bounce_1"].buyable = true
		add_new_evolves()
	if current_points >= GLOBAL.evolve_map["multi_bounce_1"].cost*2 && GLOBAL.evolve_map["multi_bounce_1"].bought && !GLOBAL.evolve_map["add_ball_1"].buyable : 
		print("zoom")
		GLOBAL.evolve_map["add_ball_1"].buyable = true
		add_new_evolves()



func add_new_evolves():
	var IDbounce = ""
	var IDball = ""
	for ID_evolve in GLOBAL.evolve_map:
		var evolve = GLOBAL.evolve_map[ID_evolve]
		if evolve.in_store :
			continue
		if evolve.buyable && !evolve.in_store :
			create_new_evolve(ID_evolve)
			continue
		if multi_bounce_counter > 3 :
			IDbounce = "multi_bounce_"+str(multi_bounce_counter)
		if add_ball_counter > 3 :
			IDball = "add_ball_"+str(add_ball_counter)
		match ID_evolve:
			"multi_bounce_2":
				if GLOBAL.evolve_map["add_ball_1"].bought:
					create_new_evolve(ID_evolve)
			"multi_bounce_3":
				if GLOBAL.evolve_map["multi_bounce_2"].bought:
					create_new_evolve(ID_evolve)
			"add_ball_2":
				if GLOBAL.evolve_map["add_ball_1"].bought:
					create_new_evolve(ID_evolve)
			"add_ball_3":
				if GLOBAL.evolve_map["add_ball_2"].bought:
					create_new_evolve(ID_evolve)
			"activate_bonk":
				if GLOBAL.evolve_map["multi_bounce_3"].bought && GLOBAL.evolve_map["add_ball_3"].bought:
					create_new_evolve(ID_evolve)
			#IDbounce, IDball:
			#	create_new_evolve(ID_evolve)



func create_new_evolve(ID_evolve):
	GLOBAL.evolve_map[ID_evolve].in_store = true
	add_new_evolve.emit(ID_evolve,GLOBAL.evolve_map[ID_evolve].text,GLOBAL.evolve_map[ID_evolve].cost)


func new_evolve_bought(ID_evolve):
	print("Evolve : ",ID_evolve," bought")
	GLOBAL.evolve_map[ID_evolve].bought = true
	process_infinite_evolves(ID_evolve)
	add_new_evolves()


func process_infinite_evolves(ID_evolve):
	match GLOBAL.evolve_map[ID_evolve].modifier:
		"multi_bounce" : 
			bounce_wall_multiplicator *= GLOBAL.evolve_map[ID_evolve].factor
			multi_bounce_counter += 1
			if multi_bounce_counter >= 3:
				GLOBAL.evolve_map["multi_bounce_"+str(multi_bounce_counter)] = Evolve.new("multi_bounce", multi_bounce_counter, pow(10, multi_bounce_counter-1), false)
		"add_ball" : 
			add_ball.emit(GLOBAL.evolve_map[ID_evolve].factor)
			add_ball_counter += 1
			if add_ball_counter >= 3:
				GLOBAL.evolve_map["add_ball_"+str(add_ball_counter)] = Evolve.new("add_ball", add_ball_counter, pow(10, add_ball_counter-1), false)

