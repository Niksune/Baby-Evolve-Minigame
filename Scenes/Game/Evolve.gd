extends Node

class_name Evolve

var modifier : String
var factor : int = 0
var cost : int
var is_total_points : bool = false
var text : String
var buyable : bool = false
var bought : bool = false

func _init(modifier, factor, cost, is_total_points, text="novalue"):
	self.modifier = modifier
	self.factor = factor
	self.cost = cost
	self.is_total_points = is_total_points
	if text == "novalue":
		self.text = generate_text()
	else:
		self.text = text


func generate_text():
	if self.modifier == "multi_bounce":
		return generate_bounce_text(self.factor)
	elif self.modifier == "add_ball":
		return generate_ball_text(self.factor)

func generate_bounce_text(number):
	var bounce_text = "XX Wall Bounce"
	var XXsubtitute = ""
	match number:
		2: 
			XXsubtitute = "Double"
		3: 
			XXsubtitute = "Triple"
		_:
			pass
	return bounce_text.replace("XX", XXsubtitute)

func generate_ball_text(number):
	var ball_text = "Ajoute XX Balles"
	var XXsubtitute = ""
	match number:
		1: 
			return "Ajoute Une Balle"
		2: 
			XXsubtitute = "Deux"
		3: 
			XXsubtitute = "Trois"
		_:
			pass
	return ball_text.replace("XX", XXsubtitute)
