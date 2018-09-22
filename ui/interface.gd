extends Control

signal energy_updated(new_energy)
signal life_updated(new_life)

func _ready():
	$Bars/EnergyBar.initialize(GlobalConstant.PLAYER_MAX_CHARGE)
	$Bars/LifeBar.initialize(GlobalConstant.PLAYER_MAX_LIFE)

func _on_Player_ui_energy_updated(energy):
	emit_signal("energy_updated", energy)

func _on_Player_ui_life_updated(value):
	emit_signal("life_updated", value)
