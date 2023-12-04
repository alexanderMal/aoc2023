extends Node2D
@onready var importer = $Importer as Aoc3Importer
@onready var kernel = $Kernel as Kernel
@onready var placeholder_pixel = $PlaceholderPixel
@onready var score = $Score
@onready var star_score = $StarScore
@onready var image_display = $ImageDisplay
@onready var cursor = $ImageDisplay/Cursor

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var img:MyImage = importer.get_original_image()
	img.placeholder = placeholder_pixel
	img.add_padding()
	
	image_display.image = img
	image_display.render_image()
	kernel.image = img
	var idx_offset = img.first_image_index()
	for idx in range(img.width * img.height + img.padding_width * (img.height-1)):
		kernel.focus(idx + idx_offset)
		if kernel.check_focus_for_num():
			kernel.check_for_special()
	print(score.score)
	#kernel.global_position = img.get_pixel(5*(img.width + img.padding_width)+3).global_position
