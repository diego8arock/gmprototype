extends "res://utils/states/state.gd"

export (PackedScene) var bullet

var bullet_container
var muzzle
var bullets_fired
var gun_timer
var gun

func enter():
	gun_timer = owner.get_node("GunTimer")
	bullet_container = owner.get_node("BulletContainer")
	muzzle = owner.get_node("Gun/Muzzle")
	gun = owner.get_node("Gun")
	bullets_fired = 0
	
func update(delta):
	if bullets_fired >= owner.max_bullets_fire:
		emit_signal("finished", "aim")
		return
	
	if gun_timer.time_left == 0:
		gun_timer.start()
	
func _shoot():
	var b = bullet.instance()
	bullet_container.add_child(b)
	var gun_rotation = Vector2(1, 0).rotated(gun.global_rotation)
	b.start_at(gun_rotation, muzzle.global_position) 
	bullets_fired += 1

func _on_GunTimer_timeout():
	_shoot()
