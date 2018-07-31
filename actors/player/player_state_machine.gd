extends KinematicBody2D

signal state_changed

export (float) var clam_offset = 16
export (float) var translate_coef = 0.2 
export (float) var fire_rate = 0.2

onready var charged_shot_energy = GlobalConstant.PLAYER_MIN_CHARGE

var states_stack = []
var current_state = null
var _state_machine_active = true

onready var states_map = {
	"fast_shot": $States/FastShot,
	"charge_shot": $States/ChargeShot,
	"fire_charged_shot":$States/FireChargedShot,
	"cooldown_charged_shot":$States/Cooldown,
	"stagger": $States/Stagger,
	"attack": $States/Attack,
	"die": $States/Die,
}

# Native functions

func _ready():
	for state_node in $States.get_children():
		state_node.connect("finished", self, "_change_state")
		
	$GunTimer.wait_time = fire_rate
	$GunTimer.start()
	states_stack.push_front($States/Attack)
	current_state = states_stack[0]
	_change_state("attack")
	_init_attributes()

func _process(delta):
	_move_player(delta)
	_clamp_player_position(delta)

func _physics_process(delta):
	current_state.update(delta)

func _input(event):
	if event.is_action_pressed("fire") and charged_shot_energy == GlobalConstant.PLAYER_MIN_CHARGE:
		_change_state("charge_shot")

	if event.is_action_released("fire") and current_state == $States/ChargeShot:
		_change_state("fire_charged_shot")

	current_state.handle_input(event)

func _on_animation_finished(anim_name):
	current_state._on_animation_finished(anim_name)

# Public functions

func take_damage_from(attacker):
	pass

func set_controlable(value):
	set_process_input(value)
	set_physics_process(value)

# Private functions

func _change_state(state_name):
	if state_name == "previous":
		states_stack.pop_front()
	#elif state_name in ["charge_shot"]:
	#	states_stack.push_front(states_map[state_name])
	else:
		var new_state = states_map[state_name]
		states_stack[0] = new_state
		
	current_state = states_map[state_name]
	if state_name != "previous":
		current_state.enter()
		
	emit_signal("state_changed", states_stack)

func _move_player(delta):
	var motion_x = $Attributes/Speed.apply_modifier(get_global_mouse_position().x - position.x)
	var motion_y = $Attributes/Speed.apply_modifier(get_global_mouse_position().y - position.y)
	translate(Vector2(motion_x,motion_y))
	
func _clamp_player_position(delta):
	var view_size = get_viewport_rect().size
	var pos = position
	pos.x = clamp(pos.x, 0 + clam_offset, view_size.x - clam_offset)
	position = pos

func _init_attributes():
	$Attributes/Speed.init(0, GlobalConstant.PLAYER_SPEED_MODIFIER_INIT)
	$Attributes/Energy.init(0, GlobalConstant.PLAYER_SPEED_MODIFIER_INIT)
	
func _level_up():
	$Attributes/Speed.increase_level(1)
	$Attributes/Energy.increase_level(1)

# On Signal functions

func _on_Health_health_depleted():
	_change_state("die")

