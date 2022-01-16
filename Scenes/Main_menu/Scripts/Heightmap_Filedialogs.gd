extends FileDialog

#Config file for terrain.
var conf_file = ConfigFile.new()

#Which heightmap selection is passed over from parent WindowDialog.
var which = ""
#Path to config file.
var cfg_file_path = "res://Scenes/Game_Enviroment/terrain.cfg"
#Path to heightmap north-west
var heightmap_north_west
#Path to heightmap north-east
var heightmap_north_east
#Path to heightmap south-west
var heightmap_south_west
#Path to heightmap south-east
var heightmap_south_east


func _ready():
	#Set filetype filter to TIFF Images.
	get_node(".").set_filters(PoolStringArray(["*.tif ; TIFF Images"]))
	#Load config file & grab opening status.
	var status = conf_file.load(cfg_file_path)
	if status == OK:
		#Check config file for stored heightmap north-west path.
		var get_nw = conf_file.get_value("Heightmap-Layout","heightmap_nw")
		#Check so that the file is correct resolution & change stylebox color to hightligt status, & assign the filename to textlabel.
		var check_size_nw = load(get_nw).get_size()
		#If the resolution is correct, set the stylebox to indicate everything in order, & assign filename to textlabel.
		if check_size_nw == Vector2(3000,3000):
			get_node("../../Maps_Configuration_WindowDialog/MarginContainer/GridContainer/Select_Heightmap_NW_Button/Select_Heightmap_NW_File_Label").modulate = Color(0.06,0.86,0.3)
			get_nw = conf_file.get_value("Heightmap-Layout","heightmap_nw").get_file()
			get_node("../../Maps_Configuration_WindowDialog/MarginContainer/GridContainer/Select_Heightmap_NW_Button/Select_Heightmap_NW_File_Label").bbcode_text = "[center]"+get_nw+"[/center]"
		
		var get_ne = conf_file.get_value("Heightmap-Layout","heightmap_ne")
		var check_size_ne = load(get_ne).get_size()
		if check_size_ne == Vector2(3000,3000):
			get_node("../../Maps_Configuration_WindowDialog/MarginContainer/GridContainer/Select_Heightmap_NE_Button/Select_Heightmap_NE_File_Label").modulate = Color(0.06,0.86,0.3)
			get_ne = conf_file.get_value("Heightmap-Layout","heightmap_ne").get_file()
			get_node("../../Maps_Configuration_WindowDialog/MarginContainer/GridContainer/Select_Heightmap_NE_Button/Select_Heightmap_NE_File_Label").bbcode_text = "[center]"+get_ne+"[/center]"
		
		var get_sw = conf_file.get_value("Heightmap-Layout","heightmap_sw")
		var check_size_sw = load(get_sw).get_size()
		if check_size_sw == Vector2(3000,3000):
			get_node("../../Maps_Configuration_WindowDialog/MarginContainer/GridContainer/Select_Heightmap_SW_Button/Select_Heightmap_SW_File_Label").modulate = Color(0.06,0.86,0.3)
			get_sw = conf_file.get_value("Heightmap-Layout","heightmap_sw").get_file()
			get_node("../../Maps_Configuration_WindowDialog/MarginContainer/GridContainer/Select_Heightmap_SW_Button/Select_Heightmap_SW_File_Label").bbcode_text = "[center]"+get_sw+"[/center]"
		
		var get_se = conf_file.get_value("Heightmap-Layout","heightmap_se")
		var check_size_se = load(get_se).get_size()
		if check_size_se == Vector2(3000,3000):
			get_node("../../Maps_Configuration_WindowDialog/MarginContainer/GridContainer/Select_Heightmap_SE_Button/Select_Heightmap_SE_File_Label").modulate = Color(0.06,0.86,0.3)
			get_se = conf_file.get_value("Heightmap-Layout","heightmap_se").get_file()
			get_node("../../Maps_Configuration_WindowDialog/MarginContainer/GridContainer/Select_Heightmap_SE_Button/Select_Heightmap_SE_File_Label").bbcode_text = "[center]"+get_se+"[/center]"


