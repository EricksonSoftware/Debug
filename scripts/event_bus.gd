extends Node

signal code_problem_output_clear()
signal code_problem_output_append(message : String)
signal code_problem_error_append(message : String)
signal test_results(success : bool)
signal code_problem_complete()
