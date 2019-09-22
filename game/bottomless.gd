extends Position2D

onready var game=get_tree().get_root().get_node("Game")
var soded=false
func _ready():
	set_process(true)
	soded=false
func _process(delta):
	if !soded:
		for i in get_tree().get_nodes_in_group("player"):
			if i.get_global_pos().y>get_global_pos().y:
				soded=true
				get_node("SamplePlayer").play("SS")
				get_node("Timer").start()


func _on_Timer_timeout():
	game.get_node("Music").stop()
	game.loadscene(game.titlescreen)
	get_parent().queue_free()
	
