extends Area2D
var ies=false
func _on_springypart_body_enter( body ):
	if body.has_method("move"):
		body.motion.y=-2
		if Input.is_action_pressed("ui_accept"):
			body.specialcondition=true
			body.jumptimer.set_wait_time(0.6)
			body.jump()
			get_node("SamplePlayer").play("zapsplat_cartoon_bounce_spring_trampoline_fast_ascend_whistle_18125_online-audio-converter.com")


func _on_springypart_body_exit( body ):
	if body.has_method("move"):
		body.specialcondition=false
