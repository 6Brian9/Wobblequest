extends Sprite
onready var area=get_node("Area2D")
func _ready():
	set_fixed_process(true)
func _fixed_process(delta):
	for reasons in area.get_overlapping_bodies():
		get_parent().get_node("blockade").queue_free()
		set_frame(1)
		set_fixed_process(false)
		get_node("SamplePlayer").play("thump")