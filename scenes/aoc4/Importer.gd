class_name Aoc4Importer extends Node

@export var file_reader:FileReader

var list:Array


func prepare_data():
	var line:String = file_reader.get_line()
	while(line != ""):
		var card_split: PackedStringArray = line.split(":")
		#var card_id:int = int(card_split[0].substr("Card ".length(), -1))
		var numbers: PackedStringArray = card_split[1].split("|")
		var winning:Array[int] = []
		for wn:String in numbers[0].split(" "):
			var number:int = int(wn)
			if number !=0:
				winning.append(number);
		var my_numbers:Array[int] = []
		for mn:String in numbers[1].split(" "):
			var number:int = int(mn)
			if number !=0:
				my_numbers.append(number);
		list.append([winning, my_numbers])
		line = file_reader.get_line()
	return list
