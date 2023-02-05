extends TileMap

export(Dictionary) var TILE_SCENES = {
}

onready var half_cell_size := cell_size * 0.5


func _ready():
	yield(get_tree(), "idle_frame")
	find()

func find(scene_dictionary: Dictionary = TILE_SCENES):
	for tile_pos in get_used_cells():
		var tile_id = get_cell(tile_pos.x, tile_pos.y)
		
		if scene_dictionary.has(tile_id):
			var object_scene = scene_dictionary[tile_id]
			replace(tile_pos, object_scene)

func replace(tile_pos, object_scene, parent = self):
	if get_cellv(tile_pos) != INVALID_CELL:
		set_cellv(tile_pos, -1)
		update_bitmask_region()

	if object_scene:
		var obj = object_scene.instance()
		var ob_pos = map_to_world(tile_pos) + half_cell_size
		
		parent.add_child(obj)
		obj.global_position = to_global(ob_pos)
