extends KinematicBody2D

export (float) var clam_offset = 16
export (float) var translate_coef = 0.2 
export (float) var fire_rate = 0.2

signal state_changed
signal direction_changed(new_direction)
signal position_changed(new_position)

var states_stack = []
var current_state = null
var _state_machine_active = true

onready var states_map = {
	"fast_shot": $States/FastShot,
	"charge_shot": $States/ChargeShot,
	"stagger": $States/Stagger,
	"attack": $States/Attack,
	"die": $States/Die,
}

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
	current_state.handle_input(event)


func _on_animation_finished(anim_name):
	current_state._on_animation_finished(anim_name)


func _change_state(state_name):
	current_state.enter()


func take_damage_from(attacker):
	pass


func _on_Health_health_depleted():
	_change_state("die")


func set_controlable(value):
	set_process_input(value)
	set_physics_process(value)

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
	
func _level_up():
	$Attributes/Speed.increase_level(1)
