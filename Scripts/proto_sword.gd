extends Node2D

@onready var id = 1
@onready var star = 0

@onready var hb = $"AnimatedSprite2D/Hitbox/CollisionShape2D"
@onready var sprite = $"AnimatedSprite2D"
# @onready var cb = $"TextureProgressBar"
# @onready var hbprop = $"AnimatedSprite2D/Hitbox"
@onready var ap = $"AnimationPlayer"

@onready var maxCombo = 2
@onready var endlag = 1.0
@onready var combolag = 1.2
@onready var damage = 15
@onready var damageP = 0
@onready var damageE = 0
@onready var damageS = 0
@onready var charge = 3.0
@onready var chargelag = 1.6
@onready var kb = 2.4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hb.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ap.is_playing():
		hb.disabled = false
		modulate.a = 1.0
		scale = Vector2(1.0, 1.0)
	else:
		hb.disabled = true
		modulate.a = 0.35
		scale = Vector2(0.6, 0.6)
		sprite.rotation = 0.0
		sprite.position = Vector2(0.0, 0.0)

func lightAttack(combo: int) -> void:
	match combo:
		1:
			ap.play("light1")
		2:
			ap.play("light2")
		3:
			pass

func chargedAttack() -> void:
	get_parent().boost(0.1)
	ap.play("charge")

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("hurtbox") && area.get_parent().is_in_group("enemy"):
		area.get_parent().take_damage(damage, damageP, damageE, damageS, kb)
