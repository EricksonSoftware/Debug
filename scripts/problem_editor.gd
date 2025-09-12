class_name ProblemEditor
extends PanelContainer

@export var problem_id : String = "sumArray2"

@onready var editor_container: VBoxContainer = %EditorContainer
@onready var problem_title: Label = %ProblemTitle
@onready var reset_code_button: Button = %ResetCodeButton
@onready var run_code_button: Button = %RunCodeButton


var problem : Problem

func _ready() -> void:
	reset_code_button.pressed.connect(load_problem)
	run_code_button.pressed.connect(run_code)
	
	problem = GameData.problems[problem_id]
	load_problem()

func load_problem() -> void:
	problem_title.text = problem.id
	
	for child in editor_container.get_children():
		editor_container.remove_child(child)
		child.queue_free()
	
	for i in range(len(problem.lines)):
		var line : String = problem.lines[i]
		var instance : JavaScriptCodeEditor = ResourceLoader.load("res://scenes/javascript_code_editor.tscn", "", ResourceLoader.CACHE_MODE_IGNORE).instantiate()
		instance.text = line
		instance.editable = i in problem.editable
		if instance.editable:
			
			instance.set_caret_column.call_deferred(99)
		editor_container.add_child(instance)

func run_code() -> void:
	pass
