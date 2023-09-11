extends Node2D

var Ball = load("res://Scenes/BallGame/Ball.gd")


signal wall_bounce()



func _on_ball_wall_bounce():
	wall_bounce.emit()
	print(_on_ball_wall_bounce)

func add_ball():
	var new_ball = Ball.new()
	self.add_child(new_ball)
	
