extends Node2D

@onready var UICL = $"UI"

var playerSC = preload("res://Scenes/player.tscn")
var uiSC = preload("res://Scenes/main_ui.tscn")
var shopSC = preload("res://Scenes/shop.tscn")
var converterSC = preload("res://Scenes/converter.tscn")

var p
var ui

func _ready() -> void:
	
	var player = playerSC.instantiate()
	player.global_position = Vector2(0.0, 0.0)
	add_child(player)
	
	var uii = uiSC.instantiate()
	UICL.add_child(uii)
	
	var shopi = shopSC.instantiate()
	shopi.global_position = Vector2(100.0, 100.0)
	add_child(shopi)
	
	var convi = converterSC.instantiate()
	convi.global_position = Vector2(100.0, -200.0)
	add_child(convi)
	
	for i in get_children():
		if i.is_in_group("player"):
			p = i
		if i.is_in_group("UILayer"):
			ui = i
