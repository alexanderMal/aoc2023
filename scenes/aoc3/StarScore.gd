extends Node2D

var score = 0
var star_list = {}

func _on_buffer_flushed_content(star_position, content):
	print("added :" + content)
	if star_list.has(star_position):
		score += int(star_list[star_position]) * int(content)
		star_list.erase(star_position)
	elif star_position != -1:
		star_list[star_position] = content
