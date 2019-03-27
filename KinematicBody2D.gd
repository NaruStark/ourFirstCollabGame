extends KinematicBody2D

const GRAVITY = 20;
const ACCELERATION = 40;
const MAX_SPEED = 300;
const JUMP_HEIGHT = 600;
const UP = Vector2(0, -1)
var motion = Vector2()
var can_fall = true;

func new_anim(anim):  
	if $Sprite.animation != anim:
		$Sprite.play(anim)                  
	else:  
		return  

func _physics_process(delta):
	motion.y += GRAVITY
	
	var friction = false;
	var falling = false;
	
	if Input.is_action_pressed('ui_right'):
		motion.x = min(motion.x+ACCELERATION, MAX_SPEED)
		$Sprite.flip_h = false
		$Sprite.play("Run")
	elif Input.is_action_pressed('ui_left'):
		motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
		$Sprite.flip_h = true
		$Sprite.play("Run")
	else:
		$Sprite.play("Idle")
		friction = true;
		
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -JUMP_HEIGHT
			$Sprite.play("Jump")
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
	else:
		if motion.y < 0:
			can_fall = true;
			$Sprite.play("Jump")
		else:
			if can_fall == true:
				can_fall = false;
				$Sprite.play("Fall")
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.05)
	
	#if Input.is_action_pressed('ui_up'):
	#	motion.y = -100
	#elif Input.is_action_pressed('ui_down'):
	#	motion.y = 100
	#else:
	#	motion.y = 0
	
	motion = move_and_slide(motion, UP)
	pass
