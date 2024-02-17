extends Marker3D

@onready var cam_col = %CamCollider
@onready var camera = %Camera3D

func _process(delta):
	if cam_col.is_colliding():
		camera.global_transform.origin = lerp(camera.global_transform.origin, cam_col.get_collision_points(), 0.2)
	else:
		camera.global_transform.origin = %CamOriginReset
