extends Control

var itemUISC = preload("res://Scenes/item_ui.tscn")

@onready var l1 = $"Layer1"
@onready var pinfo = $"Layer1/PlayerInfo"
@onready var currency = $"Layer1/PlayerInfo/CurrC/Currency"
@onready var medlabel = $"Layer1/PlayerInfo/CurrC/Medallions"
@onready var hpbar = $"Layer1/PlayerInfo/HPC/HP"

@onready var l2 = $"Layer2"
@onready var ptabs = $"Layer2/PlayerTabs"
@onready var invTab = $"Layer2/PlayerTabs/Inventory"
@onready var items = $"Layer2/PlayerTabs/Inventory/Items"

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
	
	if Input.is_action_just_pressed("Inventory"):
		if invOpen:
			invOpen = false
		else:
			invOpen = true

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
