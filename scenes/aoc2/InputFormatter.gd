class_name InputFormatterAoc2 extends Node

@export var file_reader:FileReader
const IRGB = preload("res://scenes/aoc2/IRGB.tres")
var data = Array()
## returns an array with gameId and max values for red green and blue cubes
func task_one_irgb():
	var line:String
	line = file_reader.get_line()
	while line != "":
		var irgb:IRGB = IRGB.duplicate()
		var parts:PackedStringArray = line.split(";")
		var first_part:PackedStringArray = parts[0].split(":")
		var id = int(first_part[0].substr("Game ".length(), -1))
		parts[0] = first_part[1]
		var runs = Array()
		for el:String in parts:
			runs.append(to_rgb(el, id))
		data.append(runs)
		line = file_reader.get_line()
	return data

func to_rgb(text:String, id:int):
	var irgb = IRGB.duplicate()
	irgb.id = id
	var color_texts:PackedStringArray = text.split(", ")
	for el:String in color_texts:
		if el.contains("red"):
			irgb.r = int(el.substr(0, el.length()-4))
		elif el.contains("green"):
			irgb.g = int(el.substr(0, el.length()-6))
		elif el.contains("blue"):
			irgb.b = int(el.substr(0, el.length()-5))
	return irgb

