extends Node2D

@onready var id = 10
@onready var star = 2

@onready var ap = $"AnimationPlayer"
@onready var sprite = $"AnimatedSprite2D"
@onready var muzzle = $"AnimatedSprite2D/Muzzle"

@onready var maxCombo = 1
@onready var endlag = 1.5
@onready var combolag = 1.8
@onready var damage = 30
@onready var damageP = 5
@onready var damageE = 0
@onready var damageS = 0
@onready var bulletSpeed = 180.0
@onready var charge = 4.0
@onready var chargelag = 1.5
@onready var kb = 4.0

var bulletSC = preload("res://Scenes/bullet.tscn")

func _ready() -> void:
	sprite.play("default")

func lightAttack(combo: int) -> void:
	match combo:
		1:
			get_parent().recoil(0.05)
			fire(damage, bulletSpeed, Vector2(1.5, 1.5), 1.0, kb, damageP, damageE, damageS, 1)
			ap.play("firereload")

func chargedAttack() -> void:
	get_parent().recoil(0.1)
	fire(damage * 2.4, bulletSpeed * 1.2, Vector2(2.8, 2.8), 1.2, 1.5 * kb, damageP, damageE, damageS, 20)
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
