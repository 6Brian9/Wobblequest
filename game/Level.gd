extends Node

export (AudioStream) var bgm
export (PackedScene) var crd

onready var game=get_tree().get_root().get_node("Game")
onready var ui=get_node("LevelUI")
var collected=0
var allsprites=0
func _ready():
	for i in get_node("Wobblesprites").get_children():
		allsprites+=1
		i.connect("collected",self,"collect")
	ui.get_node("Label").set_text(": "+str(collected)+"/"+str(allsprites))
	game.get_node("Music").set_stream(bgm)
	game.get_node("Music").play()

func collect():
	collected+=1
	ui.get_node("Label").set_text(": "+str(collected)+"/"+str(allsprites))
	if collected==allsprites:
		game.get_node("Music").stop()
		get_node("SamplePlayer").play("JC_uberst.")
		ui.get_node("Sprite").hide()
		ui.get_node("Label").hide()
		ui.get_node("TextureFrame").show()
		get_node("KinematicBody2D").queue_free()

func _on_Button_pressed():
	game.get_node("Music").stop()
	game.loadscene(game.titlescreen)
	queue_free()

func _on_Button_2_pressed():
	game.get_node("Music").stop()
	game.loadscene(crd)
	queue_free()

