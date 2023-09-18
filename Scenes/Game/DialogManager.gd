extends Node

@onready var TextsNode = %TextsNode

signal launch_dialog(main_text, button_text)

var TP1 = false
var TP2 = false




func points_change(current_points, total_points):
	if total_points >= 2 && TP2 == false:
		TP2 = true
		#execute_dialog(2)

	
func execute_dialog(ID):
	match ID :
		0:
			launch_dialog.emit(TextsNode.dialog0(), TextsNode.button0())
		1:
			launch_dialog.emit(TextsNode.dialog1(), TextsNode.button1())
		2:
			launch_dialog.emit(TextsNode.dialog2(), TextsNode.button1())
		

