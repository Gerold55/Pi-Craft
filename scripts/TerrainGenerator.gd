extends Node3D

@export var block_size: float = 2.0  # Size of each block
@export var terrain_size: Vector2 = Vector2(10, 10)  # Size of the terrain (in blocks)
@export var height_variation: int = 3  # Variation of heights for the blocks

var blocks = {
	"grass": preload("res://scenes/grass.tscn"),
	"dirt": preload("res://scenes/dirt.tscn"),
	"stone": preload("res://scenes/stone.tscn"),
	"bedrock": preload("res://scenes/bedrock.tscn")
}

var block_library: Node  # The BlockLibrary node reference

func _ready() -> void:
	# Try to find the BlockLibrary node (adjust the path based on your scene structure)
	block_library = get_node("BlockLibrary")  # If BlockLibrary is a direct child of the current node

	# Check if the BlockLibrary node is found
	if block_library == null:
		push_error("Error: BlockLibrary node not found!")
		return
	
	# Now generate the terrain
	generate_terrain()

# Function to generate the terrain
func generate_terrain() -> void:
	for x in range(terrain_size.x):
		for z in range(terrain_size.y):
			# Calculate height for this block (you can make this more complex later)
			var y = int(randf_range(0, height_variation))
			
			# Select the block type based on height
			var block_type = select_block_type(y)
			
			# Instantiate the selected block and set its position
			var block = blocks[block_type].instantiate()
			block.position = Vector3(x * block_size, y * block_size, z * block_size)  # Use position instead of translation
			
			# Add the block to the scene
			add_child(block)

# Function to select block type based on height
func select_block_type(y: int) -> String:
	# Logic to determine block type based on height (y value)
	if y == 0:
		return "bedrock"  # Bedrock at the bottom
	elif y == 1:
		return "stone"  # Stone near the bedrock
	elif y < height_variation - 1:
		return "dirt"  # Dirt on the surface
	else:
		return "grass"  # Grass on top
