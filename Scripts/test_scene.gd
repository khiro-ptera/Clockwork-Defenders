extends Node2D

@onready var UICL = $"UI"

var playerSC = preload("res://Scenes/player.tscn")
var jellySC = preload("res://Scenes/Enemies/jelly.tscn")
var uiSC = preload("res://Scenes/main_ui.tscn")

var p
var ui

var jellyTimer = 10.0

func _ready() -> void:
	
	var player = playerSC.instantiate()
	player.global_position = Vector2(0.0, 0.0)
	add_child(player)
	
	var uii = uiSC.instantiate()
	UICL.add_child(uii)
	
	for i in 3:
		spawnJelly()
	
	for i in get_children():
		if i.is_in_group("player"):
			p = i
		if i.is_in_group("UILayer"):
			ui = i

func _process(delta: float) -> void:
	if jellyTimer <= 0.0:
		spawnJelly()
		jellyTimer = 10.0
	else:
		jellyTimer -= delta

func spawnJelly():
	var jelly = jellySC.instantiate()
	jelly.global_position = Vector2(randf_range(128.0, 1024.0), randf_range(128.0, 1024.0))
	jelly.tier = 1
	jelly.type = 1
	add_child(jelly)


	
