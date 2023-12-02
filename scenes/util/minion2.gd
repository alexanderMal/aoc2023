extends Area2D
@onready var panel_container = $PanelContainer
@onready var say_timer = $say_timer
@onready var animation_player = $AnimationPlayer
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var next_action_timer = $NextActionTimer

@export var speech_time:float = 3.
@export var speed:int
var set_speed:int
var number_stored:int = -1
var my_turn
@export var distance_to_next:int = 35
# Called when the node enters the scene tree for the first time.
func _ready():
	say_timer.wait_time = speech_time
	set_speed = speed
	animated_sprite_2d.play("idle_right")
	speed = 0
	my_turn = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position += speed * delta * Vector2.RIGHT

func say(text:String):
	if my_turn:
		$PanelContainer/Label.text = text
		say_timer.start()
		animation_player.play("speech_bubble_start")

func _on_say_timer_timeout():
	animation_player.play("speech_bubble_stop")

func box_found_animation_change():
	if my_turn:
		speed = 0
		animated_sprite_2d.play("idle_right")
	
func search_next():
	speed = set_speed
	animated_sprite_2d.play("walk_right")

func _on_next_action_timer_timeout():
	if number_stored == -1:
		search_next()

func start_action():
	next_action_timer.start()

func _on_box_spawner_back_number_found(number:int):
	if my_turn:
		if number == -2:
			say("Only one number lets make it two!")
		else:
			say("Yes! its a " + str(number))
		box_found_animation_change()
		number_stored = number
		next_action_timer.start()

func _on_box_spawner_back_no_number():
	if my_turn:
		box_found_animation_change()
		say("Oh no... lets keep searching for a number")
		next_action_timer.start()


func set_next_action_timer(time:float):
	$NextActionTimer.wait_time = time
