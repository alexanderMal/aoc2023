class_name Aoc3Importer extends Node

@export var reader:FileReader

const IMAGE :PackedScene = preload("res://scenes/aoc3/Image.tscn")
const PIXEL :PackedScene = preload("res://scenes/aoc3/Pixel.tscn")

func get_original_image() -> MyImage:
	var line:String = reader.get_line()
	var image = IMAGE.instantiate()
	image.width = line.length()
	image.height = 0
	while line != "":
		image.height += 1
		for idx in range(line.length()):
			var pxl = PIXEL.instantiate()
			pxl.value = line[idx]
			image.add_pixel(pxl)
		line = reader.get_line()
	return image
