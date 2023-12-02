extends Camera2D

@onready var role_change_timer = $RoleChangeTimer
var Elfie:Node2D
@onready var zoom_out_timer = $ZoomOutTimer
@onready var minion = $".."

func _on_minion_role_change():
	role_change_timer.start()

func _on_role_change_timer_timeout():
	global_position = Vector2(Elfie.global_position.x, global_position.y)
	Elfie.my_turn = true
	Elfie.say("Of course!")
	Elfie.start_action();
	zoom_out_timer.start()


func _on_box_spawner_elfie_created(elfie):
	Elfie = elfie


func _on_zoom_out_timer_timeout():
	var pos_offset = (Elfie.global_position - minion.global_position)/2
	global_position = Vector2(Vector2(pos_offset + minion.global_position).x, global_position.y)
	offset = Vector2(0, offset.y)
	zoom = Vector2(1.3,1.3)

func reset():
	zoom = Vector2(1.5,1.5)
	global_position = Vector2(minion.global_position.x,global_position.y)
	role_change_timer.wait_time = 0.3
