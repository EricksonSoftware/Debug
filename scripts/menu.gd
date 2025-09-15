extends Control

@onready var play_button: Button = %PlayButton
@onready var settings_button: Button = %SettingsButton
@onready var quit_button: Button = %QuitButton

func _ready() -> void:
	play_button.pressed.connect(on_play_button)
	settings_button.pressed.connect(on_setttings_button)
	quit_button.pressed.connect(on_quit_button)

func on_play_button() -> void:
	pass
	get_tree().change_scene_to_file("res://scenes/problem_selection.tscn")

func on_setttings_button() -> void:
	pass
	#get_tree().change_scene_to_file()

func on_quit_button() -> void:
	get_tree().quit()
