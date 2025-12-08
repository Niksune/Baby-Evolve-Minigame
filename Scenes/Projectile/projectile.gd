extends Node2D

@export var speed := 600

func _process(delta):
	position.y -= speed * delta
