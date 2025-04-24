extends MarginContainer

# @onready var icon = $"HBoxContainer/Icon".texture
# @onready var label = $"HBoxContainer/Label".text

func setItem(i, l, c = 1, clickable = false):
	$"HBoxContainer/Icon".texture = i
	$"HBoxContainer/Label".text = l
	$"HBoxContainer2/Count".text = str(c)
	if c == 1:
		$"HBoxContainer2/Count".visible = false
	if clickable:
		$"TextureButton".disabled = false
	else:
		$TextureButton.disabled = true

func getItem():
	return $"HBoxContainer/Label".text

func increase(c = 1):
	$"HBoxContainer2/Count".visible = true
	$"HBoxContainer2/Count".text = str(int($"HBoxContainer2/Count".text) + c)
