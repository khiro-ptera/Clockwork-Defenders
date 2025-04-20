extends Node2D

@onready var id = 3
@onready var star = 0

@onready var ap = $"AnimationPlayer"
@onready var sprite = $"AnimatedSprite2D"

@onready var damage = 20
@onready var damageP = 0
@onready var damageE = 0
@onready var damageS = 0
@onready var kb = 3.0
@onready var charge = 2.5
@onready var chargelag = 0.2

@onready var det = 1.5
@onready var linger = 0.2
@onready var boomsize = 1.5

var bombSC = preload("res://Scenes/armed_bomb.tscn")

var up = false

func putUp() -> void:
	up = true
	sprite.offset = Vector2(0.0, -32.0)
	
func putDown() -> void:
	up = false

func chargedAttack() -> void:
	putDown()
	var shot = bombSC.instantiate()
	shot.pos = global_position
	shot.boomsize = boomsize
	shot.detspeed = det
	shot.bomb = id
	shot.damage = damage
	shot.dp = damageP
	shot.de = damageE
	shot.ds = damageS
	shot.kb = kb
	shot.linger = linger
	get_parent().get_parent().add_child(shot)

func _process(delta: float) -> void:
	if !up:
		sprite.offset = Vector2(32.0, 0.0)
