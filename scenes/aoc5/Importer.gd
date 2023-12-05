class_name Aoc5Importer extends Node

@export var file_reader:FileReader

var seeds:Array[int]
var seedMap:Array=[]
var soilMap:Array=[]
var fertilizerMap:Array=[]
var waterMap:Array=[]
var lightMap:Array=[]
var temperatureMap:Array=[]
var humidityMap:Array=[]
# Called when the node enters the scene tree for the first time.
func import_data():
	var temp_array = seeds
	var line:String = file_reader.get_line()
	seeds.append_array(string_arr_to_int_arr(line.substr("seeds: ".length(), -1).split(" ")))
	while !file_reader.file.eof_reached():
		line = file_reader.get_line()
		match line:
			"seed-to-soil map:":
				temp_array = seedMap
				continue
			"soil-to-fertilizer map:":
				temp_array = soilMap
				continue
			"fertilizer-to-water map:":
				temp_array = fertilizerMap
				continue
			"water-to-light map:":
				temp_array = waterMap
				continue
			"light-to-temperature map:":
				temp_array = lightMap
				continue
			"temperature-to-humidity map:":
				temp_array = temperatureMap
				continue
			"humidity-to-location map:":
				temp_array = humidityMap
				continue
		if line == "":continue
		temp_array.append(string_arr_to_int_arr(line.split(" ")))
	print(seeds)
	print("-------------")
	print(humidityMap)

func string_arr_to_int_arr(data:PackedStringArray)-> Array[int]:
	var temp_array:Array[int]
	for element:String in data:
		temp_array.append(int(element))
	return temp_array
