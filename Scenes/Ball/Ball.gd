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
		bonk(collision)

func bonk(collision : KinematicCollision2D):
		"""
		print("BONK ! I collided with ", collision.get_collider().name)
		print("x : ",collision.get_collider().position.x," y : ",collision.get_collider().position.y)
		print("dir : ",collision.get_collider().direction)
		
		print(Time.get_unix_time_from_system())
		"""
		var name_str = self.get_instance_id()
		var other_name_str = collision.get_collider().get_instance_id()
		
		print("BONK ! ",name_str," collided with ",other_name_str," at ",Time.get_unix_time_from_system())
		
		if(!collision_board.has(name_str)):
			collision_board[name_str] = {}
			
		if(!collision_board[name_str].has(other_name_str)):
			collision_board[name_str][other_name_str] = Time.get_unix_time_from_system()
			change_direction(collision)
		elif(collision_board[name_str][other_name_str]+1 < Time.get_unix_time_from_system()):
			collision_board[name_str][other_name_str] = Time.get_unix_time_from_system()
			change_direction(collision)
			


func change_direction(collision : KinematicCollision2D):
	
	print("Direction changed !")
	
	if direction.x <= collision.get_collider().direction.x:
		direction = Vector2(-direction.x, direction.y)
		
	if direction.y <= collision.get_collider().direction.y:
		direction = Vector2(direction.x, -direction.y)
		
	EVENTS.ball_bonk.emit()
