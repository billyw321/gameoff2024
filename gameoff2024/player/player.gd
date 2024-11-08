extends CharacterBody2D


@export var MAX_SPEED = 175
@export var ACCELERATION = 1500
@export var FRICTION = 1200
# Adjust these values to your liking, im still tweaking the movement but im sticking with this for now
@onready var axis = Vector2.ZERO


func _physics_process(delta):
	move(delta) # Calls move function
	
	
	
func get_input_axis():
	axis.x= int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left")) # Assigns left and right onto the x axis values
	axis.y= int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up")) # Assigns up and down ot the y axis values
	return(axis.normalized())

func move(delta):
	
	axis = get_input_axis()
	if axis == Vector2.ZERO:
		apply_friction(FRICTION * delta)
	
	else:
		apply_movement(axis * ACCELERATION * delta)
	
	move_and_slide()



func apply_friction(amount): # Applying Friction
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO
		
		
func apply_movement(accel):
	velocity += accel
	velocity = velocity.limit_length(MAX_SPEED)

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Entered")
	position.x = 0
	position.y = 0
	if body.position.x == 0 && body.position.y == 0:
		print("Moved body.")
