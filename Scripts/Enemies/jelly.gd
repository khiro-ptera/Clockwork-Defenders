extends CharacterBody2D

var medallionSC = preload("res://Scenes/medallion.tscn")
var materialSC = preload("res://Scenes/material_drop.tscn")
var dmgnSC = preload("res://Scenes/dmg_number.tscn")

@onready var dmgOverlay = $"Damage"
@onready var sprite = $"Sprite"
@onready var dirNode = $"Pointing"
@onready var hpbar = $"HP"

@onready var ftime = $"Fire"
@onready var ptime = $"Poison"
@onready var frtime = $"Freeze"
@onready var shtime = $"Shock"
@onready var stime = $"Stun"
@onready var ctime = $"Curse"

@onready var statuspart = $"Sprite/StatusParticles"
@onready var fpart = $"Sprite/StatusParticles/Fire"
@onready var ppart = $"Sprite/StatusParticles/Poison"
@onready var frpart = $"Sprite/StatusParticles/Freeze"
@onready var shpart = $"Sprite/StatusParticles/Shock"
@onready var spart = $"Sprite/StatusParticles/Stun"
@onready var cpart = $"Sprite/StatusParticles/Curse"

@onready var type = 1 # type of jelly
@onready var tier = 1 # difficulty
var damage = 10
var dmgP = 5
var dmgE = 0
var dmgS = 0
var dmgMult = 1.0
var health = 100
var speed = 50.0
var basespd = 50.0
@onready var maxH = 100 * (tier - 1) * (tier - 1) + 100
var defP = 100 # pierce def
var defE = 30 # elemental def
var defS = 0 # shadow def
var defN = 30 # normal def

var fireRes = 0
var shockRes = 0
var freezeRes = 0
var stunRes = 0
var poisonRes = 0
var curseRes = 0

# TODO: stagger/stagger resistance
var staggerRes = 10

var status: Array[String] = []
var statusTimer = 0.0

var player

var dead = false

func _ready() -> void:
	dmgOverlay.visible = false
	health = maxH
	for i in get_parent().get_children():
		if i.is_in_group("player"):
			player = i
	
	match(type):
		1:
			sprite.play("default")
			damage = dmgMult * (15 * (tier - 1) * (tier - 1) + 10)
			dmgP = dmgMult * (8 * (tier - 1) * (tier - 1) + 5)
			maxH = 100 * (tier - 1) * (tier - 1) + 100
			staggerRes = 20 * (tier - 1) + 10
			speed = 50.0
			basespd = 50.0

func _physics_process(delta: float) -> void:
	
	for i in get_parent().get_children():
		if i.is_in_group("player"):
			player = i
	dirNode.look_at(player.get_global_position())
	velocity = Vector2(speed, 0.0).rotated(dirNode.rotation)
	if status.has("stun"):
		velocity = Vector2(speed / 1.5, 0.0).rotated(dirNode.rotation + randf_range(-2.0, 2.0))
	if status.has("freeze"):
		velocity = Vector2(0.0, 0.0)
	if status.has("shock"):
		if randf_range(0.0, 1.0) < delta/1.5:
			velocity = Vector2(0.0, 0.0)
			take_damage(0, 0, 3 + maxH/20.0, 0, 3.5 * tier)
	move_and_slide()
	hpbar.max_value = maxH
	hpbar.value = health
	
	if status.size() > 0:
		statuspart.visible = true
		if status.has("fire"):
			take_damage(0, 0, delta * (5 + maxH/50.0), 0, 0.5 * tier)
			fpart.visible = true
		else:
			fpart.visible = false
		if status.has("poison"):
			ppart.visible = true
		else:
			ppart.visible = false
		if status.has("freeze"):
			frpart.visible = true
		else:
			frpart.visible = false
		if status.has("shock"):
			shpart.visible = true
		else:
			shpart.visible = false
		if status.has("stun"):
			spart.visible = true
		else:
			spart.visible = false
		if status.has("curse"):
			cpart.visible = true
		else:
			cpart.visible = false
	else:
		statuspart.visible = false

