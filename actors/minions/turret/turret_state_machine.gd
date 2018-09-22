extends KinematicBody2D

signal state_changed

export (float) var fire_rate = 0.2
export (float) var aim_rate = 3.0
export (float) var gun_rotation_speed = 1.0
export (float) var max_bullets_fire = 3

var states_stack = []
var current_state = null
var _state_machine_active = true

onready var states_map = {
	"aim": $States/Aim,
	"attack": $States/Attack,
	"die": $States/Die,
}

func _ready():
	for state_node in $States.get_children():
		state_node.connect("finished", self, "_change_state")

	$GunTimer.wait_time = fire_rate
	$AimTimer.wait_time = aim_rate
	
	states_stack.push_front($States/Aim)
	current_state = states_stack[0]
	_change_state("aim")

func _physics_process(delta):
	rotate(delta)
	current_state.update(delta)

func take_damage_from(attacker):
	$Health.take_damage_from(attacker)
	
func rotate(delta):
	var target = GlobalVariable.player_global_position
	
	if target == null:
		return
	
	var target_dir = (target - $Gun.global_position).normalized()
	var current_dir = Vector2(1, 0).rotated($Gun.global_rotation)
	$Gun.global_rotation = current_dir.linear_interpolate(target_dir, gun_rotation_speed * delta).angle() 

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
	

func _on_Health_health_depleted():
	queue_free()

func _on_Health_health_changed(health):
	print("turret health %s" % [health])
