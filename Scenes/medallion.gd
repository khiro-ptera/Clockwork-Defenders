extends CharacterBody2D

@onready var sprite = $"Medallion/AnimatedSprite2D"
@onready var ap = $"Medallion/AnimationPlayer"

@onready var value

var pos
var suck = false
var playerArea
var speed = 75.0

func _ready() -> void:
	global_position = pos
	sprite.play(str(value))
	ap.play("spin")
	speed = 75.0

func _process(delta: float) -> void:
	sprite.play(str(value))
	if suck:
		look_at(playerArea.get_global_position())
		velocity = Vector2(speed, 0).rotated(rotation)
		move_and_slide()
		speed += delta * 100

func _on_medallion_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.collect("medallion", value)
		queue_free()


func _on_medallion_area_entered(area: Area2D) -> void:
	if area.is_in_group("pickupRange"):
		playerArea = area
		suck = true
