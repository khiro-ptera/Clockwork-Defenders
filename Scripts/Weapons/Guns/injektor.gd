extends Node2D

@onready var id = 12
@onready var star = 1

@onready var ap = $"AnimationPlayer"
@onready var sprite = $"AnimatedSprite2D"
@onready var muzzle = $"AnimatedSprite2D/Muzzle"

@onready var maxCombo = 5
@onready var endlag = 0.15
@onready var combolag = 1.4
@onready var damage = 0
@onready var damageP = 2
@onready var damageE = 0
@onready var damageS = 2
@onready var bulletSpeed = 300.0
@onready var charge = 2.0
@onready var chargelag = 0.5
@onready var kb = 0.0

var bulletSC = preload("res://Scenes/bullet.tscn")

func _ready() -> void:
	sprite.play("default")

func lightAttack(combo: int) -> void:
	match combo:
		1:
			fire(damage, bulletSpeed, Vector2(1.0, 1.0), 1.5, kb, damageP, damageE, damageS, 1)
			ap.play("fire")
		2:
			fire(damage, bulletSpeed, Vector2(1.0, 1.0), 1.5, kb, damageP, damageE, damageS * 1.5, 1)
			ap.play("fire")
		3:
			fire(damage, bulletSpeed, Vector2(1.0, 1.0), 1.5, kb, damageP, damageE, damageS * 2.0, 1)
			ap.play("fire")
		4:
			fire(damage, bulletSpeed, Vector2(1.0, 1.0), 1.5, kb, damageP, damageE, damageS * 2.5, 1)
			ap.play("fire")
		5:
			fire(damage, bulletSpeed, Vector2(1.2, 1.0), 1.5, kb, damageP, damageE, damageS * 3.0, 1)
			ap.play("firereload")

func chargedAttack() -> void:
	fire(damage, bulletSpeed * 1.3, Vector2(2.5, 1.1), 2.0, kb, damageP, damageE, damageS * 2.0, 2)
	fire(damage, bulletSpeed * 1.4, Vector2(2.5, 1.1), 2.0, kb, damageP, damageE, damageS * 2.0, 2)
	ap.play("charge")

func fire(dmg, spd, scl, time, kb2, dp = 0, de = 0, ds = 0, pierce = 0, angle = 0.0) -> void:
	var shot = bulletSC.instantiate()
	shot.pos = muzzle.global_position
	shot.scale = scl
	shot.speed = spd
	shot.gun = id
	shot.damage = dmg
	shot.dp = dp
	shot.de = de
	shot.ds = ds
	shot.ttl = time
	shot.kb = kb2
	shot.pierce = pierce
	shot.angle = angle
	get_parent().get_parent().add_child(shot)

func chargedFire() -> void: # if charged shoots different proj
	pass

func _process(delta: float) -> void:
	if !ap.is_playing():
		sprite.rotation = 0.0
		sprite.position = Vector2(0.0, 0.0)
