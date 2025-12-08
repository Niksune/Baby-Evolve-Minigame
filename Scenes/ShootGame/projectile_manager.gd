extends Node2D

@export var projectile_scene = load("res://Scenes/Projectile/Projectile.tscn")

func _process(delta):
	if Input.is_action_just_pressed("espace"):
		shoot()

func shoot():
	var projectile = projectile_scene.instantiate()
	self.add_child(projectile)
	projectile.global_position = %Ship.global_position
