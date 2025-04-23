extends Node2D

@onready var id = 4
@onready var star = 2

@onready var hb = $"AnimatedSprite2D/Hitbox/CollisionShape2D"
@onready var sprite = $"AnimatedSprite2D"
# @onready var cb = $"TextureProgressBar"
# @onready var hbprop = $"AnimatedSprite2D/Hitbox"
@onready var ap = $"AnimationPlayer"

@onready var maxCombo = 5
@onready var endlag = 0.2
@onready var combolag = 0.8
@onready var damage = 25
@onready var damageP = 5
@onready var damageE = 0
@onready var damageS = 0
@onready var charge = 2.0
@onready var chargelag = 1.5
@onready var kb = 2.0

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
			get_parent().boost(0.1)
			ap.play("light1")
		2:
			get_parent().boost(0.1)
			ap.play("light2")
		3:
			get_parent().boost(0.1)
			ap.play("light1")
		4:
			get_parent().boost(0.1)
			ap.play("light4")
		5:
			get_parent().boost(0.25)
			ap.play("light3")

func chargedAttack() -> void:
	get_parent().boost(0.4)
	ap.play("charge")

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("hurtbox") && area.get_parent().is_in_group("enemy"):
		area.get_parent().take_damage(damage, damageP, damageE, damageS, kb)
