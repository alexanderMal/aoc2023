class_name FileReader extends Node
@export_file("*.txt")  var file_path
var file:FileAccess
# Called when the node enters the scene tree for the first time.
func _ready():
	file = FileAccess.open(file_path, FileAccess.READ)

func get_line()->String:
	return file.get_line()
