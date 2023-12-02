extends Node
@onready var input_formatter_aoc_2:InputFormatterAoc2 = $"../InputFormatterAoc2"
const IRGB = preload("res://scenes/aoc2/IRGB.tres")
# Called when the node enters the scene tree for the first time.
func _ready():
	var data: Array = input_formatter_aoc_2.task_one_irgb()
	
	# condition one if any run contained more than the specific amount of one color
	var amount:int
	for game:Array in data:
		var irgb: IRGB = max_on_game(game)
		if valid_max_cubes(irgb):
			amount += game[0].id
	print(amount)
	
	amount = 0
	# part two
	for game:Array in data:
		var irgb: IRGB = max_on_game(game)
		amount += irgb.r * irgb.g * irgb.b
	print(amount)
	
func max_on_game(game_data:Array):
	var irgb = IRGB.duplicate()
	irgb.id = game_data[0].id
	for element:IRGB in game_data:
		if element.r > irgb.r:
			irgb.r = element.r
		if element.g > irgb.g:
			irgb.g = element.g
		if element.b > irgb.b:
			irgb.b = element.b
	return irgb

func valid_max_cubes(igrb:IRGB):
	return igrb.r <=12 && igrb.g <= 13 && igrb.b <=14
