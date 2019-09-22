extends Sprite

signal collected

func _ready():
	pass

func _on_Area2D_body_enter( body ):
	queue_free()
	emit_signal("collected")
