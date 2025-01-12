extends Camera3D

func _ready():
	translation = Vector3(terrain_size.x * block_size / 2, 10, terrain_size.y * block_size / 2)  # Set camera position
	look_at(Vector3(terrain_size.x * block_size / 2, 0, terrain_size.y * block_size / 2), Vector3(0, 1, 0))  # Look at center
