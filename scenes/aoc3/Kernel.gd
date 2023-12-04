class_name Kernel extends Node2D
@onready var animated_sprite_2d = $AnimatedSprite2D
const sprite_size = 32
@export var pixel_size:int = 20;
@export var margin = 5

signal focus_is_number(number:String)
signal focus_is_not_number()
signal special_char_found()
signal star_found(position)

const kernel_size:int = 3
const half_kernel = int(kernel_size/2.0)
@export var image:MyImage
@export var placeholder:Pixel
const local_focus_idx = (kernel_size * kernel_size -1)/2
var kernel_data:Array[int] = []

func _ready():
	var new_scale = (pixel_size*kernel_size + margin)/32
	animated_sprite_2d.scale=Vector2(new_scale*0.7,new_scale)

func focus(idx:int):
	kernel_data = []
	for i in range(-1*half_kernel,half_kernel+1):
		for j in range(-1*half_kernel,half_kernel+1):
			kernel_data.append((i*(image.width + image.padding_width)) + j + idx)

func check_focus_for_num():
	var pixel = image.get_pixel(kernel_data[local_focus_idx])
	if pixel.value.is_valid_int():
		focus_is_number.emit(pixel.value)
		return true
	else:
		focus_is_not_number.emit()
		return false

func check_for_special():
	for i in range(kernel_data.size()):
		var el:Pixel = image.get_pixel(kernel_data[i])
		if !el.value.is_valid_int() && el.value != placeholder.value:
			special_char_found.emit()
			if el.value =="*":
				print(kernel_data[i])
				star_found.emit(kernel_data[i])
