extends CharacterBody2D
class_name Ball

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
	manage_wall_bounce()
	manage_collision()
	
	rotation += rotation_speed * _delta
	velocity = direction * speed
	move_and_slide()
	
	
func manage_wall_bounce():
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

func manage_collision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		bonk(collision.get_collider())

func bonk(collider : Ball):
	var collider_name = collider.get_instance_id()
		
	if(!collision_board.has(collider_name) || collision_board[collider_name] + 0.1 < Time.get_unix_time_from_system()):
	#if(!collision_board.has(collider_name)):
		#change_direction(collider)
		count_bonk(self.get_instance_id(), collider_name)
		collision_board[collider_name] = Time.get_unix_time_from_system()
		# And we call the collider to be sure the collision is managed by the two balls
		collider.bonk_by_colleague(self,self.duplicate())
		
		
func bonk_by_colleague(collider : Ball, duplicated_colleague):
	bonk(collider)
	
	if direction.x <= duplicated_colleague.direction.x:
		direction = Vector2(-direction.x, direction.y)
		
	if direction.y <= duplicated_colleague.direction.y:
		direction = Vector2(direction.x, -direction.y)
		

func change_direction(collider : Ball):
	if direction.x <= collider.direction.x:
		direction = Vector2(-direction.x, direction.y)
		
	if direction.y <= collider.direction.y:
		direction = Vector2(direction.x, -direction.y)


func count_bonk(name, other_name):
	var tmp
	if(other_name < name):
		tmp = name
		name = other_name
		other_name = tmp
		
	if(!GLOBAL.bonk_counted_board.has(name)):
		GLOBAL.bonk_counted_board[name] = {}
	
	if(!GLOBAL.bonk_counted_board[name].has(other_name)):
		GLOBAL.bonk_counted_board[name][other_name] = Time.get_unix_time_from_system()
		EVENTS.ball_bonk.emit()
	elif(GLOBAL.bonk_counted_board[name][other_name]+0.2 < Time.get_unix_time_from_system()):
		GLOBAL.bonk_counted_board[name][other_name] = Time.get_unix_time_from_system()
		EVENTS.ball_bonk.emit()
