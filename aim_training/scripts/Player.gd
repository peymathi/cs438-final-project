extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Mouse sensitivity
var rotate_speed = 0.01
var velocity = Vector3.ZERO
var y_velocity = 0

var speed = 2
var gravity = -.15
var jump_speed = 4
var speed_cap = 4
var virtual_friction = 0.25
var is_sprinting = false
var is_crouched = false
var controller_deadzone = 0.005
var controller_horizontal_rotation_amount = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Called every physics frame
func _physics_process(delta):
	
	# Apply gravity if we are in the air
	if not is_on_floor():
		velocity.y += gravity
	else:
		# Can't make it zero because then is_on_floor() will be false
		velocity.y = -0.0001
		
	# Only slow down if we are on a surface
	if is_on_ceiling() or is_on_floor() or is_on_wall():
		# Pos x
		if velocity.x > 0:
			velocity.x -= virtual_friction
			if velocity.x < 0:
				velocity.x = 0
			
		# Neg x
		if velocity.x < 0:
			velocity.x += virtual_friction
			if velocity.x > 0:
				velocity.x = 0
		
		# Pos z
		if velocity.z > 0:
			velocity.z -= virtual_friction
			if velocity.z < 0:
				velocity.z = 0
		
		# Neg z
		if velocity.z < 0:
			velocity.z += virtual_friction
			if velocity.z > 0:
				velocity.z = 0
				
	
	# Only allow transitions from sprinting if we are on the ground
	if is_on_floor():
		# sprinting
		if Input.is_action_pressed("ui_sprint"):
			is_sprinting = true
		else:
			is_sprinting = false
		
	# crouching
	if Input.is_action_pressed("ui_crouch"):
		is_sprinting = false
		is_crouched = true
	else:
		is_crouched = false
		
	# strafing
	if Input.is_action_pressed("ui_up"):
		velocity += transform.basis.x
		
	if Input.is_action_pressed("ui_down"):
		velocity -= transform.basis.x
		
	if Input.is_action_pressed("ui_right"):
		velocity += transform.basis.z
		
	if Input.is_action_pressed("ui_left"):
		velocity -= transform.basis.z
	
	# Make sure that we aren't moving too fast
	var xz_velocity = velocity
	xz_velocity.y = 0
	var y_velocity = velocity.y

	# moving too fast in xz. need to lower the velocity components proportionally 
	if xz_velocity.length() > speed_cap:
		var new_velocity = xz_velocity.normalized() * speed_cap
		velocity = new_velocity
		velocity.y = y_velocity
	
	# jumping
	# Only jump if we are on the ground
	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		velocity.y = jump_speed
		
	# Controller input horizontal looking
	if abs(controller_horizontal_rotation_amount) > controller_deadzone:
		rotate_y(controller_horizontal_rotation_amount)
	
	# Apply movement
	if is_sprinting:
		move_and_slide(velocity * (speed * 1.7), Vector3(0, 1, 0))
	elif is_crouched:
		move_and_slide(velocity * (speed / 1.7), Vector3(0, 1, 0))
	else:
		move_and_slide(velocity * speed, Vector3(0, 1, 0))

# Rotates the entire player along y with the mouse x
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-rotate_speed * event.relative.x / 10)
		
	elif event is InputEventJoypadMotion:
		if event.get_axis() == JOY_AXIS_2:
			controller_horizontal_rotation_amount = -rotate_speed * event.get_axis_value() * 3
