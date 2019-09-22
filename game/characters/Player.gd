extends KinematicBody2D

signal I_fucking_died

onready var game=get_tree().get_root().get_node("Game")

onready var anim=get_node("Sprite/AnimationPlayer")
onready var jumptimer=get_node("jumptime")
onready var wbltwn=get_node("WobbleTween")

export var GRAVITY=9.81
export var JUMP_FORCE=5.0
export var SPEED=1.0
export var MAXFALLSPEED=5.0
export var dir="r"

onready var origscale=get_scale()
var ducking=false
var timerstopped=true
var stilljumping=false
var airborne=false
var specialcondition=false
var moving=false
var motion=Vector2()
var mayrecieveinput=true
var isplaying=false
var maxwobblefactor=0.8

func _ready():
	set_process_input(true)
	set_fixed_process(true)

func _fixed_process(delta):
	if dir=="r":
		get_node("Sprite").set_scale(Vector2(1,1))
	elif dir=="l":
		get_node("Sprite").set_scale(Vector2(-1,1))
#	if !moving and !airborne and anim.get_current_animation()!="Idle_r":
#		anim.play("Idle_r")
	if moving and !isplaying:
		anim.play("when u w4lking")
		isplaying=true
	elif !moving:
		anim.play("idle")
		isplaying=false
#	elif airborne:
#		anim.play("jump_r")
	if Input.is_action_pressed("ui_right") and mayrecieveinput:
		dir="r"
		moving=true
		motion.x=1
	elif Input.is_action_pressed("ui_left") and mayrecieveinput:
		dir="l"
		moving=true
		motion.x=-1
	else:
		moving=false
		motion.x=0
	motion.y+=GRAVITY
	if Input.is_action_pressed("ui_down"):
		if !ducking:
			wbltwn.stop_all()
			var cr=float(get_parent().collected)/float(get_parent().allsprites)
			wbltwn.interpolate_property(self,"transform/scale",get_scale(), Vector2(origscale.x+origscale.x*(maxwobblefactor*cr),origscale.y*(1-maxwobblefactor*cr)),0.46,Tween.TRANS_LINEAR,Tween.EASE_OUT)
			wbltwn.start()
			ducking=true
	else: 
		if ducking:
			wbltwn.stop_all()
			wbltwn.interpolate_property(self,"transform/scale",get_scale(),origscale,0.3,Tween.TRANS_BACK,Tween.EASE_OUT)
			ducking=false
			wbltwn.start()
	if motion.y>MAXFALLSPEED:
		motion.y=MAXFALLSPEED
	var motion_remainder=move(Vector2(motion.x*SPEED,motion.y))
	if is_colliding():
		if get_collider().has_method("get_collision_layer"):
			if get_collider().get_collision_layer()==1024:
				anim.play("ded")
				set_fixed_process(false)
		var normal=get_collision_normal()
		if normal.y!=0:#if the slope is not actually a wall (1=sin(90))
			if get_travel().length()<0.9 and motion.x==0: 
				revert_motion()
				motion_remainder=Vector2()
#the three lines above prevent the character from weirdly sliding off the slope
#when they're not supposed to be moving
			else:
				if dir=="l":
					motion_remainder=Vector2(-1,0)
				elif dir=="r":
					motion_remainder=Vector2(1,0)
		
		if normal.y<0 or specialcondition:#if the collision is from the bottom 
			airborne=false
			motion.y=2
		else:
			airborne=true
		if moving:
			var slopemovement
			slopemovement=normal.slide(motion_remainder)
#			if normal.y>-1 and normal.y<0:
#				if normal.x<0:#dl-ur slope                             \
#					slopemovement.y=slopemovement.y/slopemovement.x#   |
#				elif normal.x>0:#ul-dr slope                           |these lines are responsible for the character having the same x-velocity without colliding into the slopes
#					slopemovement.y=slopemovement.y/-slopemovement.x#  |
#				slopemovement.x=motion_remainder.x#                    /
			slopemovement=move(slopemovement*SPEED)
	elif specialcondition:
		airborne=false
	else:
		airborne=true
	if Input.is_action_pressed("ui_accept"):
		if stilljumping:
			motion.y=-JUMP_FORCE
	else:
		stilljumping=false
func _input(event):
	if event.is_action_pressed("ui_accept"):
		jump()
		if !airborne:
			get_node("SamplePlayer").play("Woosh-Mark_DiAngelo-4778593")
func jump():
	if (!airborne or specialcondition) and timerstopped:
		timerstopped=false
		jumptimer.start()
		stilljumping=true
func _on_jumptime_timeout():
	jumptimer.set_wait_time(0.2)
	timerstopped=true
	stilljumping=false

func dies():
	game.get_node("Music").stop()
	game.loadscene(game.titlescreen)
	get_parent().queue_free()