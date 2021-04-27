extends Spatial

# Loaders
var bullet_mark_master
var audio_player_master

# Bullet sounds
var audio_players = []
var next_audio_player = 0

# Recoil variables
var is_recoiling = false
var max_recoil_distance = 0.032
var cur_recoil_distance = 0
var normal_gun_position = 0

# Bullet firing
var fire_rate = 10
var max_bullet_distance = 1000
var cast_loc
var cur_error = 0
var shot_available = true
var frame_tot = 0

# Called when the node enters the scene tree for the first time.
func _ready(): 
	
	# Set up recoil mechanism
	normal_gun_position = translation.x
	cur_recoil_distance = translation.x
	
	# Set up raycast
	bullet_mark_master = preload("res://scenes/BulletMark.tscn")
	cast_loc = $GunPointer.transform.basis.x
	cast_loc.x += max_bullet_distance
	
	# Create an array of gun shot players based on the number needed for constant playback
	audio_player_master = preload("res://scenes/GunShotPlayer.tscn")
	var audio_instance = audio_player_master.instance()
	for i in range(ceil(audio_instance.stream.get_length() * fire_rate) * 5):
		audio_players.append(audio_player_master.instance())
		add_child(audio_players[i])
		
	# Center on cursor
	cast_loc.z -= 30
	$GunPointer.set_cast_to(cast_loc)
	
	# Set up timers
	$ShotDelay.set_wait_time(1.0 / fire_rate)
	
# Function that runs every time a shot is fired
func handle_shot():
	$GunPointer.force_raycast_update()
	
	# Play shot sound
	# Start the sound on a player that is not already playing a sound
	audio_players[next_audio_player].play(0.08)
	next_audio_player += 1
	if (next_audio_player == audio_players.size()):
		next_audio_player = 0
	
	# Show muzzle flash
	$"AK-103/MuzzleFlash".show()
	$MuzzleFlashTimer.start(0.02)
	
	# Show recoil (on models)
	is_recoiling = true
	
	# Update error
	
	# Calculate collisions and draw a bullet mark
	if $GunPointer.is_colliding():
		var collision_point = $GunPointer.get_collision_point()
		collision_point.x -= 0.01
		var bullet_mark = bullet_mark_master.instance()
		bullet_mark.look_at_from_position(collision_point + ($GunPointer.get_collision_normal() / 1000), collision_point + $GunPointer.get_collision_normal(), Vector3(1, 1, 1))
		owner.owner.add_child(bullet_mark)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_shoot") and shot_available:
		handle_shot()
		$ShotDelay.start()
		shot_available = false
		
func _physics_process(delta):
	
	# Animate recoil
	if cur_recoil_distance == max_recoil_distance:
		is_recoiling = false
	
	if is_recoiling:
		if cur_recoil_distance < max_recoil_distance:
			var recoil_change = (max_recoil_distance / ((1.0 / delta) / fire_rate)) * 2
			if cur_recoil_distance + recoil_change > max_recoil_distance:
				cur_recoil_distance = max_recoil_distance
				translation.x = -max_recoil_distance
			else:
				cur_recoil_distance += recoil_change
				translation.x -= recoil_change
	else:
		if cur_recoil_distance > normal_gun_position:
			var recoil_change = (max_recoil_distance / ((1.0 / delta) / fire_rate)) * 2
			if cur_recoil_distance - recoil_change < normal_gun_position:
				cur_recoil_distance = normal_gun_position
				translation.x = normal_gun_position
			else:
				cur_recoil_distance -= recoil_change
				translation.x += recoil_change
		
# Timer to handle shot delays
func _on_ShotDelay_timeout():
	shot_available = true

func _on_MuzzleFlashTimer_timeout():
	$"AK-103/MuzzleFlash".hide()
