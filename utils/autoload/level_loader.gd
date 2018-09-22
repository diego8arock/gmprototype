extends Node

var levels

func _ready():
	levels = get_from_json("res://files/levels/levels.json")
	var data = get_level_data("1")
	print(data)

func get_from_json(filename):
	var file = File.new()
	file.open(filename, File.READ)
	var text = file.get_as_text()
	var data = parse_json(text)
	file.close()
	return data
	
func get_level_data(level):
	var data = levels[level]
	return data