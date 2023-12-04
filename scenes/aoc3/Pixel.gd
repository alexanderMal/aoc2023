class_name Pixel extends Node2D

@export var value:String
@onready var label:Label = $Label
@export var pixel_size:int = 50
@export var fonz_size:int = 50

func _ready():
	label.text = value
	label.size = Vector2(pixel_size,pixel_size)
	label.add_theme_font_size_override("font_size", fonz_size)

func _to_string():
	return value

func width():
	return label.size.x
