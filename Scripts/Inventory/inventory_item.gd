extends Resource

class_name InvItem

@export var name = ""
@export var id: int # idk
@export var star: int
@export var sell: int
@export var texture: Texture2D

func _init(n) -> void:
	name = n
	texture = load("res://Assets/sprites/drops/materials/" + n + ".png")
