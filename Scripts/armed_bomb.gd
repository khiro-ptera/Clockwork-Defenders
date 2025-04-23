extends Node2D

@onready var coll = $"Explosion/Hitbox/CollisionShape2D"
@onready var det = $"Explosion/TextureProgressBar"
@onready var expl = $"Explosion"
@onready var sprite = $"AnimatedSprite2D"
@onready var expart = $"AnimatedSprite2D/CPUParticles2D"

var pos
var time = 0.0

var detspeed = 2.0
var linger = 0.05
var boomsize = 1.5
var kb = 0.0
var damage # normal dmg
var dp # damage types
var de
var ds

var fire = Vector2(0.0, 0.0)
var shock = Vector2(0.0, 0.0)
var poison = Vector2(0.0, 0.0)
var stun = Vector2(0.0, 0.0)
var freeze = Vector2(0.0, 0.0)
var curse = Vector2(0.0, 0.0)

var bomb

func _ready() -> void:
	global_position = pos
	coll.disabled = true
	det.max_value = detspeed
	expl.scale = Vector2(boomsize, boomsize)
	match(bomb):
		3: sprite.play("default")
		6: sprite.play("heat_hazer")
		7: sprite.play("hazer")
		8: sprite.play("vile_hazer")

func _process(delta: float) -> void:
	time += delta
	det.value = time
	if time >= detspeed:
		if coll.disabled == true:
			coll.disabled = false
			det.tint_progress = Color(1.0, 0.0, 0.0)
			expart.initial_velocity_max /= linger
			expart.initial_velocity_min /= linger
			expart.lifetime = linger
			# print(expart.initial_velocity_max)
			# print(expart.initial_velocity_min)
			expart.emitting = true
		elif time >= detspeed + linger:
			queue_free()

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("hurtbox") && area.get_parent().is_in_group("enemy"):
		area.get_parent().take_damage(damage, dp, de, ds, kb)
		if randf_range(0.0, 1.0) < fire.x:
			area.get_parent().inflict("fire", fire.y)
		if randf_range(0.0, 1.0) < shock.x:
			area.get_parent().inflict("shock", shock.y)
		if randf_range(0.0, 1.0) < poison.x:
			area.get_parent().inflict("poison", poison.y)
		if randf_range(0.0, 1.0) < freeze.x:
			area.get_parent().inflict("freeze", freeze.y)
		if randf_range(0.0, 1.0) < curse.x:
			area.get_parent().inflict("curse", curse.y)
