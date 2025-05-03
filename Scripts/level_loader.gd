extends Node2D

var bastion = preload("res://Scenes/Areas/bastion.tscn")
var test = preload("res://Scenes/Areas/test_scene.tscn")

func _ready() -> void: # problem: player is a child of level
	loadLevel(0)

func loadLevel(level: int):
	var player = null
	var ui = null
	for i in get_children():
		for j in i.get_children():
			if j.is_in_group("player"):
				player = j
				i.remove_child(j)
			if j.is_in_group("UILayer"):
				ui = j.get_child(0)
				j.remove_child(ui)
		remove_child(i)
		i.queue_free()
	
	var lI
	match(level):
		-1:
			lI = test.instantiate()
		0:
			lI = bastion.instantiate()
	if ui != null:
		for i in lI.get_children():
			if i.is_in_group("UILayer"):
				i.add_child(ui)
	if player != null:
		player.global_position = Vector2(0, 0)
		lI.add_child(player)
	add_child(lI)
	
	
