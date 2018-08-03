extends HBoxContainer

signal maximum_changed(maximum)

var maximum = GlobalConstant.PLAYER_MAX_CHARGE
var current_charge = GlobalConstant.PLAYER_MAX_CHARGE

func initialize(max_value):
	maximum = max_value
	emit_signal("maximum_changed", maximum)

func _on_Interface_energy_updated(new_energy):
	animate_value(current_charge, new_energy)
	current_charge = new_energy

func animate_value(start, end):
	$Tween.interpolate_property($TextureProgress, "value", start, end, 0.5, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$Tween.start()
	#if end < start:
	#	$AnimationPlayer.play("shake")
