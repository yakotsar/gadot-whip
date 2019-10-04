extends KinematicBody2D
export var MAX_SPEED = 200
var target: Vector2

func _process(delta):
	
	#if Input.is_mouse_button_pressed(BUTTON_LEFT):
	target = get_global_mouse_position()
	
	var step = target - position
	
	if step.length() > 10:
		move_and_collide(step.normalized() * delta * MAX_SPEED)

		