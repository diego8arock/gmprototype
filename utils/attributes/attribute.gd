extends Node

var level
var modifier

func init(level_init, modifier_init):
	level = level_init
	modifier = modifier_init

func increase_level(increase):
	level += increase
	adjust_modifier(level)

func adjust_modifier(level):
	pass

func apply_modifier(value):
	pass

