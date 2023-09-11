extends CharacterBody2D


var speed = 300.0
var direction := Vector2(1.0,1.0)

@export var max_x = 852
@export var max_y = 648


signal ball_wall_bounce()

func _init():
	var sprite = Sprite2D.new()
	var placeholder = PlaceholderTexture2D.new()
	placeholder.set_size(Vector2(25, 25))
	sprite.set_texture(placeholder)
	self.add_child(sprite)


func _physics_process(_delta):
	
	if(position.x < 0 or position.x >= max_x):
		direction = Vector2(-direction.x, direction.y)
		EVENTS.ball_wall_bounce.emit()
	if(position.y < 0 or position.y >= max_y):
		direction = Vector2(direction.x, -direction.y)
		EVENTS.ball_wall_bounce.emit()
	
	velocity = direction * speed
	move_and_slide()

