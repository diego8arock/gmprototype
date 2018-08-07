extends Node

var player_node
var player_global_position

func _ready():
	for node in get_tree().get_nodes_in_group("actors"):
		if node.name == "Player":
			player_node = node

func _process(delta):
	player_global_position = player_node.global_position
