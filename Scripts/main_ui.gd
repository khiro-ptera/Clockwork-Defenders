extends Control

@onready var l1 = $"Layer1"
@onready var pinfo = $"Layer1/PlayerInfo"
@onready var currency = $"Layer1/PlayerInfo/CurrC/Currency"
@onready var hpbar = $"Layer1/PlayerInfo/HPC/HP"
@onready var medlabel = $"Layer1/PlayerInfo/CurrC/Medallions"
@onready var screensize = get_viewport().get_visible_rect().size
var player

func _process(delta: float) -> void:
	size = screensize
	l1.size = Vector2(screensize.x, screensize.y)
	pinfo.size = Vector2(screensize.x / 8, screensize.y / 6)
	player = get_parent().get_parent().p
	hpbar.max_value = player.maxH
	hpbar.value = player.health
	medlabel.text = "Medallions: " + str(player.medallions)
