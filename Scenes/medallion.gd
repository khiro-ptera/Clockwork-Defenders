extends Area2D

@onready var sprite = $"AnimatedSprite2D"
@onready var ap = $"AnimationPlayer"
@onready var value

var pos

func _ready() -> void:
	global_position = pos
	sprite.play(str(value))
	ap.play("spin")

func _process(delta: float) -> void:
	sprite.play(str(value))

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.collect("medallion", value)
		queue_free()
