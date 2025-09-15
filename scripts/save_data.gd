extends Node

const save_resource_name : String = "user://save.tres"

var save_resource : SaveDataResource = null

func _ready() -> void:
	reload()

func reload() -> void:
	save_resource = ResourceLoader.load(save_resource_name, "SaveDataResource", ResourceLoader.CACHE_MODE_IGNORE) as SaveDataResource
	if not save_resource:
		save_resource = SaveDataResource.new()
		save_to_disk()

func save_to_disk() -> void:
	var error := ResourceSaver.save(save_resource, save_resource_name)
	if error:
		push_error("save_to_disk: %s" % error)
	else:
		print("Saved to disk")

func purge_save_data() -> void:
	var new_save_resource : SaveDataResource = SaveDataResource.new()
	save_resource = new_save_resource
	save_to_disk()

func is_problem_completed(problem_id : String) -> bool:
	return save_resource.completed_problems.get(problem_id, false)

func set_problem_completed(problem_id : String)  -> void:
	if not is_problem_completed(problem_id):
		save_resource.completed_problems[problem_id] = true
		save_to_disk()
