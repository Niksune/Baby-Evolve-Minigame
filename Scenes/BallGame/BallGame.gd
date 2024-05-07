extends Node2D

@export var ball_scene = preload("res://Scenes/Ball/Ball.tscn")
@onready var BonkManager = %BonkManager


signal wall_bounce()
signal bonk()


func _ready():
	EVENTS.ball_wall_bounce.connect(_on_ball_wall_bounce)
	add_ball()



func _on_ball_wall_bounce():
	wall_bounce.emit()

func add_ball():
	var new_ball = ball_scene.instantiate()
	self.add_child(new_ball)
	


func _on_evolve_manager_add_ball(number_balls):
	for i in number_balls:
		add_ball()

func _on_bonk_manager_bonk_points():
	bonk.emit()
