extends X # Replace this with anything else (Resource recommended) and add it to AutoLoad.

func _ready() -> void:
	var parser = JeanParser.new()
	var data = parser.parse_jean_file("res://example.jean")
	print(data)
