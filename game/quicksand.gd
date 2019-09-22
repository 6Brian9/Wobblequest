extends Sprite
onready var area=get_node("Area2D")
func _ready():
	area.connect("body_exit",self,"onbodyexit")
	set_fixed_process(true)
func _fixed_process(delta):
	for i in area.get_overlapping_bodies():
		i.specialcondition=true
		i.GRAVITY=1.1
		i.MAXFALLSPEED=0.3
		i.SPEED=0.2
func onbodyexit(body):
	body.specialcondition=false
	body.GRAVITY=0.2
	body.MAXFALLSPEED=5.0       
	body.SPEED=1