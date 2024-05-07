extends CharacterBody2D


var speed = 300.0
var direction := Vector2(1.0,1.0)

@export var max_x = 852
@export var max_y = 648
var rotation_speed = 2.0
var collision_board: Dictionary


func _init():
	position.x = randi()%852
	position.y = randi()%648

func _physics_process(_delta):
	
	rotation += rotation_speed * _delta
	
	if(position.x < 0 and direction.x < 0):
		direction = Vector2(-direction.x, direction.y)
		EVENTS.ball_wall_bounce.emit()
	if(position.y < 0 and direction.y < 0):
		direction = Vector2(direction.x, -direction.y)
		EVENTS.ball_wall_bounce.emit()
	if(position.x >= max_x and direction.x > 0):
		direction = Vector2(-direction.x, direction.y)
		EVENTS.ball_wall_bounce.emit()
	if(position.y >= max_y and direction.y > 0):
		direction = Vector2(direction.x, -direction.y)
		EVENTS.ball_wall_bounce.emit()
	
	velocity = direction * speed
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		EVENTS.ball_bonk.emit(self, collision.get_collider())
		
func get_direction_x():
	return direction.x
	
func get_direction_y():
	return direction.y
