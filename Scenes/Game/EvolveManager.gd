extends Node

var bounce_wall_multiplicator = 1

func points_from_bounce():
	return 1 * bounce_wall_multiplicator
	

func new_evolve(ID_evolve):
	match ID_evolve:
		"double_wall_1":
			bounce_wall_multiplicator *= 2
	
