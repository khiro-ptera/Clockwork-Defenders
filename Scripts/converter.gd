extends Node2D

@onready var schemaBox = $"Schemas"
@onready var schemaList = $"Schemas/ScrollContainer/VBoxContainer"
@onready var viewBox = $"Viewer"

var schemaBlockSC = preload("res://Scenes/schema_block.tscn")

var selected = ""

func _ready() -> void:
	schemaBox.visible = false
	viewBox.visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		for c in schemaList.get_children():
			schemaList.remove_child(c)
			c.queue_free()
		
		for i in Global.knownSchema:
			var wname = Global.wdict.find_key(i)
			var res: Schema = load("res://Resources/Schemas/" + wname + ".tres")
			var newblock = schemaBlockSC.instantiate()
			newblock.w = wname
			newblock.id = schemaList.get_child_count()
			schemaList.add_child(newblock)
			
		schemaBox.visible = true
		# Global.knownSchema

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		schemaBox.visible = false
		viewBox.visible = false

func select(w):
	selected = w
	print("selected " + selected)
