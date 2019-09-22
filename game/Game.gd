extends Node
export (PackedScene) var titlescreen
func loadscene(scene):
	add_child(scene.instance())