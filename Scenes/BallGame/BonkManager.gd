extends Node

var bonk_counted_board: Dictionary
var bonk_direction_board: Dictionary
var flag_direction_bonk: bool = false

signal bonk_points()

func _ready():
	EVENTS.ball_bonk.connect(_get_bonk_to_manage)


func _get_bonk_to_manage(ball1, ball2): 
	"""
	var name_str = ball1.get_instance_id()
	var other_name_str = ball2.get_collider().get_instance_id()
	print("BONK ! ",name_str," collided with ",other_name_str," at ",Time.get_unix_time_from_system())
	"""
	#bonk_points.emit()
	
	manage_flag_direction_bonk()
	
	var tmp
	if(ball1.get_instance_id() < ball2.get_instance_id()):
		tmp = ball1
		ball1 = ball2
		ball2 = tmp
	
	bonk_direction_board[ball1] = [ball2, ball1.get_direction_x(), ball1.get_direction_y(), ball2.get_direction_x(), ball2.get_direction_y()]
	


func manage_flag_direction_bonk(): 
	
	if !flag_direction_bonk:
		flag_direction_bonk = true
		await get_tree().create_timer(0.01).timeout
		flag_direction_bonk = false
		manage_directions()
	
	

func manage_directions(): 
	
	for ball1 in bonk_direction_board:
		var ball2 = bonk_direction_board[ball1][0]
		var direct_ball1_x = bonk_direction_board[ball1][1]
		var direct_ball1_y = bonk_direction_board[ball1][2]
		var direct_ball2_x = bonk_direction_board[ball1][3]
		var direct_ball2_y = bonk_direction_board[ball1][4]
		
		if direct_ball1_x != direct_ball2_x:
			ball1.direction.x = -direct_ball1_x
			ball2.direction.x = -direct_ball2_x
			
		if direct_ball1_y != direct_ball2_y:
			ball1.direction.y = -direct_ball1_y
			ball2.direction.y = -direct_ball2_y
			
		
		bonk_points.emit()
	
	bonk_direction_board = {}
	


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
