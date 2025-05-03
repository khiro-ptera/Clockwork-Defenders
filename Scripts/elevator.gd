extends Node2D

@onready var delveButton = $"Delve"
@onready var bLabel = $"Delve/Label".text

func _ready() -> void:
	delveButton.visible = false
	bLabel = "Delve?"

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		delveButton.visible = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		delveButton.visible = false

func _on_delve_pressed() -> void:
	get_parent().nextFloor()
