extends Control

#Header AnimationPlayer.
onready var header_anim_player = AnimationPlayer.new()
#Theme Music AudioStreamPlayer.
onready var audio_player = AudioStreamPlayer.new()

#Game Enviroment Loading.
var game_enviroment


#Events
#Buttons
#Main Menu Start Button.
func _On_Start_Game_Button_Pressed():
	#Check If We Got Assets & Handle The Rest From There.
	#check_asset_essentials()
	launch_enviroment()

#Main Menu Exit Button.
func _On_Exit_Button_Pressed():
	#If Anyone Ever Wants To Exit.
	get_tree().quit()

#Configuration Button.
func _on_Configure_Button_Pressed():
	get_node("Configuration_WindowDialog").show()

func play_theme_music():
	#Load our theme song.
	var track = load("res://Scenes/Main_menu/Soundtrack/Open-Crops_Theme.wav")
	#Add audiostreamplayer as child.
	add_child(audio_player)
	#Set stream to loaded track.
	audio_player.set_stream(track)
	#Connect finished signal to finished function.
	audio_player.connect("finished",self,"AudioStreamPlayer_Finished")
	#play theme song.
	audio_player.play()

#Function for animating the Open-Crops header. "Slide in"
func animate_header():
	#Load the slide in animation.
	var anim = load("res://Scenes/Main_menu/Animations/Header_Slide_In.anim")
	#Add the animationplayer as child.
	add_child(header_anim_player)
	#Connect the animationplayer finished signal to animation finished function.
	header_anim_player.connect("animation_finished",self,"Header_Slide_In_Animation_Finished")
	#Add the loaded animation by name.
	header_anim_player.add_animation("Header_Slide_In", anim)
	#Set the current animation.
	header_anim_player.set_current_animation("Header_Slide_In")
	#Play the current animation.
	header_anim_player.play()

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
		var check_map_dir = Directory.new().dir_exists("res://Assets/Terrain")
		if !check_map_dir:
			display_user_prompt_window("Warning","Maps Folder Missing","Add Library & Re-Download Content?","Select")
		
		#Launch Game Enviroment & Handle Essentials For That.
		else:
			#Hide Main Menu
			get_node(".").hide()
			#Sadly, Stop Our Superawesome Intro Song.
			audio_player.stop()
			#Add Game Enviroment Scene.
			add_child(game_enviroment)
			#Note to self, remember to free audiostreamplayer.

func launch_enviroment():
	#Hide Main Menu
	get_node(".").hide()
	#Sadly, Stop Our Superawesome Intro Song.
	audio_player.stop()
	#Add Game Enviroment Scene.
	add_child(game_enviroment)
	#Note to self, remember to free audiostreamplayer.

# Called when the node enters the scene tree for the first time.
func _ready():
	animate_header()
	
	#Preload game enviroment.
	game_enviroment = preload("res://Scenes/Game_Enviroment/Open_Crops_Env.tscn").instance()



func AudioStreamPlayer_Finished():
	#If Main Menu Is Vibisble, Loop Theme Song.
	if ($".").is_visible():
		play_theme_music()
	


func Header_Slide_In_Animation_Finished(_Header_Slide_In):
	#When header slide finished, Insert Version Information.
	get_node("Header/Background_Panel/Version_Label").show()
	#Destroy the header animationplayer, since we don't need it anymore.
	header_anim_player.queue_free()
	#Play Our Rocksolid Intro Music.
	play_theme_music()

