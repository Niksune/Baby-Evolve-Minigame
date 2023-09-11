extends Node2D

var BuyButton = load("res://Scenes/UI/BuyButton.gd")

@onready var dialog_box = %DialogBox
@onready var texts_node = %TextsNode
@onready var total_points_label = %TotalPointsLabel
@onready var current_points_label = %CurrentPointsLabel
@onready var menu = %Menu
@onready var evolve_list = %EvolveList

signal buy_button_pressed(ID_evolve)


func _ready():
	EVENTS.buy_button_pressed.connect(_buy_button_pressed)
		

func points_change(current_points, total_points):
	current_points = current_points
	total_points = total_points
	refresh_UI(current_points, total_points)
	

func refresh_UI(current_points, total_points):
	current_points_label.set_text(str(current_points))
	total_points_label.set_text(str(total_points))
	


func create_new_button(ID, text):
	var buy_button = BuyButton.new(ID, text)
	evolve_list.add_child(buy_button)
	

func _buy_button_pressed(ID_evolve: String):
	buy_button_pressed.emit(ID_evolve)
	
func buy_button_suppr(ID_button):
	for i in evolve_list.get_children():
		i.try_kill_ID(ID_button)




func _on_dialog_manager_launch_dialog(main_text, button_text):
	dialog_box.launch_dialog(main_text, button_text)


