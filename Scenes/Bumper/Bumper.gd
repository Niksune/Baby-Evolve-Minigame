extends Node2D

@onready var BumperTextureButton = %BumperTextureButton
@onready var BumperCornerButton = %BumperCornerButton

@export var zone_id: String
var current_color: Color
var charged: bool = false

signal discharge()

var textures := {
	"rouge": preload("res://Assets/Fonds/fond_rouge.png"),
	"turquoise": preload("res://Assets/Fonds/fond_turquoise.png")
}

func set_bumper_texture(couleur: String) -> void:
	if couleur in textures:
		BumperTextureButton.texture_normal = textures[couleur]

	
func _ready():
	BumperTextureButton.pressed.connect(_on_texture_button_pressed)
	print("ready appelé, id :"+zone_id)
	if zone_id == "top_left":
		set_bumper_texture("rouge")


func _on_texture_button_pressed():
	print("zone cliquée :"+zone_id)
	if charged:
		charged = false
		set_bumper_texture("rouge")
		discharge.emit()
		


func _on_ball_game_wall_bounce() -> void:
	charged = true
	set_bumper_texture("turquoise")
