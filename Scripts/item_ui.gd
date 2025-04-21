extends MarginContainer

# @onready var icon = $"HBoxContainer/Icon".texture
# @onready var label = $"HBoxContainer/Label".text

func setItem(i, l):
	$"HBoxContainer/Icon".texture = i
	$"HBoxContainer/Label".text = l
