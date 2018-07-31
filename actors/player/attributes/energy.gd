extends "res://utils/attributes/attribute.gd"

func adjust_modifier(level):
	var i = 0
	while i < level:
		modifier += GlobalConstant.PLAYER_ENERGY_MODIFIER_INIT
		i += 1
	print(modifier)
	
func apply_modifier(value):
	return value + modifier
