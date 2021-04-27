extends Camera


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const max_sprint_fov_change = 10
var normal_fov = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	normal_fov = get_fov()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	
	# Apply gradual fov change if sprinting
	if get_parent().get_parent().is_sprinting:
		if get_fov() < normal_fov + max_sprint_fov_change:
			var fov_change = delta * 70
			if get_fov() + fov_change > normal_fov + max_sprint_fov_change:
				set_fov(normal_fov + max_sprint_fov_change)
			else:
				set_fov(get_fov() + fov_change)
			
	else:
		if get_fov() > normal_fov:
			var fov_change = delta * 70
			if get_fov() - fov_change < normal_fov:
				set_fov(normal_fov)
			else:
				set_fov(get_fov() - fov_change)

