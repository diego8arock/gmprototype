extends "res://utils/states/state.gd"

func enter():
	var aim_timer = owner.get_node("AimTimer")
	aim_timer.start()
	

func _on_AimTimer_timeout():
	emit_signal("finished", "attack")
