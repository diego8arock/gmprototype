extends "res://weapons/damage_source_body.gd"

var vel = Vector2()
export var speed = 1000

func start_at(bullet_direction, bullet_position):
	rotation = bullet_direction.angle()
	position = bullet_position
	vel = bullet_direction * speed

func _physics_process(delta):
	position = position + vel * delta

func _on_LifeTime_timeout():
	queue_free()