func _on_Select_Heightmap_FileDialog_file_selected(path):
	#Get dimension of current heightmap.
	var dimension = load(path).get_size()
	#Make sure it is 3000x3000 pixels as needed.
	if dimension == Vector2(3000,3000):
		#Check which heightmap assignment is active.
		if which == "North-West":
			#Assign path to variable.
			heightmap_north_west = path
			#Set the header for north-west file label with bbcode centered.
			get_node("../../Maps_Configuration_WindowDialog/MarginContainer/GridContainer/Select_Heightmap_NW_Button/Select_Heightmap_NW_File_Label").bbcode_text = "[center]"+current_file+"[/center]"
			#Change the color of styleboxflat to indicate everything is in order.
			get_node("../../Maps_Configuration_WindowDialog/MarginContainer/GridContainer/Select_Heightmap_NW_Button/Select_Heightmap_NW_File_Label").modulate = Color(0.06,0.86,0.3)
			
			#Check which heightmap assignment is active.
		elif which == "North-East":
			#Assign path to variable.
			heightmap_north_east = path
			#Set the header for north-east file label with bbcode centered.
			get_node("../../Maps_Configuration_WindowDialog/MarginContainer/GridContainer/Select_Heightmap_NE_Button/Select_Heightmap_NE_File_Label").bbcode_text = "[center]"+current_file+"[/center]"
			#Change the color of styleboxflat to indicate everything is in order.
			get_node("../../Maps_Configuration_WindowDialog/MarginContainer/GridContainer/Select_Heightmap_NE_Button/Select_Heightmap_NE_File_Label").modulate = Color(0.06,0.86,0.3)
			
		elif which == "South-West":
			#Assign path to variable.
			heightmap_south_west = path
			#Set the header for south-west file label with bbcode centered.
			get_node("../../Maps_Configuration_WindowDialog/MarginContainer/GridContainer/Select_Heightmap_SW_Button/Select_Heightmap_SW_File_Label").bbcode_text = "[center]"+current_file+"[/center]"
			#Change the color of styleboxflat to indicate everything is in order.
			get_node("../../Maps_Configuration_WindowDialog/MarginContainer/GridContainer/Select_Heightmap_SW_Button/Select_Heightmap_SW_File_Label").modulate = Color(0.06,0.86,0.3)
			
		elif which == "South-East":
			#Assign path to variable.
			heightmap_south_east = path
			#Set the header for south-east file label with bbcode centered.
			get_node("../../Maps_Configuration_WindowDialog/MarginContainer/GridContainer/Select_Heightmap_SE_Button/Select_Heightmap_SE_File_Label").bbcode_text = "[center]"+current_file+"[/center]"
			#Change the color of styleboxflat to indicate everything is in order.
			get_node("../../Maps_Configuration_WindowDialog/MarginContainer/GridContainer/Select_Heightmap_SE_Button/Select_Heightmap_SE_File_Label").modulate = Color(0.06,0.86,0.3)
	heightmap_conf_store()


func heightmap_conf_store():
	
	if which == "North-West":
		conf_file.load(cfg_file_path)
		conf_file.set_value("Heightmap-Layout","heightmap_nw",heightmap_north_west)
	elif which == "North-East":
		conf_file.load(cfg_file_path)
		conf_file.set_value("Heightmap-Layout","heightmap_ne",heightmap_north_east)
	elif which == "South-West":
		conf_file.load(cfg_file_path)
		conf_file.set_value("Heightmap-Layout","heightmap_sw",heightmap_south_west)
	elif which == "South-East":
		conf_file.load(cfg_file_path)
		conf_file.set_value("Heightmap-Layout","heightmap_se",heightmap_south_east)
	conf_file.save(cfg_file_path)
