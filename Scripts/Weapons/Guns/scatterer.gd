extends Node2D

@onready var id = 11
@onready var star = 2

@onready var ap = $"AnimationPlayer"
@onready var sprite = $"AnimatedSprite2D"
@onready var muzzle = $"AnimatedSprite2D/Muzzle"

@onready var maxCombo = 2
@onready var endlag = 0.8
@onready var combolag = 1.8
@onready var damage = 2
@onready var damageP = 2
@onready var damageE = 0
@onready var damageS = 0
@onready var bulletSpeed = 300.0
@onready var charge = 3.5
@onready var chargelag = 1.0
@onready var kb = 0.0

var bulletSC = preload("res://Scenes/bullet.tscn")

func _ready() -> void:
	sprite.play("default")

func lightAttack(combo: int) -> void:
	match combo:
		1:
			ap.play("fire")
			for i in 8:
				fire(damage, bulletSpeed, Vector2(1.0, 1.0), 1.0, kb, damageP, damageE, damageS, 0, randf_range(-0.1, 0.1))
				await get_tree().create_timer(0.05).timeout
		2:
			ap.play("firereload")
			for i in 8:
				fire(damage, bulletSpeed, Vector2(1.0, 1.0), 1.0, kb, damageP, damageE, damageS, 0, randf_range(-0.1, 0.1))
				await get_tree().create_timer(0.05).timeout

func chargedAttack() -> void:
	ap.play("charge")
	for i in 30:
		fire(damage * 1.5, bulletSpeed * 1.2, Vector2(1.2, 1.0), 1.1, kb, damageP, damageE, damageS, 0, deg_to_rad(-15 + i))
		await get_tree().create_timer(0.02).timeout

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
