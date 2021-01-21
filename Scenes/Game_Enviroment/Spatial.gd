extends Spatial

export(NodePath) var x_label
export(NodePath) var y_label
export(NodePath) var z_label
export(NodePath) var geocords_label
export(NodePath) var geocheck_label
export(NodePath) var elevation_label


#Developer Console Variables.
#---------------------------------------#

#Path To Dev Console.
var dev_console = "Dev_Console_Panel"

#Paths To Timers.
var info_label_timer = "Dev_Console_Panel/Dev_Console_Info_Label_Handler_Timer"

#Path To Info Panel.
var dev_console_info_panel = "Dev_Console_Panel/Dev_Console_Info_Panel"

#Path To Info Panel Text Label.
var info_panel_text_label = "Dev_Console_Panel/Dev_Console_Info_Panel/Dev_Console_Info_Panel_Label"



#---------------------------------------#

var etrs89proj = ETRS89Projection.new()

func round_tenths(f):
	return round(f*10)/10

func deg2dms(deg):
	var d = floor(deg)
	var drem = deg - d
	var ms = drem * 60
	var m = floor(ms)
	var mrem = ms - m
	var ss = mrem * 60
	return str(d,"°",m,"'",ss,'"')


#Events.

#Input Events.
func _input(event):
	
	
	
	#Toggle Developer Console Visibility Event.
	if event.is_action_pressed("toggle_developer_console"):
		#Visibility Status.
		var dev_con_visible = get_node(dev_console).is_visible()
		
		#Dev Panel Visible.
		if dev_con_visible == true:
			get_node(dev_console).hide()
		
		#Dev Panel Hidden.
		if dev_con_visible == false:
			get_node(dev_console).show()
			
			#Show Info Panel Text Label.
			get_node(info_panel_text_label).show()
			
			#Start Timer To Hide Info Label.
			get_node(info_label_timer).start(3)
		pass

#Timeout Events.
func _On_Dev_Console_Info_Label_Handler_Timer_Timeout():
	#Stop The Info Label Timer.
	get_node(info_label_timer).stop()
	
	#Hide Info Panel.
	get_node(dev_console_info_panel).hide()
	
	#Hide Info Label.
	get_node(info_panel_text_label).hide()
	pass 

# warning-ignore:unused_argument
func _process(delta):
	get_node(x_label).text = str(round_tenths($Camera.transform.origin.x))
	get_node(y_label).text = str(round_tenths($Camera.transform.origin.y))
	get_node(z_label).text = str(round_tenths($Camera.transform.origin.z))
	var position = Vector2($Camera.transform.origin.x,$Camera.transform.origin.z)
	var geocords = etrs89proj.local_to_global(position)
	get_node(geocords_label).text = str(deg2dms(geocords.y),"N ",deg2dms(geocords.x),"E")
	var geocheck = etrs89proj.global_to_local(geocords)
	get_node(geocheck_label).text = str(
		"Check: ", geocheck,
		"\nDistance check: ",position.distance_to(geocheck))
	var camera = $Camera
	var tile_generator = $VoxelLodTerrain.stream.fallback_stream
	#get_node(elevation_label).text = str("Elevation: ", tile_generator.get_elevation(camera.transform.origin.x,camera.transform.origin.z))

func apply_image_as_height_texture(image, location):
	#var north_west_height_map = preload("res://assets/Q4111E.tif")
	var height_texture = ImageTexture.new()
	height_texture.create_from_image(image)
	$VoxelLodTerrain.material.set_shader_param(location, height_texture)

func _ready():
	var tile_generator = $VoxelLodTerrain.stream.fallback_stream
	tile_generator.set_cell(-1,-1,"res://Scenes/Game_Enviroment/Assets/Terrain/Heightmaps/Q4111E.tif")
	apply_image_as_height_texture(preload("res://Scenes/Game_Enviroment/Assets/Terrain/Heightmaps/Q4111E.tif"), "height_north_west")
	tile_generator.set_cell( 0,-1,"res://Scenes/Game_Enviroment/Assets/Terrain/Heightmaps/Q4111G.tif")
	apply_image_as_height_texture(preload("res://Scenes/Game_Enviroment/Assets/Terrain/Heightmaps/Q4111G.tif"), "height_north_east")
	tile_generator.set_cell(-1, 0,"res://Scenes/Game_Enviroment/Assets/Terrain/Heightmaps/P4222F.tif")
	apply_image_as_height_texture(preload("res://Scenes/Game_Enviroment/Assets/Terrain/Heightmaps/P4222F.tif"), "height_south_west")
	tile_generator.set_cell( 0, 0,"res://Scenes/Game_Enviroment/Assets/Terrain/Heightmaps/P4222H.tif")
	apply_image_as_height_texture(preload("res://Scenes/Game_Enviroment/Assets/Terrain/Heightmaps/P4222H.tif"), "height_south_east")

func _on_Timer_timeout():
	var camera = $Camera
	if (camera.is_translating):
		var vtool = $VoxelLodTerrain.get_voxel_tool()
		vtool.channel = 0
		vtool.mode = VoxelTool.MODE_REMOVE
		vtool.do_sphere(camera.transform.origin, 1)
		vtool.channel = 1
		vtool.mode = VoxelTool.MODE_REMOVE
		vtool.do_sphere(camera.transform.origin, 1)


func _on_ClearButton_toggled(button_pressed):
	if (button_pressed):
		$Timer.start()
	else:
		$Timer.stop()


func _on_Timer2_timeout():
	var camera = $Camera
	var tile_generator = $VoxelLodTerrain.stream.fallback_stream
	get_node(elevation_label).text = str("Elevation:", tile_generator.get_elevation(camera.transform.origin.x,camera.transform.origin.z))





