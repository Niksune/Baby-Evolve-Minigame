extends Node2D

@onready var BumperTextureButton = %BumperTextureButton
@onready var BumperCornerButton = %BumperCornerButton

@export var ID: String
var orientation: String
var charged: bool = false

signal discharge()

var textures := {
	"vertical_rouge": preload("res://Assets/Bumpers/fond_rouge_vertical.png"),
	"vertical_turquoise": preload("res://Assets/Bumpers/fond_turquoise_vertical.png"),
	"horizontal_rouge": preload("res://Assets/Bumpers/fond_rouge_horizontal.png"),
	"horizontal_turquoise": preload("res://Assets/Bumpers/fond_turquoise_horizontal.png")
}

func set_bumper_texture(couleur: String) -> void:
	if couleur in textures:
		BumperTextureButton.texture_normal = textures[couleur]

	
func _ready():
	EVENTS.ball_wall_bounce.connect(_on_ball_wall_bounce)
	BumperTextureButton.pressed.connect(_on_texture_button_pressed)
	if "top" in ID or "bottom" in ID:
		orientation = "horizontal"
	else:
		orientation = "vertical"
	set_bumper_texture(orientation+"_rouge")


func _on_texture_button_pressed():
	print("zone cliquée :"+ID)
	if charged:
		charged = false
		set_bumper_texture(orientation+"_rouge")
		discharge.emit()
		


func _on_ball_wall_bounce(ID_bumper: String) -> void:
	if ID == ID_bumper:
		charged = true
		set_bumper_texture(orientation+"_turquoise")
