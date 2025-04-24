extends Node2D

@onready var portal = $"Portal"
@onready var summonButton = $"Portal/TextureButton"

@onready var m1 = $"M1"
@onready var m1c = $"M1/CollisionShape2D"

func _ready() -> void:
	portal.visible = true
	summonButton.visible = false
	m1.visible = false
	m1c.disabled = true

func _on_portal_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		summonButton.visible = true

func _on_portal_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		summonButton.visible = false
