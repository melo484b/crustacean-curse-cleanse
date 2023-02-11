extends CanvasLayer


var selected: int = 0
var boon_1_hovered: bool = false
var boon_2_hovered: bool = false
var boon_3_hovered: bool = false

func _on_Button_pressed():
	# TODO: Start game
	PlayerData.set_boon_selection(selected)


func _on_Boon_1_mouse_entered():
	boon_1_hovered = true


func _on_Boon_1_mouse_exited():
	boon_1_hovered = false


func _on_Boon_1_gui_input(event):
	if boon_1_hovered and event.is_action_pressed("attack"):
		selected = 0


func _on_Boon_2_mouse_entered():
	boon_2_hovered = true


func _on_Boon_2_mouse_exited():
	boon_2_hovered = false


func _on_Boon_2_gui_input(event):
	if boon_2_hovered and event.is_action_pressed("attack"):
		selected = 1


func _on_Boon_3_mouse_entered():
	boon_3_hovered = true


func _on_Boon_3_mouse_exited():
	boon_3_hovered = false


func _on_Boon_3_gui_input(event):
	if boon_3_hovered and event.is_action_pressed("attack"):
		selected = 2
