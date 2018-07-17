extends "res://utils/states/state.gd"

export (PackedScene) var bullet

var gun_timer 
var bullet_container
var muzzle

func enter():
	gun_timer = owner.get_node("GunTimer")
	bullet_container = owner.get_node("BulletContainer")
	muzzle = owner.get_node("Muzzle")
	
func handle_input(event):
	pass

func update(delta):
	if gun_timer.time_left == 0:
		_shoot()

func _shoot():
	gun_timer.start()
	var b = bullet.instance()
	bullet_container.add_child(b)
	b.start_at(owner.rotation, muzzle.global_position) 