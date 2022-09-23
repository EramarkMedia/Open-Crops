extends Control

#Export version description tag to editor.
@export var version_tag: String;

#Header animation var's.
#AnimationPlayer.
var anim_player_header;
#AnimationLibrary.
var anim_lib;


func init():
	#Set processing to false.
	set_process(false);
	
	#Hide Version Label. For the sake of good practice.
	$"Top_Bar_Hbox/Top_Bar_Background/Header/Version_Label".hide();


func _ready():
	#Delay header animation slightly.
	await get_tree().create_timer(0.2).timeout;
	
	#Play header animation.
	play_header_animation();



func play_header_animation():
	#Create our header AnimationPlayer.
	anim_player_header = AnimationPlayer.new();
	
	#Add AnimationPlayer as child.
	add_child(anim_player_header);
	
	#Create AnimationPlayer Library.
	anim_lib = AnimationLibrary.new();
	
	
	#Connect finished signal to Header_Slide_Finished function.
	anim_player_header.animation_finished.connect(Header_Slide_Finished);
	#If wishing to pass argument. Header_Slide_Finished.bind(argument_to_pass)
	
	
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
	
	
	#Reset position to zero in timeline, for the sake of good practice.
	anim_player_header.seek(0,true);
	
	#Play animation.
	anim_player_header.play();



func Header_Slide_Finished(_anim_name):
	#Free animation player, since we don't need it anymore.
	anim_player_header.queue_free();
	
	#Delay version tag text slightly.
	await get_tree().create_timer(0.2).timeout;
	
	#Set version label
	$"VBoxContainer/Top_Bar_Hbox/Top_Bar_Background/Header/Version_Label".text = version_tag;
	
	#Draw version label.
	$"VBoxContainer/Top_Bar_Hbox/Top_Bar_Background/Header/Version_Label".show();
