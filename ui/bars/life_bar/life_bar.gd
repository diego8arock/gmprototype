extends HBoxContainer

signal maximum_changed(maximum)

var maximum = GlobalConstant.PLAYER_MAX_LIFE
var current_health = GlobalConstant.PLAYER_MAX_CHARGE

func initialize(max_value):
	maximum = max_value
	emit_signal("maximum_changed", maximum)

func animate_value(start, end):
	$Tween.interpolate_property($TextureProgress, "value", start, end, 0.5, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$Tween.start()
#	if end < start:
#		$AnimationPlayer.play("shake")

func _on_Interface_life_updated(new_life):
	animate_value(current_health, new_life)
	current_health = new_life
