extends Control



#Events
func _On_Start_Game_Button_Pressed():
	#check_asset_essentials()
	
	var game_enviroment = load("res://Scenes/Game_Enviroment/Open_Crops_Env.tscn").instance()
	add_child(game_enviroment)
	get_node(".").hide()
	get_node("AudioStreamPlayer").stop()
	
	pass 

func _On_Prompt_User_WindowDialog_Hide():
	reset_user_prompt_window("","","","")
	pass 

func reset_user_prompt_window(var window_header,var header_label,var footer_label,var user_action):
	#Re-Set The Window Header Label.
	get_node("Prompt_User_WindowDialog/Window_Header_Label").text = window_header
	#Re-Set The Header Label.
	get_node("Prompt_User_WindowDialog/Prompt_User_Window_Header_Label").text = header_label
	#Re-Set The Footer Label.
	get_node("Prompt_User_WindowDialog/Prompt_User_Window_Footer_Label").text = footer_label
	#Re-Set Hoax Symbol.
	get_node("Prompt_User_WindowDialog/Visibility_Control_Hox_Symbol").hide()
	#Stop Supercool Hoax Symbol Animation & Reset.
	get_node("Prompt_User_WindowDialog/Hox_Symbol_Blink_Animation").stop(true)
	pass

#Draw Window.
# Window Header, Header Label, Footer Label, User Action.
func display_user_prompt_window(var window_header,var header_label,var footer_label,var user_action):
	
	#Draw User Prompt Window.
	get_node("Prompt_User_WindowDialog").show()
	
	#Set The Window Header Label.
	get_node("Prompt_User_WindowDialog/Window_Header_Label").text = window_header
	#Set The Header Label.
	get_node("Prompt_User_WindowDialog/Prompt_User_Window_Header_Label").text = header_label
	#Set The Footer Label.
	get_node("Prompt_User_WindowDialog/Prompt_User_Window_Footer_Label").text = footer_label
	
	if window_header == "Error":
		#Display Hox Symbol.
		get_node("Prompt_User_WindowDialog/Visibility_Control_Hox_Symbol").show()
		#Also
		#Select & Start Our Supercool Hox Animation.
		get_node("Prompt_User_WindowDialog/Hox_Symbol_Blink_Animation").play("Hox_Symbol_Blink") 
	
	if user_action == "select":
		get_node("Prompt_User_WindowDialog/Visibility_Control_Selection_Buttons").show()
	
	
	
	pass





func check_asset_essentials():
	#Check If We Have Assets Root Folder Present.
	#If Not, Lets Try To Do Something About it.
	
	
	#Do We Have The New Assets Library?
	var check_essentials = Directory.new().dir_exists("res://Scenes/Game_Enviroment/Assets/")
	#If Not, Notify User.
	
	
	if check_essentials == false:
		
		display_user_prompt_window("Error","Asset Library Missing","Add Library & Download Content","select")
		
		
		
	if check_essentials == true:
		#We Got The Assets Folder.
		#Do We Have Terrain Folder Inside Assets? Maybe Added Manually ?
		var check_terrain_content = Directory.new().dir_exists("res://Terrain/")
		#If Not Notify & Grab.
		if check_terrain_content == false:
			#Notify On Screen.
			print("Do HTTP-Request In Future")
			
			
		
	
	pass


# Called when the node enters the scene tree for the first time.
func _ready():
	#Run The Header Slide In Animation.
	get_node("Header_Slide_In_AnimationPlayer").current_animation = "Header_Slide_In"
	get_node("Header_Slide_In_AnimationPlayer").play()
	#Delay Intro Music Slightly.
	get_node("Music_Intro_Delay_Timer").start(1)
	
	pass 




func _On_AudioStreamPlayer_Finished():
	#Attention. 
	#get_node("AudioStreamPlayer").play()
	pass 





func _On_Music_Intro_Delay_Timer_Timeout():
	#Stop The Music Intro Delay Timer.
	get_node("Music_Intro_Delay_Timer").stop()
	#Play Our Rocksolid Intro Music.
	get_node("AudioStreamPlayer").play()
	pass 





func _On_Header_Slide_In_AnimationPlayer_Animation_Finished(Header_Slide_In):
	#Insert Version Information.
	get_node("Top_Panel/Visibility_Control_Version_Info").show()
	#And Check If We Got Assets.
	check_asset_essentials()
	pass 





