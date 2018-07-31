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
	_shoot()
	emit_signal("finished","cooldown_charged_shot")
	
func _shoot():
	var b = charged_bullet.instance()
	bullet_container.add_child(b)
	b.start_at(owner.rotation, muzzle.global_position)