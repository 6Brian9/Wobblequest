extends Control

export (PackedScene) var first #contains the first scene to be loaded
export (PackedScene) var grass #contains the same scene as above in grass mode
export (PackedScene) var credits #the credits
var grassmode=false

func _ready():
	get_node("Button").grab_focus()


func _on_Button_pressed():
	if !grassmode:
		get_tree().get_root().get_node("Game").loadscene(first)
		queue_free()
	else:
		print(grass)
		get_tree().get_root().get_node("Game").loadscene(grass)
		queue_free()


func _on_Button1_pressed():
	get_node("Label").show()
	get_node("Button").grab_focus()
	get_node("Button1").queue_free()


func _on_Credits_pressed():
	get_tree().get_root().get_node("Game").loadscene(credits)
	queue_free()


func _on_Button_2_pressed():
	if !grassmode:
		get_node("Button 2").set_text("grass mode: on")
		grassmode=true
	else:
		get_node("Button 2").set_text("grass mode: off")
		grassmode=false
