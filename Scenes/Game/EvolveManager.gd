extends Node

signal add_ball(number_balls)


var bounce_wall_multiplicator = 1




func points_from_bounce():
	return 1 * bounce_wall_multiplicator
	

func new_evolve(ID_evolve):
	match ID_evolve:
		"double_wall_1":
			bounce_wall_multiplicator *= 2
		"add_ball_1":
			add_ball.emit(1)
	

func give_price(ID_evolve):
	match ID_evolve:
		"double_wall_1":
			return(5)
		"add_ball_1":
			return(20)

func give_text(ID_evolve):
	match ID_evolve:
		"double_wall_1":
			return("Double Wall Bounce")
		"add_ball_1":
			return("Ajoute une Balle")

func is_total_point(ID_evolve):
	return false
