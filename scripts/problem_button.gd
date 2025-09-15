class_name ProblemButton
extends MarginContainer

@export var problem_id : String = ""

@onready var title: Label = %Title
@onready var icon: TextureRect = %Icon

var has_hover : bool = false

func _ready() -> void:
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)
	
	if problem_id in GameData.problems:
		var problem : Problem = GameData.problems[problem_id]
		title.text = problem.title
		if SaveData.is_problem_completed(problem_id):
			icon.modulate = Color.DARK_GREEN

func _input(event: InputEvent) -> void:
	if has_hover and event is InputEventMouseButton:
		var button_event : InputEventMouseButton = event as InputEventMouseButton
		if button_event.pressed and button_event.button_index == 1:
			print("Selected: %s" % [problem_id])
			GameData.current_problem = problem_id
			get_tree().change_scene_to_file("res://scenes/problem_editor.tscn")

func on_mouse_entered() -> void:
	has_hover = true
	modulate = Color(1, 1, 1, 0.8)

func on_mouse_exited() -> void:
	has_hover = false
	modulate = Color(1, 1, 1, 1)
