extends CharacterBody2D


var speed = 300.0
var direction := Vector2(1.0,1.0)

@export var max_x = 852
@export var max_y = 648
var rotation_speed = 2.0

func _init():
	position.x = randi()%852
	position.y = randi()%648

func _physics_process(_delta):
	
	rotation += rotation_speed * _delta
	
	if(position.x < 0 or position.x >= max_x):
		direction = Vector2(-direction.x, direction.y)
		EVENTS.ball_wall_bounce.emit()
	if(position.y < 0 or position.y >= max_y):
		direction = Vector2(direction.x, -direction.y)
		EVENTS.ball_wall_bounce.emit()
	
	velocity = direction * speed
	var collision = move_and_collide(velocity * _delta)
	
	if collision:
		bonk(collision)

func bonk(collision : KinematicCollision2D):
		print("BONK ! I collided with ", collision.get_collider().name)
		print("x : ",collision.get_collider().position.x," y : ",collision.get_collider().position.y)
		print("dir : ",collision.get_collider().direction)
		
		if direction.x != collision.get_collider().direction.x:
			direction = Vector2(-direction.x, direction.y)
			
		if direction.y != collision.get_collider().direction.y:
			direction = Vector2(direction.x, -direction.y)
			
		EVENTS.ball_bonk.emit()

	
	
