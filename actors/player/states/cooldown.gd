extends "res://utils/states/state.gd"

var cooldown_timer

func enter():
	cooldown_timer = owner.get_node("CooldownChargedShoot")
	cooldown_timer.start()

func _on_CooldownChargedShoot_timeout():
	emit_signal("finished","attack")
