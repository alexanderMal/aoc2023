extends Node2D

@export var image:MyImage
@onready var panel_container = $PanelContainer
@onready var cursor = $Cursor
var cursor_init_pos:Vector2
var pixel_size:int
var line = 1

func _ready():
	print(cursor.position.x)
	cursor_init_pos = cursor.position

func render_image():
	for i in range(image._data.size()):
		var pxl:Pixel = image.get_pixel(i)
		if i % (image.width + image.padding_width) == 0 && i != 0:
			next_line()
		pxl.position = cursor.position
		panel_container.add_child(pxl)
		cursor.position.x += pxl.width()
		pixel_size = image.get_pixel(0).width()

func next_line():
	cursor.position = Vector2(cursor_init_pos.x, cursor_init_pos.y + line*pixel_size)
	line += 1
