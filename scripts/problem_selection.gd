class_name ProblemSelection
extends PanelContainer

var problem_button_scene : PackedScene = preload("res://scenes/problem_button.tscn")

@onready var grid_container: GridContainer = %GridContainer
@onready var back_button: Button = %BackButton

func _ready() -> void:
	back_button.pressed.connect(on_back)
	
	for problem_id in GameData.problems:
		var instance : ProblemButton = problem_button_scene.instantiate()
		instance.problem_id = problem_id
		grid_container.add_child(instance)

func on_back() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")
