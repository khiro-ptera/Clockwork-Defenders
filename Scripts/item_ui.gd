extends MarginContainer

# @onready var icon = $"HBoxContainer/Icon".texture
# @onready var label = $"HBoxContainer/Label".text
# @onready var overlay = $"DescOverlay"
# @onready var desc = $"DescOverlay/Desc".text

enum uses { # what does the click do? NOT THE AMOUNT OF USES
	schema = 1
}

var use = 0

var item: InvItem

func setItem(i: InvItem, l, c = 1, clickable = 0):
	item = i
	$"HBoxContainer/Icon".texture = i.texture
	$"HBoxContainer/Label".text = l
	$"HBoxContainer2/Count".text = str(c)
	
	use = clickable
	if c == 1:
		$"HBoxContainer2/Count".visible = false
	$"TextureButton".disabled = false
	$"DescOverlay".visible = false

func getItem():
	return $"HBoxContainer/Label".text

func increase(c = 1):
	$"HBoxContainer2/Count".visible = true
	$"HBoxContainer2/Count".text = str(int($"HBoxContainer2/Count".text) + c)

func _on_texture_button_pressed() -> void:
	match(use):
		0:
			pass
		1:
			print($"HBoxContainer/Label".text)
			print($"HBoxContainer/Label".text.rstrip(" schema"))
			var wep = Global.wdict.get($"HBoxContainer/Label".text.rstrip(" schema"))
			if !Global.knownSchema.has(wep):
				Global.knownSchema.append(wep)
				print(Global.knownSchema)
				queue_free()

func _on_texture_button_mouse_entered() -> void:
	if use == 1:
		$"DescOverlay/Desc".text = "Learn Schema?"
	else:
		$"DescOverlay/Desc".text = item.description
	$"DescOverlay".visible = true

func _on_texture_button_mouse_exited() -> void:
	$"DescOverlay".visible = false
