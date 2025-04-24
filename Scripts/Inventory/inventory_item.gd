extends Resource

class_name InvItem

@export var name = ""
@export var schema = 0
@export var id: int # idk
@export var count: int 
@export var star: int
@export var sell: int
@export var texture: Texture2D

func _init(n, st, s = 0) -> void:
	name = n
	count = 1
	star = st
	schema = s
	if schema == 0:
		texture = load("res://Assets/sprites/drops/materials/" + n + ".png")
	else:
		texture = load("res://Assets/sprites/drops/schemas/" + str(star) + "star.png")
