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

	var name_str = self.get_instance_id()
	var other_name_str = collision.get_collider().get_instance_id()
	
	print("BONK ! ",name_str," collided with ",other_name_str," at ",Time.get_unix_time_from_system())
	
	if(!collision_board.has(name_str)):
		collision_board[name_str] = {}
		
	if(!collision_board[name_str].has(other_name_str)):
		collision_board[name_str][other_name_str] = Time.get_unix_time_from_system()
		change_direction(collision)
		count_bonk(name_str, other_name_str)
	elif(collision_board[name_str][other_name_str]+0.2 < Time.get_unix_time_from_system()):
		collision_board[name_str][other_name_str] = Time.get_unix_time_from_system()
		change_direction(collision)
		count_bonk(name_str, other_name_str)
			


func change_direction(collision : KinematicCollision2D):
	
	print("Direction changed !")
	
	if direction.x <= collision.get_collider().direction.x:
		direction = Vector2(-direction.x, direction.y)
		
	if direction.y <= collision.get_collider().direction.y:
		direction = Vector2(direction.x, -direction.y)


func count_bonk(name, other_name):
	
	var tmp
	
	if(other_name < name):
		tmp = name
		name = other_name
		other_name = tmp
		
	print("name:",name," other_name:",other_name)
	
	if(!GLOBAL.bonk_counted_board.has(name)):
		GLOBAL.bonk_counted_board[name] = {}
	
	if(!GLOBAL.bonk_counted_board[name].has(other_name)):
		GLOBAL.bonk_counted_board[name][other_name] = Time.get_unix_time_from_system()
		EVENTS.ball_bonk.emit()
	elif(GLOBAL.bonk_counted_board[name][other_name]+0.2 < Time.get_unix_time_from_system()):
		GLOBAL.bonk_counted_board[name][other_name] = Time.get_unix_time_from_system()
		EVENTS.ball_bonk.emit()
