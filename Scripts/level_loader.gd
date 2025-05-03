extends Node2D

var bastion = preload("res://Scenes/Areas/bastion.tscn")
var test = preload("res://Scenes/Areas/test_scene.tscn")

func _ready() -> void:
	loadLevel(0)

func loadLevel(level: int):
	for i in get_children():
		remove_child(i)
		i.queue_free()
	match(level):
		-1:
			var lI = test.instantiate()
			add_child(lI)
		0:
			var initialLevel = bastion.instantiate()
			add_child(initialLevel)
