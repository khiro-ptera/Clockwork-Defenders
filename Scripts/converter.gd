extends Node2D

@onready var schemaBox = $"Schemas"
@onready var schemaList = $"Schemas/ScrollContainer/VBoxContainer"
@onready var viewBox = $"Viewer"
@onready var viewSchema = $"Viewer/ScrollContainer/Label"

# @onready var playerInv = load("res://Resources/Inventory/playerInv.tres")

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
	var res: Schema = load("res://Resources/Schemas/" + w + ".tres")
	var str = ""
	for i in res.mats:
		str += i + "\n"
	viewSchema.text = str
	viewBox.visible = true

func _on_texture_button_pressed() -> void: # craft
	var playerInv = load("res://Resources/Inventory/playerInv.tres")
	
