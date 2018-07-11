extends Area2D

signal state_changed

var states_stack = []
var current_state = null
var _state_machine_active = true

func _ready():
	pass

func _physics_process(delta):
	pass
	
func _change_state(state_name):
	pass
	
func take_damage_from(attacker):
	pass