extends WindowDialog
var filepath
var maps_dir = "res://Assets/Maps/"

var window_header 
var header_label 
var footer_label 
var user_action 


#const Date = preload("res://Main_Menu.gd")

func check_maps_dir(filepath):
	var check_dir = Directory.new().dir_exists(maps_dir)
	if !check_dir:
		window_header = "Warning"
		header_label = "Maps Folder Missing"
		footer_label = "Create Folder?"
		user_action = "Select"
		get_parent().show() 
		get_parent().display_user_prompt_window(window_header,header_label,footer_label,user_action)
		print("Maps Directory Not Present")
	else: print("Maps Present")


func _ready():
	check_maps_dir(filepath)
