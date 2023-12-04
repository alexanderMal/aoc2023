extends Node2D
@onready var importer = $Importer as Aoc4Importer

var list:Array
# Called when the node enters the scene tree for the first time.
func _ready():
	list = importer.prepare_data()
	task_one()
	task_two();

func task_one():
	list = importer.list
	var score:int = 0
	for el:Array in list:
		var counter = 0
		var winning_numbers:Array[int] = el[0]
		var my_numbers:Array[int] = el[1]
		for winning_number:int in winning_numbers:
			var found:int = my_numbers.find(winning_number)
			if found != -1:
				counter += 1
		var result = int(pow(2, counter-1))
		score += result
	print(score)

func task_two():
	var score:int = 0
	list = importer.list
	var wins:Array[int]
	var number_of_cards:Array[int]
	for idx in range(list.size()):
		var el = list[idx]
		var counter = 0
		var winning_numbers:Array[int] = el[0]
		var my_numbers:Array[int] = el[1]
		for winning_number:int in winning_numbers:
			var found:int = my_numbers.find(winning_number)
			if found != -1:
				counter += 1
		wins.append(counter)
	# initialize multiplyer list with ones as each card you have initially one of
	for i in range(wins.size()):
		number_of_cards.append(1)
	# increase amount of following cards by the amount of the current card
	for card_id in range(wins.size()):
		for next_card_number in range(1, wins[card_id]+1):
			number_of_cards[next_card_number + card_id] += number_of_cards[card_id]
	# sum all cards
	for number in number_of_cards:
		score+= number
	print(score)
