extends Node2D

@onready var dialog_label = %DialogLabel
@onready var dialog_button = %DialogButton



func launch_dialog(mainText, buttonText):
	change_dialog(mainText, buttonText)
	self.visible = true
	get_tree().paused = true
	

func close_dialog():
	self.visible = false
	get_tree().paused = false


func change_dialog(mainText, buttonText):
	dialog_label.set_text(mainText)
	dialog_button.set_text(buttonText)



func _on_dialog_button_pressed():
	close_dialog()
