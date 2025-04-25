extends Node

var materialSC = preload("res://Scenes/material_drop.tscn")

enum schemas0 {
	proto_sword = 1,
	proto_gun = 2,
	proto_bomb = 3
}

var w0 = [1, 2, 3]

enum schemas1 {
	hot_shot = 5,
	hazer = 7,
	injektor = 12
}

var w1 = [5, 7, 12]

enum schemas2 {
	cutter = 4,
	heat_hazer = 6,
	vile_hazer = 8,
	frigid_hazer = 9,
	rook = 10,
	scatterer = 11
}

var w2 = [4, 6, 8, 9, 10, 11]

var wdict = {
	proto_sword = 1,
	proto_gun = 2,
	proto_bomb = 3,
	hot_shot = 5,
	hazer = 7,
	injektor = 12,
	cutter = 4,
	heat_hazer = 6,
	vile_hazer = 8,
	frigid_hazer = 9,
	rook = 10,
	scatterer = 11
}


var knownSchema: Array[int] = []

func t1_drop(pos, scene):
	var roll = randf_range(0.0, 1.0)
	if roll < 0.03:
		var mtemp = materialSC.instantiate()
		mtemp.item = "schema1"
		mtemp.schema = w1[randi_range(0, w1.size() - 1)]
		mtemp.star = 1
		mtemp.pos = pos + Vector2(randf_range(-30.0, 30.0), randf_range(-30.0, 30.0))
		scene.call_deferred("add_child", mtemp)
		mtemp = null
	elif roll < 0.04:
		var mtemp = materialSC.instantiate()
		mtemp.item = "schema2"
		mtemp.schema = w2[randi_range(0, w2.size() - 1)]
		mtemp.star = 2
		mtemp.pos = pos + Vector2(randf_range(-30.0, 30.0), randf_range(-30.0, 30.0))
		scene.call_deferred("add_child", mtemp)
		mtemp = null