func take_damage(n, p, e, s, kb) -> void: # TODO: make global??
	damageFlash()
	var multi = 1.0
	if status.has("poison"):
		multi *= 1.5
	
	# TODO: damage numbers, grey when the damage lowered a lot by def and yellow when increased by neg defense
	var tempdmg = multi * ((n * 100 / (100 + defN)) + (p * 100 / (100 + defP)) + (e * 100 / (100 + defE)) + (s * 100 / (100 + defS)))
	health -= tempdmg
	# print(health)
	
	if tempdmg > 1.0:
		var numb = dmgnSC.instantiate()
		numb.global_position = global_position
		numb.amount = tempdmg
		get_parent().call_deferred("add_child", numb)
	
	if status.has("freeze"):
		if randf_range(0.0, 1.0) < 0.5 * tempdmg:
			status.remove_at(status.find("freeze"))
	
	if health <= 0 && !dead:
		die()
	
	var staggerChance = max((kb / 5.0) - (staggerRes / 100.0) - 0.05, 0.0)
	# print(staggerChance)
	if randf_range(0.0, 1.0) < staggerChance:
		# print("stagger")
		stagger(kb/40)

func stagger(time) -> void:
	# print(time)
	speed = -500.0
	await get_tree().create_timer(time).timeout
	speed = basespd/8
	await get_tree().create_timer(time * 4).timeout
	speed = basespd

func inflict(c, i):
	match(c):
		"fire":
			ftime.start(i * 100 / (100 + fireRes))
		"poison":
			ptime.start(i * 100 / (100 + poisonRes))
		"freeze":
			frtime.start(i * 100 / (100 + freezeRes))
		"stun":
			stime.start(i * 100 / (100 + stunRes)) 
		"shock":
			shtime.start(i * 100 / (100 + shockRes)) 
		"curse":
			ctime.start(i * 100 / (100 + curseRes))
	status.append(c)

func damageFlash() -> void:
	dmgOverlay.visible = true
	await get_tree().create_timer(0.1).timeout
	dmgOverlay.visible = false

func die():
	dead = true
	for i in randi_range(1, 9):
		var mtemp = medallionSC.instantiate()
		mtemp.value = 1
		mtemp.pos = global_position + Vector2(randf_range(-30.0, 30.0), randf_range(-30.0, 30.0))
		get_parent().call_deferred("add_child", mtemp)
		mtemp = null
	for i in randi_range(0, tier):
		var mtemp = medallionSC.instantiate()
		mtemp.value = 10
		mtemp.pos = global_position + Vector2(randf_range(-30.0, 30.0), randf_range(-30.0, 30.0))
		get_parent().call_deferred("add_child", mtemp)
		mtemp = null
	for i in randi_range(0, tier):
		var mtemp = materialSC.instantiate()
		mtemp.item = "plasmium"
		mtemp.pos = global_position + Vector2(randf_range(-30.0, 30.0), randf_range(-30.0, 30.0))
		get_parent().call_deferred("add_child", mtemp)
		mtemp = null
	Global.t1_drop(global_position, get_parent())
	queue_free()

func _on_hurtbox_area_entered(area: Area2D) -> void: # TODO: make a hitbox and move this to the hitbox, for attack animations and stuff
	if area.is_in_group("hurtbox") && area.get_parent().is_in_group("player"):
		var multi = 1.0
		if status.has("poison"):
			multi *= 0.5
		if status.has("curse"):
			take_damage(0, 0, 0, (damage + dmgP + dmgE + dmgS), 0.0)
		area.get_parent().take_damage(multi * damage, multi * dmgP, multi * dmgE, multi * dmgS)

func _on_fire_timeout() -> void:
	if status.has("fire"):
		status.remove_at(status.find("fire"))

func _on_poison_timeout() -> void:
	if status.has("poison"):
		status.remove_at(status.find("poison"))
		
func _on_freeze_timeout() -> void:
	if status.has("freeze"):
		status.remove_at(status.find("freeze"))

func _on_shock_timeout() -> void:
	if status.has("shock"):
		status.remove_at(status.find("shock"))

func _on_stun_timeout() -> void:
	if status.has("stun"):
		status.remove_at(status.find("stun"))

func _on_curse_timeout() -> void:
	if status.has("curse"):
		status.remove_at(status.find("curse"))
