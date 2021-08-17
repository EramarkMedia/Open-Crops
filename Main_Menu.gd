extends Control



#Game Enviroment Loading.
var game_enviroment


#Events

#Main Menu Start Button.
func _On_Start_Game_Button_Pressed():
	#Check If We Got Assets & Handle The Rest From There.
	check_asset_essentials()

#Main Menu Exit Button.
func _On_Exit_Button_Pressed():
	#If Anyone Ever Wants To Exit.
	get_tree().quit()

func _on_Configure_Button_Pressed():
	get_node("Configuration_WindowDialog").show()

#Reset labels in prompt window.
func _On_Prompt_User_WindowDialog_Hide():
	reset_user_prompt_window("","","","")

#Unsure if bbcode should be used for reset as well ?.
func reset_user_prompt_window(var window_header,var header_label,var footer_label,var user_action):
	#Re-Set The Window Header Label.
	get_node("Prompt_User_WindowDialog").window_title = window_header
	#Re-Set The Header Label.
	get_node("Prompt_User_WindowDialog/Prompt_User_Window_Header_Label").text = header_label
	#Re-Set The Footer Label.
	get_node("Prompt_User_WindowDialog/Prompt_User_Window_Footer_Label").text = footer_label
	#Re-Set Hoax Symbol.
	get_node("Prompt_User_WindowDialog/Visibility_Control_Hox_Symbol").hide()
	#Stop Supercool Hoax Symbol Animation & Reset.
	get_node("Prompt_User_WindowDialog/Hox_Symbol_Blink_Animation").stop(true)

#Draw User Prompt Window.
func display_user_prompt_window(var window_header,var header_label,var footer_label,var user_action):
	
	#Show User Prompt Window.
	get_node("Prompt_User_WindowDialog").show()
	
	#Set The Window Header Label.
	get_node("Prompt_User_WindowDialog").window_title = window_header
	#Set The Header Label.
	get_node("Prompt_User_WindowDialog/Prompt_User_Window_Header_Label").bbcode_text = "[center]"+header_label+"[/center]"
	#Set The Footer Label.
	get_node("Prompt_User_WindowDialog/Prompt_User_Window_Footer_Label").bbcode_text = "[center]"+footer_label+"[/center]"
	
	if window_header == "Error":
		#Display Hox Symbol.
		get_node("Prompt_User_WindowDialog/Visibility_Control_Hox_Symbol").show()
		#Also
		#Select & Start Our Supercool Hox Animation.
		get_node("Prompt_User_WindowDialog/Hox_Symbol_Blink_Animation").play("Hox_Symbol_Blink") 
	elif window_header == "Warning":
		#Display Hox Symbol.
		get_node("Prompt_User_WindowDialog/Visibility_Control_Hox_Symbol").show()
		#Also
		#Select & Start Our Supercool Hox Animation.
		get_node("Prompt_User_WindowDialog/Hox_Symbol_Blink_Animation").play("Hox_Symbol_Blink")
	
	if user_action == "Select":
		get_node("Prompt_User_WindowDialog/Visibility_Control_Selection_Buttons").show()


func check_asset_essentials():
	#Check If We Have Assets Folder Present.
	#If Not, Lets Try To Do Something About it.
	
	
	#Do We Have The New Assets Library?
	var check_assets_dir = Directory.new().dir_exists("res://Assets/")
	if !check_assets_dir:
		#If Not, Notify User.
		display_user_prompt_window("Error","Asset Library Missing","Add Library & Download Content?","select")
		#Do HttpRequest In Future.
		
	if check_assets_dir:
		#We Got The Assets Folder.
		#Check For Maps Folder As Next.
		var check_map_dir = Directory.new().dir_exists("res://Assets/Maps")
		if !check_map_dir:
			display_user_prompt_window("Warning","Maps Folder Missing","Add Library & Re-Download Content?","Select")
		
		#Launch Game Enviroment & Handle Essentials For That.
		else:
			#Hide Main Menu
			get_node(".").hide()
			#Sadly, Stop Our Superawesome Intro Song.
			get_node("AudioStreamPlayer").stop()
			#Add Game Enviroment Scene.
			add_child(game_enviroment)


# Called when the node enters the scene tree for the first time.
func _ready():
	#Run The Header Slide In Animation.
	get_node("Header_Slide_In_AnimationPlayer").current_animation = "Header_Slide_In"
	get_node("Header_Slide_In_AnimationPlayer").play()
	#Delay Intro Music Slightly.
	get_node("Music_Intro_Delay_Timer").start(1)
	
	#Preload game enviroment.
	game_enviroment = preload("res://Scenes/Game_Enviroment/Open_Crops_Env.tscn").instance()



func _On_AudioStreamPlayer_Finished():
	#If Main Menu Is Vibisble, Loop Theme Song.
	if ($".").is_visible():
		get_node("AudioStreamPlayer").play()
	


func _On_Music_Intro_Delay_Timer_Timeout():
	#Stop The Music Intro Delay Timer.
	get_node("Music_Intro_Delay_Timer").stop()
	#Play Our Rocksolid Intro Music.
	get_node("AudioStreamPlayer").play()



func _On_Header_Slide_In_AnimationPlayer_Animation_Finished(Header_Slide_In):
	#When header slide finished, Insert Version Information.
	get_node("Top_Panel/Visibility_Control_Version_Info").show()

