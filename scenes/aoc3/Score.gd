extends Node2D

var score:int

func _on_buffer_flushed_content(pos, content):
	score += int(content)
