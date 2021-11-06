extends WindowDialog


func _ready():
	pass # Replace with function body.


func _on_Select_Heightmap_NW_Button_pressed():
	get_node("Select_Heightmap_FileDialog").which = "North-West"
	get_node("../Maps_Configuration_WindowDialog/Select_Heightmap_FileDialog").popup_centered()


func _on_Select_Heightmap_NE_Button_pressed():
	get_node("Select_Heightmap_FileDialog").which = "North-East"
	get_node("../Maps_Configuration_WindowDialog/Select_Heightmap_FileDialog").popup_centered()


func _on_Select_Heightmap_SW_Button_pressed():
	get_node("Select_Heightmap_FileDialog").which = "South-West"
	get_node("../Maps_Configuration_WindowDialog/Select_Heightmap_FileDialog").popup_centered()


func _on_Select_Heightmap_SE_Button_pressed():
	get_node("Select_Heightmap_FileDialog").which = "South-East"
	get_node("../Maps_Configuration_WindowDialog/Select_Heightmap_FileDialog").popup_centered()
