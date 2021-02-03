extends Panel


#Developer Console Variables.
#---------------------------------------#
#Paths

#Path To Dev Console.
var dev_console = "."

#Paths To Timers.
var info_label_timer = "./Dev_Console_Info_Label_Handler_Timer"

#Path To Dev Console Entry Panel Text Entry.
var dev_console_text_entry = "./Dev_Console_Text_Entry"

#Path To Dev Console Vbox Container.
var dev_console_vbox_container = "./ScrollContainer/VBoxContainer"

#Status

#Visibility_Status

#Developer Console Visibility. Is Devcon Visible?
var dev_con_visible

#---------------------------------------#


#Events.

#Input Events.
func _input(event):
	
	
	
	#Toggle Developer Console Visibility Event.
	if event.is_action_pressed("toggle_developer_console"):
		
		#Check Developer Console Visibility.
		dev_con_visible = get_node(dev_console).is_visible()
		
		#Dev Console Visible.
		if dev_con_visible == true:
			get_node(dev_console).hide()
		
		#Dev Console Hidden.
		if dev_con_visible == false:
			get_node(dev_console).show()
			
			#Show Dev Console Text Entry.
			get_node(dev_console_text_entry).show()
			
			#Start Timer To Make Entry Panel Partially Transparent, After Displaying Info.
			get_node(info_label_timer).start(3)
		
		#Toggle Enviroment Editor Visibility Event.
	if event.is_action_pressed("toggle_enviroment_editor"):
		var env_edit_visib
		
		#Check Developer Console Visibility.
		dev_con_visible = get_node(dev_console).is_visible()
		
		#Dev Panel Visible.
		if dev_con_visible == true:
			env_edit_visib = get_node("Visibility_Control_Enviroment_Editor")
			#Switch Visibility State Of Enviroment Editor. While Dev Panel Visible.
			env_edit_visib.visible = !env_edit_visib.visible

		
		pass





#Timeout Events.
func _On_Dev_Console_Info_Label_Handler_Timer_Timeout():
	#Stop The Info Label Timer.
	get_node(info_label_timer).stop()
	
	
	
	#get_node(dev_console_text_entry).modulate = Color(44,44,44,175)
	pass 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass 



