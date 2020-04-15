extends KinematicBody

onready var Camera = $Pivot/Camera

var gravity = -30
var max_speed = 12
var mouse_sensitivity = 0.005
var mouse_range = 1.2
var scaling = true

var velocity = Vector3()

func get_input():
	var input_dir = Vector3()
	if Input.is_action_pressed("forward"):
		input_dir += -Camera.global_transform.basis.z
	if Input.is_action_pressed("back"):
		input_dir += Camera.global_transform.basis.z
	if Input.is_action_pressed("left"):
		input_dir += -Camera.global_transform.basis.x
	if Input.is_action_pressed("right"):
		input_dir += Camera.global_transform.basis.x
	input_dir = input_dir.normalized()
	if Input.is_action_pressed("space"):
		move_gun()
	return input_dir
func move_gun():
	if(scaling):
		get_node("Pivot/Gun_Location").scale.y +=.1
		print(get_node("Pivot/Gun_Location").scale.y)
		get_node("Timer").start()
		scaling = false
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		$Pivot.rotate_x(-event.relative.y * mouse_sensitivity)
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -mouse_range, mouse_range)

func _physics_process(delta):
	velocity.y += gravity * delta
	var desired_velocity = get_input() * max_speed
	
	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z
	velocity = move_and_slide(velocity, Vector3.UP, true)
	if get_slide_count() != 0:
		for i in range (0,get_slide_count()):
			if get_slide_collision(i).collider.name == "BlueBall" and !scaling:
				$"../HUD/ScoreBox/Score".won=true



func _on_Timer_timeout():
	get_node("Pivot/Gun_Location").scale.y -=.1
	print(get_node("Pivot/Gun_Location").scale.y)
	scaling = true
