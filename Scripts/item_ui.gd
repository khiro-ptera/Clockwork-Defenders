extends MarginContainer

# @onready var icon = $"HBoxContainer/Icon".texture
# @onready var label = $"HBoxContainer/Label".text

enum uses {
	schema = 1
}

var use = 0

func setItem(i, l, c = 1, clickable = 0):
	$"HBoxContainer/Icon".texture = i
	$"HBoxContainer/Label".text = l
	$"HBoxContainer2/Count".text = str(c)
	use = clickable
	if c == 1:
		$"HBoxContainer2/Count".visible = false
	if clickable != 0:
		print("schem")
		$"TextureButton".disabled = false
	else:
		$TextureButton.disabled = true

func getItem():
	return $"HBoxContainer/Label".text

func increase(c = 1):
	$"HBoxContainer2/Count".visible = true
	$"HBoxContainer2/Count".text = str(int($"HBoxContainer2/Count".text) + c)

func _on_texture_button_pressed() -> void:
	if use == 1: # schema
		print($"HBoxContainer/Label".text)
		print($"HBoxContainer/Label".text.rstrip(" schema"))
		var wep = Global.wdict.get($"HBoxContainer/Label".text.rstrip(" schema"))
		if !Global.knownSchema.has(wep):
			Global.knownSchema.append(wep)
			print(Global.knownSchema)
			queue_free()
