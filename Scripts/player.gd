extends CharacterBody2D

@onready var chargebar = $"TextureProgressBar"
@onready var cam = $"Camera2D"

@export var speed = 400
var ctrMult = 1.0
var asiMult = 1.0

var maxH = 100
var def = 0
var defP = 0
var defE = 0
var defS = 0
var iframes = 0.5

var health = 100
var medallions = 0
@export var inv: Inv

var wep1 = preload("res://Scenes/proto_sword.tscn")
var wep2 = preload("res://Scenes/proto_gun.tscn")
var wep3 = preload("res://Scenes/proto_bomb.tscn")
var wep4 = preload("res://Scenes/cutter.tscn")
var wep5 = preload("res://Scenes/Weapons/hot_shot.tscn")
var wep6 = preload("res://Scenes/Weapons/heat_hazer.tscn")
var wep7 = preload("res://Scenes/Weapons/hazer.tscn")
var wep8 = preload("res://Scenes/Weapons/vile_hazer.tscn")

# var uiSC = preload("res://Scenes/main_ui.tscn")

var active = 0
var weapons = [8, 7, 6, 5]
var combo = 0
var comboTimer = 0.0
var endlag = 0.0
var prevframeM1 = false
var currentCharge = 0.0
var currIframes = 0.5

var boosting = false

func _ready() -> void:
	chargebar.visible = false
	var wep = wep1.instantiate()
	add_child(wep)
	
	# var uii = uiSC.instantiate()
	# cam.add_child(uii)

func get_input():
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	if boosting:
		velocity = 1.8 * speed * get_local_mouse_position() / (sqrt(get_local_mouse_position().x * get_local_mouse_position().x + get_local_mouse_position().y * get_local_mouse_position().y))
	elif endlag > 0.0:
		velocity = input_direction * speed * 0.1
	elif prevframeM1:
		velocity = input_direction * speed * 0.4
	else:
		velocity = input_direction * speed
	
	if Input.is_action_just_pressed("M1"):
		prevframeM1 = true
		for i in get_children():
			if i.is_in_group("weapon") && endlag <= 0.0:
				if i.is_in_group("bomb"):
					i.putUp()
				else:
					combo += 1
					comboTimer = i.endlag + 0.5
					currentCharge = 0.0
					i.lightAttack(combo)
					if combo == i.maxCombo:
						endlag = i.combolag
						combo = 0
						comboTimer = 0.0
					else:
						endlag = i.endlag
				break
	elif !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && prevframeM1 == true:
		# print(currentCharge)
		for i in get_children():
			if i.is_in_group("weapon"):
				if currentCharge >= i.charge:
					i.chargedAttack()
					endlag = i.chargelag
					combo = 0
					comboTimer = 0.0
					currentCharge = 0.0
				elif i.is_in_group("bomb"):
					currentCharge = 0.0
					i.putDown()
				else:
					currentCharge = 0.0
				break
		prevframeM1 = false
		chargebar.visible = false
	
	if Input.is_action_just_pressed("NextWeapon"):
		if active >= weapons.size()-1:
			active = 0
		else:
			active += 1
		while weapons[active] == 0:
			if active >= weapons.size()-1:
				active = 0
			else:
				active += 1
		swapWeapon()
	elif Input.is_action_just_pressed("PreviousWeapon"):
		if active <= 0:
			active = weapons.size()-1
		else:
			active -= 1
		while weapons[active] == 0:
			if active <= 0:
				active = weapons.size()-1
			else:
				active -= 1
		swapWeapon()

func _physics_process(delta):
	
	var weapon
	for i in get_children():
		if i.is_in_group("weapon"):
			weapon = i
			break
	
	if comboTimer > 0.0:
		comboTimer -= delta
		if comboTimer <= 0.0:
			combo = 0
	if endlag > 0.0:
		endlag -= delta * asiMult
	if currIframes > 0.0:
		modulate.a = 0.5
		currIframes -= delta
	else:
		modulate.a = 1.0
	
	if endlag <= 0.0:
		if !weapon.is_in_group("bomb"):
			weapon.look_at(get_global_mouse_position())
			if get_global_mouse_position().x < weapon.global_position.x:
				weapon.scale.y = -1.0
			else:
				weapon.scale.y = 1.0
		else:
			if get_global_mouse_position().x < weapon.global_position.x:
				weapon.scale.x = -1.0
			else:
				weapon.scale.x = 1.0
		if prevframeM1:
			chargebar.max_value = weapon.charge
			currentCharge += delta * ctrMult
			if currentCharge <= chargebar.max_value:
				chargebar.value = currentCharge
				chargebar.tint_over = Color(1.0, 1.0, 1.0)
			else:
				chargebar.value = chargebar.max_value
				chargebar.tint_over = Color(1.0, 1.0, 0.0)
			if (chargebar.value / chargebar.max_value) > 0.15:
				# print("charge: " + str(chargebar.value / chargebar.max_value))
				chargebar.visible = true
				if weapon.is_in_group("bomb"):
					weapon.putUp()
		else:
			chargebar.visible = false
	
	get_input()
	move_and_slide()
	

func swapWeapon():
	for i in get_children():
		if i.is_in_group("weapon"):
			i.queue_free()
	# print(active)
	# print(weapons[active])
	match(weapons[active]):
		1:
			# print("switch 1")
			var wep = wep1.instantiate()
			add_child(wep) 
		2:
			# print("switch 2")
			var wep = wep2.instantiate()
			add_child(wep)
		3:
			# print("switch 3")
			var wep = wep3.instantiate()
			add_child(wep)
		4:
			# print("switch 4")
			var wep = wep4.instantiate()
			add_child(wep)
		5:
			var wep = wep5.instantiate()
			add_child(wep)
		6:
			var wep = wep6.instantiate()
			add_child(wep)
		7:
			var wep = wep7.instantiate()
			add_child(wep)
		8:
			var wep = wep8.instantiate()
			add_child(wep)

func take_damage(n, p, e, s):
	if currIframes <= 0.0:
		health -= ((n * 100 / (100 + def)) + (p * 100 / (100 + defP)) + (e * 100 / (100 + defE)) + (s * 100 / (100 + defS)))
		currIframes = iframes
	
func boost(time):
	boosting = true
	await get_tree().create_timer(time).timeout
	boosting = false

func collect(item, quantity):
	if item == "medallion":
		medallions += quantity
	else:
		var invitem = InvItem.new(item)
		inv.items.append(invitem)
		get_parent().ui.get_child(0).update(invitem)
