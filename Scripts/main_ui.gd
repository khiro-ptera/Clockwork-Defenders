extends Control

var itemUISC = preload("res://Scenes/item_ui.tscn")

@onready var l1 = $"Layer1" # unclickable layer
@onready var pinfo = $"Layer1/PlayerInfo"
@onready var currency = $"Layer1/PlayerInfo/CurrC/Currency"
@onready var medlabel = $"Layer1/PlayerInfo/CurrC/Medallions"
@onready var hpbar = $"Layer1/PlayerInfo/HPC/HP"
@onready var dashbar = $"Layer2/HotBar/Dash/TextureProgressBar"

@onready var l2 = $"Layer2" # clickable layer
@onready var ptabs = $"Layer2/PlayerTabs"
@onready var invTab = $"Layer2/PlayerTabs/Inventory"
@onready var items = $"Layer2/PlayerTabs/Inventory/Items"
@onready var icons = [$"Layer2/HotBar/W1/Icon", $"Layer2/HotBar/W2/Icon", $"Layer2/HotBar/W3/Icon", $"Layer2/HotBar/W4/Icon"]
@onready var buttons = [$"Layer2/HotBar/W1/B1", $"Layer2/HotBar/W2/B2", $"Layer2/HotBar/W3/B3", $"Layer2/HotBar/W4/B4"]

@onready var screensize = get_viewport().get_visible_rect().size
var player
var invOpen = false

func _process(delta: float) -> void:
	player = get_parent().get_parent().p
	
	size = screensize
	l1.size = Vector2(screensize.x, screensize.y)
	pinfo.size = Vector2(screensize.x / 8, screensize.y / 6)
	hpbar.max_value = player.maxH
	hpbar.value = player.health
	medlabel.text = "Medallions: " + str(player.medallions)
	
	l2.size = Vector2(screensize.x, screensize.y)
	ptabs.size.y = screensize.y
	invTab.size.x = 144.0
	invTab.visible = invOpen
	
	if player.dashUp:
		dashbar.value = 0.0
	else:
		dashbar.value = 100 * player.dashTimer.get_time_left()/player.dashCD
	
	if Input.is_action_just_pressed("Inventory"):
		if invOpen:
			invOpen = false
		else:
			invOpen = true
	
	for i in player.weapons.size():
		if player.weapons[i] != 0:
			icons[i].texture = load("res://Assets/sprites/weapons/icons/" + Global.wdict.find_key(player.weapons[i]) + ".png")
		else:
			icons[i].texture = null
	for i in buttons.size():
		if player.active == i:
			buttons[i].disabled = true
		else:
			buttons[i].disabled = false

func update(item: InvItem):
	var tempi = itemUISC.instantiate()
	# tempi.icon = item.texture
	# tempi.label = item.name
	# print(tempi.label)
	# print(item.name)
	if item.schema != 0:
		var wname = Global.wdict.find_key(item.schema)
		tempi.setItem(item.texture, wname + " schema", 1, 1)
	else:
		tempi.setItem(item.texture, item.name)
	items.add_child(tempi)

func increase(item: String, c = 1):
	for i in items.get_children():
		if i.getItem() == item:
			i.increase(c)
			break

func _on_b_1_pressed() -> void:
	player.active = 0
	print("hi")
	player.swapWeapon()

func _on_b_2_pressed() -> void:
	player.active = 1
	print("hi")
	player.swapWeapon()

func _on_b_3_pressed() -> void:
	player.active = 2
	print("hi")
	player.swapWeapon()

func _on_b_4_pressed() -> void:
	player.active = 3
	print("hi")
	player.swapWeapon()
