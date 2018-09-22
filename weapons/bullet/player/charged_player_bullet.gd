extends "res://weapons/damage_source_body.gd"

var vel = Vector2()
export var speed = 1000

func start_at(bullet_direction, bullet_position):
	rotation = bullet_direction
	position = bullet_position
	vel = Vector2(0, speed * -1)

func _process(delta):
	position = position + vel * delta

func _on_LifeTime_timeout():
	queue_free()
