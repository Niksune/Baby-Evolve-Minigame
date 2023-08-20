extends Node2D


@onready var dialog_manager = %DialogManager
@onready var total_points_label = %TotalPointsLabel
@onready var current_points_label = %CurrentPointsLabel


signal add_points(points_to_add)
signal pause_game()


func _ready():
	pass

	
func _input(event):
	if event.is_action_pressed("espace"):
		add_points.emit(1)
		

func points_change(current_points, total_points):
	current_points = current_points
	total_points = total_points
	refresh_UI(current_points, total_points)
	dialog_manager.points_change(current_points, total_points)


func refresh_UI(current_points, total_points):
	current_points_label.set_text(str(current_points))
	total_points_label.set_text(str(total_points))





