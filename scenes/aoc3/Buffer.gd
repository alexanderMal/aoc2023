extends Node2D

signal flushed_content(star_position, content)
var buffer_content:String = ""
var star_position :int = -1
var store = false;

func _on_kernel_special_char_found():
	store = true

func _on_kernel_focus_is_number(number):
	buffer_content += number

func _on_kernel_focus_is_not_number():
	flush()

func flush():
	if store:
		flushed_content.emit(star_position, buffer_content)
		store = false
		star_position = -1
	buffer_content = ""

func _on_kernel_star_found(position):
	star_position = position
