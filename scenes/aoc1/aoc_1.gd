extends Node2D
@onready var minion = $minion
@onready var score = $minion/Camera2D/PanelContainer/Label
@onready var panel_container = $minion/Camera2D/PanelContainer
@onready var reset_timer = $ResetTimer

func _ready():
	score.text = "0"

func _on_box_spawner_back_number_found(number):
	if number == -2:
		add_to_score(minion.number_stored * 10 + minion.number_stored)
	else:
		add_to_score(minion.number_stored * 10 + number)

func add_to_score(amount:int):
	panel_container.visible = true
	score.text = str(int(score.text) + amount)
	reset_timer.start()

func reset():
	$minion/Camera2D.reset()
	$BoxSpawner.reset()
	minion.reset()
	minion.speed = 500
	minion.set_speed = 500
	minion.set_next_action_timer(0.3)


func _on_reset_timer_timeout():
	reset()
