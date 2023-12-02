class_name CharBox extends Node2D

@onready var animation_player = $AnimationPlayer
@export var text_char:String
@onready var label = $Label
@export var fly_in_distance:int
var is_open:bool = false
var is_number:bool = false
var number:int

# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = text_char
	if text_char.is_valid_int():
		is_number = true
		number = text_char.to_int()

func show_content():
	animation_player.play("show_content")
	is_open = true

