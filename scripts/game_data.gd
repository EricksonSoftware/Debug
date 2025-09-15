extends Node

var problems : Dictionary[String, Problem] = {}

func _ready() -> void:
	load_config()

func load_config() -> void:
	var file : FileAccess = FileAccess.open("res://config.json", FileAccess.READ)
	if not file:
		push_error("Could not open config.json")
		return
	
	var data : String = file.get_as_text()
	var json = JSON.parse_string(data) as Dictionary
	if "problems" not in json:
		push_error("config.json does not contain a 'problems' field")
		return
	
	problems = {}
	var index : int = 0
	for problem_data in json.problems:
		if "id" not in problem_data or "lines" not in problem_data or "editable" not in problem_data or "title" not in problem_data:
			continue
		var problem : Problem = Problem.new()
		problem.id = problem_data["id"]
		problem.title = problem_data["title"]
		problem.lines = to_string_array(problem_data["lines"])
		problem.editable = to_int_array(problem_data["editable"])
		problem.index = index
		index += 1
		problems[problem.id] = problem

func to_string_array(original : Array) -> Array[String]:
	var ret : Array[String] = []
	for val in original:
		ret.append(str(val))
	return ret

func to_int_array(original : Array) -> Array[int]:
	var ret : Array[int] = []
	for val in original:
		ret.append(floori(val))
	return ret
