class_name IRGB extends Resource

var id: int
var r: int
var g: int
var b: int

func _to_string():
	return str(id) + ":" + " r" + str(r)+" g" + str(g) + " b" + str(b)
