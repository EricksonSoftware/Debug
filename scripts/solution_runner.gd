extends Node

func run_javascript_web(problem_id : String, solution_code : String) -> void:
	EventBus.code_problem_output_clear.emit.call_deferred()
	EventBus.code_problem_output_append.emit.call_deferred("> Executing JavaScript in browser...\n")
	var common_file_name : String = "code/javascript/_common/common.js"
	var test_file_name : String = "code/javascript/%s/test.js" % [problem_id]
	
	var common_file : String = UserFiles.get_resource_file_contents(common_file_name)
	var test_file : String = UserFiles.get_resource_file_contents(test_file_name)
	
	var combined_files : String = "\n".join([common_file, solution_code, test_file])
	combined_files = combined_files.replace("export", "")
	
	var result = JavaScriptBridge.eval(combined_files)
	var output : String = "%s" % result
	var passed_tests : bool = output.contains(" 0 exceptions")
	
	if passed_tests:
		EventBus.test_results.emit.call_deferred(true)
		EventBus.code_problem_output_append.emit.call_deferred(output)
	else:
		EventBus.test_results.emit.call_deferred(false)
		EventBus.code_problem_error_append.emit.call_deferred(output)

	EventBus.code_problem_complete.emit.call_deferred()
