extends "res://utils/states/state.gd"

export (PackedScene) var bullet

var gun_timer 
var bullet_container
var muzzle
var energy

func enter():
	gun_timer = owner.get_node("GunTimer")
	bullet_container = owner.get_node("BulletContainer")
	muzzle = owner.get_node("Muzzle")
	energy = owner.get_node("Attributes/Energy")
	
func handle_input(event):
	pass

func update(delta):
	if gun_timer.time_left == 0:
		_shoot()
	_recharge()

func _shoot():
	gun_timer.start()
	var b = bullet.instance()
	bullet_container.add_child(b)
	b.start_at(owner.rotation, muzzle.global_position) 

func _recharge():
	if owner.charged_shot_energy < GlobalConstant.PLAYER_MIN_CHARGE:
		owner.charged_shot_energy = GlobalConstant.PLAYER_MIN_CHARGE
	
	if owner.charged_shot_energy > GlobalConstant.PLAYER_MIN_CHARGE:
		owner.charged_shot_energy -= energy.modifier
	