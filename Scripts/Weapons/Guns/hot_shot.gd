extends Node2D

@onready var id = 5
@onready var star = 1

@onready var ap = $"AnimationPlayer"
@onready var sprite = $"AnimatedSprite2D"
@onready var muzzle = $"AnimatedSprite2D/Muzzle"

@onready var maxCombo = 2
@onready var endlag = 0.3
@onready var combolag = 1.3
@onready var damage = 0
@onready var damageP = 0
@onready var damageE = 13
@onready var damageS = 0
@onready var bulletSpeed = 150.0
@onready var charge = 2.6
@onready var chargelag = 0.65
@onready var kb = 1.3

var bulletSC = preload("res://Scenes/bullet.tscn")

func _ready() -> void:
	sprite.play("default")

func lightAttack(combo: int) -> void:
	match combo:
		1:
			fire(damage, bulletSpeed, Vector2(3.0, 0.7), 1.8, kb, damageP, damageE, damageS)
			ap.play("fire")
		2:
			fire(damage, bulletSpeed, Vector2(3.0, 0.7), 1.8, kb, damageP, damageE, damageS)
			ap.play("firereload")

func chargedAttack() -> void:
	fire(damage, bulletSpeed, Vector2(2.5, 2.5), 2.5, 1.3 * kb, damageP, damageE * 2.0, damageS, 2)
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
