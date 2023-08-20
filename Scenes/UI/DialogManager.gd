extends Node

@onready var dialog_box = %DialogBox
@onready var texts_node = %TextsNode

var TP2 = false





func points_change(current_points, total_points):
	if total_points >= 2 && TP2 == false:
		TP2 = true
		launch_dialog(texts_node.dialog2(), texts_node.button1())



func launch_dialog(mainText, buttonText):
	dialog_box.launch_dialog(mainText, buttonText)



# Called when the node enters the scene tree for the first time.
func _ready():
	launch_dialog(texts_node.dialog1(), texts_node.button1())
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
