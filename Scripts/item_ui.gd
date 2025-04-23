extends MarginContainer

# @onready var icon = $"HBoxContainer/Icon".texture
# @onready var label = $"HBoxContainer/Label".text

func setItem(i, l, clickable = false):
	$"HBoxContainer/Icon".texture = i
	$"HBoxContainer/Label".text = l
	if clickable:
		$"TextureButton".disabled = false
	else:
		$TextureButton.disabled = true
