extends Node

func get_resource_file_contents(file_name : String) -> String:
	var content : String = ""
	var file : FileAccess = FileAccess.open("res://" + file_name, FileAccess.READ)
	if file:
		print("Reading file: %s" % [file_name])
		content = file.get_as_text()
		#print(content)
		file.close()
	else:
		push_error("Unable to open %s." % [file_name])
	return content
