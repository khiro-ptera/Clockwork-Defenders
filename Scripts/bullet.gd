extends CharacterBody2D

var pos
var time = 0.0

var speed = 200.0
var kb = 0.0
var damage # normal dmg
var dp # damage types
var de
var ds
var ttl
var angle = 0.0

var pierce = 0
var explode = false

# chance, intensity
var fire = Vector2(0.0, 0.0)
var shock = Vector2(0.0, 0.0)
var poison = Vector2(0.0, 0.0)
var stun = Vector2(0.0, 0.0)
var freeze = Vector2(0.0, 0.0)
var curse = Vector2(0.0, 0.0)

var gun
var shape

@onready var sprite = $"AnimatedSprite2D"
# @onready var circ = $"Circle"

func _ready() -> void:
	global_position = pos
	look_at(get_global_mouse_position().rotated(angle))
	match(gun):
		2:
			sprite.play("proto")
			shape = "circle"
		5:
			sprite.play("hot")
			shape = "circle"
			fire = Vector2(0.25, 3.0)
		10:
			sprite.play("rook")
			shape = "circle"
			stun = Vector2(0.5, 3.0)

func _physics_process(delta: float) -> void:
	velocity = Vector2(speed, 0.0).rotated(rotation)
	move_and_slide()
	time += delta
	if time > ttl:
		queue_free()


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("hurtbox") && area.get_parent().is_in_group("enemy"):
		area.get_parent().take_damage(damage, dp, de, ds, kb)
		if randf_range(0.0, 1.0) < fire.x:
			area.get_parent().inflict("fire", fire.y)
		if randf_range(0.0, 1.0) < shock.x:
			area.get_parent().inflict("shock", shock.y)
		if randf_range(0.0, 1.0) < stun.x:
			area.get_parent().inflict("stun", stun.y)
		if randf_range(0.0, 1.0) < poison.x:
			area.get_parent().inflict("poison", poison.y)
		if randf_range(0.0, 1.0) < freeze.x:
			area.get_parent().inflict("freeze", freeze.y)
		if randf_range(0.0, 1.0) < curse.x:
			area.get_parent().inflict("curse", curse.y)
		if pierce <= 0:
			queue_free()
		else: 
			pierce -= 1
