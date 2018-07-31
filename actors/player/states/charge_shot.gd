extends "res://utils/states/state.gd"

var energy
var charge

signal health_updated(health)

func enter():
	energy = owner.get_node("Attributes/Energy")
	
func handle_input(event):
	pass

func update(delta):
	if owner.charged_shot_energy < GlobalConstant.PLAYER_MAX_CHARGE:
		owner.charged_shot_energy += energy.modifier
		emit_signal("health_updated", health)


