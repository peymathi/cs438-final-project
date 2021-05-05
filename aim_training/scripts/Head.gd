extends Spatial


var vertical_rotation = 0
var controller_vertical_rotation_amount = 0
var normal_translation = Vector3.ZERO
var crouch_translated_y = 0
var crouch_translation

# Called when the node enters the scene tree for the first time.
func _ready():
	normal_translation = get_translation()
	var body_node = get_node("../Body")
	crouch_translation = body_node.to_global(body_node.get_translation())
	crouch_translation.y += 0.8


func _handle_crouch(delta):
	
	# Apply / unapply crouch only once
	if get_parent().is_crouched:
		if get_translation().y != crouch_translation.y:
			var y_change = -delta * 3
			if get_translation().y + y_change < crouch_translation.y:
				set_translation(Vector3(normal_translation.x, crouch_translation.y, normal_translation.z))
			else:
				var new_translation = get_translation()
				new_translation.y += y_change
				set_translation(new_translation)
		
	elif not get_parent().is_crouched:
		if get_translation().y != normal_translation.y:
			var y_change = delta * 3
			if get_translation().y + y_change > normal_translation.y:
				set_translation(normal_translation)
			else:
				var new_translation = get_translation()
				new_translation.y += y_change
				set_translation(new_translation)

func _physics_process(delta):
	
	if abs(controller_vertical_rotation_amount) > get_parent().controller_deadzone:
		
		# Check if we are looking straight up
			if vertical_rotation + controller_vertical_rotation_amount < -1.475:
				if vertical_rotation != -1.475:
					rotate_z(-1.475 - vertical_rotation)
					vertical_rotation = -1.475
			
			# Check if we are looking straight down
			elif vertical_rotation + controller_vertical_rotation_amount > 1.475:
				if vertical_rotation != 1.475:
					rotate_z(1.475 - vertical_rotation)
					vertical_rotation = 1.475
					
			else:
				rotate_z(controller_vertical_rotation_amount)
				vertical_rotation += controller_vertical_rotation_amount
		
	_handle_crouch(delta)

func _unhandled_input(event):
	
	var rotation_amount = 0
	
	# Looking vertically using the mouse
	if event is InputEventMouseMotion:
		
		rotation_amount = -get_parent().rotate_speed * event.relative.y / 10
		
		# Check if we are looking straight up
		if vertical_rotation + rotation_amount < -1.475:
			if vertical_rotation != -1.475:
				rotate_z(-1.475 - vertical_rotation)
				vertical_rotation = -1.475
		
		# Check if we are looking straight down
		elif vertical_rotation + rotation_amount > 1.475:
			if vertical_rotation != 1.475:
				rotate_z(1.475 - vertical_rotation)
				vertical_rotation = 1.475
			
		else:
			rotate_z(rotation_amount)
			vertical_rotation += rotation_amount
	
	# Looking vertically using the joypad
	elif event is InputEventJoypadMotion:
		
		if event.get_axis() == JOY_AXIS_3:
			
			controller_vertical_rotation_amount = -get_parent().rotate_speed * event.get_axis_value() * 3
		
