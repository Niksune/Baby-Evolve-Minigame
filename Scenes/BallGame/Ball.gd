extends CharacterBody2D


var speed = 300.0
var direction := Vector2(1.0,1.0)

@export var max_x = 1152
@export var max_y = 648


func _physics_process(_delta):
	
	print(position, max_x, max_y)
	
	if(position.x < 0 or position.x >= max_x):
		direction = Vector2(-direction.x, direction.y)
	if(position.y < 0 or position.y >= max_y):
		direction = Vector2(direction.x, -direction.y)
	
	velocity = direction * speed
	move_and_slide()
