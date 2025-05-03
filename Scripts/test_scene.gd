extends Node2D

@onready var UICL = $"UI"

var playerSC = preload("res://Scenes/player.tscn")
var jellySC = preload("res://Scenes/Enemies/jelly.tscn")
var uiSC = preload("res://Scenes/main_ui.tscn")
var shopSC = preload("res://Scenes/shop.tscn")
var converterSC = preload("res://Scenes/converter.tscn")
var elevatorSC = preload("res://Scenes/Interact/elevator.tscn")

var p = null
var ui = null

var jellyTimer = 10.0

func _ready() -> void:
	
	for i in get_children():
		if i.is_in_group("player"):
			p = i
		if i.is_in_group("UILayer"):
			for j in i.get_children():
				ui = j
	if p == null:
		var player = playerSC.instantiate()
		player.global_position = Vector2(0.0, 0.0)
		add_child(player)
	if ui == null:
		var uii = uiSC.instantiate()
		UICL.add_child(uii)
	for i in get_children():
		if i.is_in_group("player"):
			p = i
		if i.is_in_group("UILayer"):
			ui = i
	
	var shopi = shopSC.instantiate()
	shopi.global_position = Vector2(100.0, 100.0)
	add_child(shopi)
	
	var convi = converterSC.instantiate()
	convi.global_position = Vector2(100.0, -200.0)
	add_child(convi)
	
	var elevi = elevatorSC.instantiate()
	elevi.global_position = Vector2(-100.0, -100.0)
	add_child(elevi)
	
	for i in 3:
		spawnJelly()

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


func nextFloor():
	get_parent().loadLevel(0)
	
