class_name MyImage extends Node2D
const PIXEL = preload("res://scenes/aoc3/Pixel.tscn")
var width:int
var height:int
var _data:Array[Pixel] = []
var _is_padded:bool = false
const padding_width:int=2
@export var placeholder:Pixel

func add_pixel(pixel:Pixel):
	_data.append(pixel)

func get_pixel(idx:int):
	return _data[idx]

func first_image_index():
	if !_is_padded:
		return 0
	else:
		return width + 3

func add_padding():
	if _is_padded: return
	_is_padded = true
	var temp_data:Array[Pixel] = []
	_add_padding_line(temp_data)
	var line_break:bool = true
	for idx in range(_data.size()):
		if line_break:
			temp_data.append(placeholder.duplicate())
			line_break = false
		temp_data.append(_data[idx])
		if (idx+1) % width == 0 && idx != 0:
			temp_data.append(placeholder.duplicate())
			line_break = true
	_add_padding_line(temp_data)
	_data = temp_data
	
	
func _add_padding_line(arr:Array[Pixel]):
	for i in range(width+2):
		arr.append(placeholder.duplicate())

func _to_string():
	var display_width = width
	if _is_padded: display_width = width +2
	var rows :String =""
	for i in range(_data.size()):
		rows += _data[i].value
		if (i+1)%display_width == 0 && i != 0:
			rows += "\n"
	return rows
