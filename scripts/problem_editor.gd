class_name ProblemEditor
extends VBoxContainer

@export var problem_id : String = "sumArray"
@onready var editor_container: VBoxContainer = %EditorContainer

var problem : Problem

func _ready() -> void:
	problem = GameData.problems[problem_id]
	load_problem()

func load_problem() -> void:
	for i in range(len(problem.lines)):
		var line : String = problem.lines[i]
		var instance : JavaScriptCodeEditor = ResourceLoader.load("res://scenes/javascript_code_editor.tscn", "", ResourceLoader.CACHE_MODE_IGNORE).instantiate()
		instance.text = line
		instance.editable = i in problem.editable
		if instance.editable:
			
			instance.set_caret_column.call_deferred(99)
		editor_container.add_child(instance)
