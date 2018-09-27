extends Node

var states_stack = []
var current_state = null
var _state_machine_active = true

var boss_dead = false
export (PackedScene) var minions = []

onready var states_map = {
	"start": $States/Start,
	"battle": $States/Battle,
	"defeat": $States/Defeat,
	"victory": $States/Victory,
}

func _ready():
	for state_node in $States.get_children():
		state_node.connect("finished", self, "_change_state")
	_change_state("start")

func _process(delta):
	current_state.update(delta)

func _change_state(state_name):
	if state_name == "previous":
		states_stack.pop_front()
	else:
		var new_state = states_map[state_name]
		states_stack[0] = new_state
		
	current_state = states_map[state_name]
	if state_name != "previous":
		current_state.enter()
		
	emit_signal("state_changed", states_stack)
