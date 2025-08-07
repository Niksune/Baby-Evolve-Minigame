extends Node2D

@onready var BumperTextureButton = %BumperTextureButton
@onready var BumperCornerButton = %BumperCornerButton

@export var zone_id: String
var current_color: Color

	
func _ready():
	BumperTextureButton.pressed.connect(_on_texture_button_pressed)
	print("ready appelé, id :"+zone_id)
	if zone_id == "top_left":
		BumperTextureButton.texture_normal = load("res://Assets/Fonds/fond_rouge.png")

func _on_texture_button_pressed():
	print("zone cliquée :"+zone_id)
