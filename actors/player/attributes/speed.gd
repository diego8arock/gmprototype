extends "res://utils/attributes/attribute.gd"

func adjust_modifier(level):
	var i = 0
	while i < level:
		modifier += GlobalConstant.PLAYER_SPEED_MODIFIER_INCREASE
		i += 1
	print(modifier)
	
func apply_modifier(value):
	return value * modifier
