extends Node

# InvicibilityTimer: Actor can't be damaged
# LeakTimer: Actor gets damage over time in X cycles
# WeakTimer: Actor gets X times damage over time in X cycles

export(int) var max_health

var health = 0
var leak_cycles = 0
var weaker_cycles = 0

signal health_changed
signal health_depleted
signal status_changed

func _ready():
	health = max_health
	$InvicibilityTimer.connect("timeout", self, "_on_InvicibilityTimer_timeout")
	$LeakTimer.connect("timeout", self, "_on_LeakTimer_timeout")

func _change_status(new_status):
	match status:
		GlobalConstant.STATUS_LEAK:
			$LeakTimer.stop()
		GlobalConstant.STATUS_INVINCIBLE:
			$InvicibilityTimer.stop()

	match new_status:
		GlobalConstant.STATUS_LEAK:
			leak_cycles = 0
			$LeakTimer.start()
		GlobalConstant.STATUS_INVINCIBLE:
			$InvicibilityTimer.start()
			
	status = new_status
	emit_signal('status_changed', new_status)

func take_damage_from(source):
	if health == 0 or status == GlobalConstant.STATUS_INVINCIBLE:
		return
	health -= source.damage
	health = max(0, health)
	if health == 0:
		emit_signal("health_depleted")
		return
	else:
		emit_signal("health_changed", health)
	
	if not source.effect:
		return
	match source.effect[0]:
		GlobalConstant.STATUS_LEAK:
			_change_status(GlobalConstant.STATUS_LEAK)
			leak_cycles = source.effect[1]
	
func heal(amount):
	health += amount
	health = max(health, max_health)
	emit_signal("health_changed", health)
	
func _on_InvicibilityTimer_timeout():
	_change_status(GlobalConstant.STATUS_NONE)

func _on_LeakTimer_timeout():
	take_damage(GlobalConstant.LEAK_DAMAGE)
	leak_cycles -= 1
	if leak_cycles == 0:
		_change_status(GlobalConstant.STATUS_NONE)
		return
	$LeakTimer.start()