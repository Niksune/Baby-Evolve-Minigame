extends CharacterBody2D

@export var speed := 400

func _process(delta):
	var dir = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	velocity.x = dir * speed
	if(position.x < 0):
		position.x = 0
	if(position.x > 900):
		position.x = 900
	move_and_slide()
