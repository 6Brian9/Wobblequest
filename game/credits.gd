extends Control
onready var game=get_tree().get_root().get_node("Game")
func _on_Button_pressed():
	game.loadscene(game.titlescreen)
	queue_free()
