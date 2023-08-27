extends Node2D

@onready var UI = %UI
@onready var ScoreManager = %ScoreManager


var current_points : int = 0 :
	set(x): 
		current_points = x
		print("Points ",current_points)

var total_points : int = 0 :
	set(x): 
		total_points = x
		print("Total Points ",total_points)




func add_points(points_to_add):
	current_points += points_to_add
	total_points += points_to_add
	UI.points_change(current_points, total_points)



func _on_ui_add_points(points_to_add):
	add_points(points_to_add)


func _on_wall_bounce():
	add_points(ScoreManager.points_from_bounce())





# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
