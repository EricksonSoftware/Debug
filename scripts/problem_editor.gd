class_name ProblemEditor
extends PanelContainer

@export var problem_id : String = "sumArray"

@onready var editor_container: VBoxContainer = %EditorContainer
@onready var problem_title: Label = %ProblemTitle
@onready var reset_code_button: Button = %ResetCodeButton
@onready var run_code_button: Button = %RunCodeButton
@onready var output: RichTextLabel = %Output
@onready var back_button: Button = %BackButton

var problem : Problem

func _ready() -> void:
	EventBus.code_problem_output_append.connect(on_output_append)
	EventBus.code_problem_error_append.connect(on_error_append)
	EventBus.code_problem_complete.connect(on_complete)
	EventBus.code_problem_output_clear.connect(on_clear)
	reset_code_button.pressed.connect(load_problem)
	run_code_button.pressed.connect(run_code)
	back_button.pressed.connect(on_back)
	
	problem_id = GameData.current_problem
	problem = GameData.problems[problem_id]
	load_problem()

func load_problem() -> void:
	problem_title.text = problem.title
	
	for child in editor_container.get_children():
		editor_container.remove_child(child)
		child.queue_free()
	
	for i in range(len(problem.lines)):
		var line : String = problem.lines[i]
		var instance : JavaScriptCodeEditor = ResourceLoader.load("res://scenes/javascript_code_editor.tscn", "", ResourceLoader.CACHE_MODE_IGNORE).instantiate()
		instance.text = line
		instance.editable = i in problem.editable
		editor_container.add_child(instance)

func run_code() -> void:
	var solution_code : String = ""
	for child in editor_container.get_children():
		if child is JavaScriptCodeEditor:
			var editor : JavaScriptCodeEditor = child as JavaScriptCodeEditor
			solution_code += editor.text + "\n"
	var thread : Thread = Thread.new()
	thread.start(SolutionRunner.run_javascript_web.bind(problem_id, solution_code))

func on_output_append(message : String) -> void:
	output.text += message + "\n"

func on_error_append(message : String) -> void:
	output.text += "[color=red]%s[/color]\n" % [message]

func on_complete(success : bool) -> void:
	print(success)
	if success:
		SaveData.set_problem_completed(problem_id)
		on_back()

func on_clear() -> void:
	output.text = ""

func on_back() -> void:
	get_tree().change_scene_to_file("res://scenes/problem_selection.tscn")
