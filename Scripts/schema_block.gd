extends MarginContainer

var id: int
var w: String

func _ready() -> void:
	$"HBoxContainer/Weapon".texture = load("res://Assets/sprites/weapons/icons/" + w + ".png")
	$"HBoxContainer/Label".text = w

func _on_texture_button_pressed() -> void: # not clicking??????
	print("ccclick")
	get_parent().get_parent().get_parent().get_parent().select(w)
