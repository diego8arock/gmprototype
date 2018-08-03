extends Control

signal energy_updated(new_energy)

func _ready():
	get_node("Bars/EnergyBar").initialize(GlobalConstant.PLAYER_MAX_CHARGE)

func _on_Player_ui_energy_updated(energy):
	emit_signal("energy_updated", energy)
