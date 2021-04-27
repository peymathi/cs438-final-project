extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var bullet_hole_texture
var transitioned = false

# Called when the node enters the scene tree for the first time.
func _ready():
	bullet_hole_texture = preload("res://textures/2d/bullet_hole/bullet-hole-post-flash.png")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
	
# Remove flash
func _on_BulletFlashRemover_timeout():
	if not transitioned:
		remove_child($BulletFlash)
		$BulletHole.set_texture(bullet_hole_texture)
		transitioned = true

# Remove bullet mark
func _on_BulletHoleRemover_timeout():
	queue_free()
	get_parent().remove_child(self)
