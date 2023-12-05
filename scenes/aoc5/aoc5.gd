extends Node2D
@onready var importer = $Importer as Aoc5Importer

func _ready():
	importer.import_data()
	var input = importer.seeds
	print(input)
	input = map_input(input, importer.seedMap)
	print(input)
	input = map_input(input, importer.soilMap)
	input = map_input(input, importer.fertilizerMap)
	input = map_input(input, importer.waterMap)
	input = map_input(input, importer.lightMap)
	input = map_input(input, importer.temperatureMap)
	input = map_input(input, importer.humidityMap)
	
	var min:int = pow(2, 62)
	for el:int in input:
		if min > el:
			min = el
	print(min)
	
func map_input(input:Array[int], map:Array)->Array[int]:
	var output:Array[int]
	var matched = false
	for i:int in input:
		for m:Array[int] in map:
			if m[1]<=i && (m[1]+m[2])>i:
				matched = true
				output.append(m[0]+(i-m[1]))
				break
		if !matched:
			output.append(i)
		matched = false
	return output
