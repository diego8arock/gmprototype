extends "res://utils/states/state.gd"

var energy 

var charge

func enter():
	energy = owner.get_node("Attributes/Energy")
	pass
	
func handle_input(event):
	pass

func update(delta):
	if charge < GlobalConstant.PLAYER_MAX_CHARGE:
		charge = energy.apply_modifier(charge)
		print("charge: " + charge)

func get_charge():
	return charge

