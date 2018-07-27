extends "res://utils/states/state.gd"

export (PackedScene) var charged_bullet

var gun_timer 
var bullet_container
var muzzle

func enter():
	bullet_container = owner.get_node("BulletContainer")
	muzzle = owner.get_node("Muzzle")
	
func handle_input(event):
	pass

func update(delta):
	if gun_timer.time_left == 0:
		_shoot()