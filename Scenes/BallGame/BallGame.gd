extends Node2D

signal wall_bounce()



func _on_ball_wall_bounce():
	wall_bounce.emit()
	print(_on_ball_wall_bounce)
