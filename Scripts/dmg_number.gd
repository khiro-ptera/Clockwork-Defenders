extends RigidBody2D

@onready var l = $"Label"
var amount = 0.0

func _ready() -> void:
	$"Timer".start(0.3)

func _process(delta: float) -> void:
	l.text = str(int(amount))

func _on_timer_timeout() -> void:
	queue_free()
