extends Node

var lang = "fr"

var evolve_map = {
	"multi_bounce_1" : Evolve.new("multi_bounce", 2, 5, false),
	"multi_bounce_2" : Evolve.new("multi_bounce", 2, 50, false),
	"multi_bounce_3" : Evolve.new("multi_bounce", 2, 100, false),
	"add_ball_1" : Evolve.new("add_ball", 1, 20, false),
	"add_ball_2" : Evolve.new("add_ball", 1, 50, false),
	"add_ball_3" : Evolve.new("add_ball", 1, 100, false),
	"activate_bonk" : Evolve.new("activate_bonk", 0, 500, false, "Activer le BONK")
}
