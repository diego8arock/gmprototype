extends Area2D

func _on_HitBox_area_entered(area):
	take_damage(area)

func _on_HitBox_body_entered(body):
	take_damage(body)

func take_damage(attacker):
	if owner.is_a_parent_of(attacker) or not owner.has_node('Health'):
		return
	owner.take_damage_from(attacker)