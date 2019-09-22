extends KinematicBody2D

var follows=null
var screensize=Vector2(Globals.get("display/width"),Globals.get("display/height"))
onready var cam=get_node("Camera2D")
func _ready():
	get_node("Camera2D").make_current()
	set_process(true)
func _process(delta):
	for i in get_tree().get_nodes_in_group("UI"):
		i.set_global_pos(cam.get_camera_pos()-screensize/2)
	get_node("CollisionShape2D").set_global_pos(cam.get_camera_pos())
	if get_tree().get_nodes_in_group("player").size()==1:
		follows=get_tree().get_nodes_in_group("player")[0]
	else:
		follows=null
	if follows!=null:
		var motion_remainder=move_to(follows.get_global_pos())
		if is_colliding():
			move(get_collision_normal().slide(motion_remainder))