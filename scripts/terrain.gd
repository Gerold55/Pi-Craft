extends Node3D

@export var grid_size: int = 16
@export var block_size: float = 1.0
@export var default_block: String = "grass"

func _ready():
	generate_terrain()

func generate_terrain():
	var block_library = $BlockLibrary
	for x in range(grid_size):
		for z in range(grid_size):
			var block_scene = block_library.get_block(default_block)
			if block_scene:
				var block_instance = block_scene.instantiate()
				block_instance.transform.origin = Vector3(x * block_size, 0, z * block_size)
				add_child(block_instance)
