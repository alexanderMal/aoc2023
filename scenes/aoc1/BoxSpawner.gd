extends Node2D

@export var box_delay:float
@export var file_reader:FileReader
@export var distance_between_boxes:int
@onready var box_spawn_point = $BoxSpawnPoint
@onready var box_delay_timer = $box_delay_timer
signal front_number_found(number)
signal front_no_number()

signal back_number_found(number)
signal back_no_number()
signal box_found()
signal elfie_created(elfie)
const MINION_2 = preload("res://scenes/util/minion2.tscn")
var index:int = 0
var line:String
var minion2
var minion_speed = -50
var next_action:float = 1.5
@onready var boxes = $Boxes

var box_scene: PackedScene = preload("res://scenes/util/char_box.tscn")

func _ready():
	box_delay_timer.wait_time = box_delay
	start_spawning_line()

func start_spawning_line():
	index = 0
	line = file_reader.get_line()
	if line.length() > 0:
		spawn_box()

func spawn_box():
	var box = box_scene.instantiate() as CharBox
	box.position = box_spawn_point.position
	box_spawn_point.position.x += distance_between_boxes
	box.fly_in_distance = 1000
	box.text_char = line[index]
	(box as Area2D).area_entered.connect(child_box_entered)
	boxes.add_child(box)
	if index != (line.length()-1):
		index += 1
		box_delay_timer.start()
	else:
		minion2 = MINION_2.instantiate()
		minion2.global_position = box_spawn_point.global_position
		minion2.name = "Elfi"
		minion2.speed = minion_speed
		minion2.set_next_action_timer(next_action)
		$"..".add_child(minion2)
		back_no_number.connect(minion2._on_box_spawner_back_no_number)
		back_number_found.connect(minion2._on_box_spawner_back_number_found)
		elfie_created.emit(minion2)
func _on_box_delay_timer_timeout():
	spawn_box()

func open_box_from_front():
	for child:CharBox in boxes.get_children():
		if !child.is_open:
			child.show_content()
			if child.is_number:
				front_number_found.emit(child.number)
			else:
				front_no_number.emit()
			break

func child_box_entered(area:Area2D):
	if area.name == "Elfi":
		open_box_from_back()
	else:
		open_box_from_front()

func open_box_from_back():
	var reverse_children = boxes.get_children()
	reverse_children.reverse()
	var found = false
	for child:CharBox in reverse_children:
		if !child.is_open:
			found = true
			child.show_content()
			if child.is_number:
				back_number_found.emit(child.number)
			else:
				back_no_number.emit()
			break
	if !found:
		back_number_found.emit(-2)

func reset():
	for box:CharBox in boxes.get_children():
		box.queue_free()
	$"..".remove_child(minion2)
	box_spawn_point.position = Vector2(0,0)
	minion_speed = -500
	next_action = 0.3
	
	start_spawning_line()
