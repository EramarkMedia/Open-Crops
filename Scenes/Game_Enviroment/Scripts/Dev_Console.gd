extends Node



func _ready():
	pass

#Get console list.
onready var console_list = get_node("Console_List")

#Dev console content.

#Dev console location category.
#Key "header" will be highlighted with orange ish color.
#Also after this follows a blank space, in item list.
var location = {"header":"Location", "value1":"X_Internal_Position:", "value2": "Y_Internal_Positon:", "value3":"Z_Internal_Position:", "value4":"WGS84_Postion:"}



func populate_dev_console():
	var value
	var items = 0
	var loops = 0
	
	for key in location:
		if key == "header":
			value = location.get(key)
			console_list.add_item(value,null,false)
			console_list.set_item_custom_bg_color(items, Color( 0.73, 0.53, 0, 1 ))
			items = items + 1
			#Add a blank spacer, after all headers "for separation".
			console_list.add_item(" ",null,false)
			#print(value)
		elif key !="header": 
			value = location.get(key)
			console_list.add_item(value,null,false)
			items = items + 1
			print(key)
	items = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
