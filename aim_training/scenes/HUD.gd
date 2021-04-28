extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	# Make sure crosshair is centered
	var view_size = get_viewport().size
	$Crosshair.translate(Vector2(view_size.x / 2, view_size.y / 2))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
