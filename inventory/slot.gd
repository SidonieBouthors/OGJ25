extends AspectRatioContainer
class_name Slot

@onready var button: TextureButton = $SlotButton
@onready var margin: MarginContainer = $SlotButton/Margin
@onready var inventory : Inventory = GlobalInventory
var itemStackGui: ItemStackGUI

func _ready():
	var margin_value = 20
	margin.add_theme_constant_override("margin_top", margin_value)
	margin.add_theme_constant_override("margin_left", margin_value)
	margin.add_theme_constant_override("margin_bottom", margin_value)
	margin.add_theme_constant_override("margin_right", margin_value)

func insert(isg: ItemStackGUI):
	itemStackGui = isg
	margin.add_child(itemStackGui)
	button.set_isg(isg)

func takeItem() -> ItemGUI:
	if inventory.remove(itemStackGui.item):
		var new_itemGUI = await GlobalScript.insertInHand(itemStackGui.item)
		itemStackGui.update()
		return new_itemGUI
	return null
	
func _process(delta):
	if itemStackGui:
		if itemStackGui.amount != 0:
			button.disabled = false
		else:
			button.disabled = true
