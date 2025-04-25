extends Node2D

@onready var schemaBox = $"Schemas"

func _ready() -> void:
	schemaBox.visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		schemaBox.visible = true
		# Global.knownSchema

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		schemaBox.visible = false
