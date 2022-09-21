extends Control




func Header_Slide_On_Finished():
	print("Finish")


func _ready():
	#Set processing to false.
	set_process(false);
	#Delay header animation slightly.
	await get_tree().create_timer(0.2).timeout
	
	play_header_animation();
	

func play_header_animation():
	#Create our header AnimationPlayer.
	var anim_player_header = AnimationPlayer.new();
	
	#Create AnimationPlayer Library.
	var anim_lib = AnimationLibrary.new();
	
	#Add AnimationPlayer as child.
	add_child(anim_player_header);
	
	
	#Load animation.
	var anim = load("res://Scenes/Main_Menu/Animations/Header_Slide_In.anim");
	#Add header slide in animation to library.
	anim_lib.add_animation("Header_Slide_In",anim);
	#Add library to AnimationPlayer.
	anim_player_header.add_animation_library("Header-Animation",anim_lib);
	
	#Get current animation list.
	var list = anim_player_header.get_animation_list();
	#Set current animation to first in list.
	anim_player_header.set_current_animation(list[0]);
	#Reset position to zero in timeline, for good practice.
	anim_player_header.seek(0,true);
	#Play animation.
	anim_player_header.play();


