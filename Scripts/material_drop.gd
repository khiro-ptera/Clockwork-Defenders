extends CharacterBody2D

@onready var sprite = $"Material/AnimatedSprite2D"

@onready var item

var schema = 0

var star = 0

var pos
var suck = false
var playerArea
var speed = 75.0

func _ready() -> void:
	global_position = pos
	sprite.play(str(item))
	speed = 50.0

func _process(delta: float) -> void:
	sprite.play(str(item))
	if suck:
		look_at(playerArea.get_global_position())
		velocity = Vector2(speed, 0).rotated(rotation)
		move_and_slide()
		speed += delta * 100

func _on_material_area_entered(area: Area2D) -> void:
	if area.is_in_group("pickupRange"):
		playerArea = area
		suck = true

func _on_material_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.collect(str(item), 1, star, schema)
		queue_free()
