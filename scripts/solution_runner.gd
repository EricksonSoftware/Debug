extends Node

func run_javascript_web(problem_id : String, solution_code : String) -> void:
	EventBus.code_problem_output_clear.emit.call_deferred()
	EventBus.code_problem_output_append.emit.call_deferred("> Executing JavaScript in browser...\n")
	var common_file_name : String = "code/common.js"
	var test_file_name : String = "code/%s.js" % [problem_id]
	
	var common_file : String = UserFiles.get_resource_file_contents(common_file_name)
	var test_file : String = UserFiles.get_resource_file_contents(test_file_name)
	
	var combined_files : String = "\n".join([solution_code, common_file, test_file])
	var wrapper_code : String = "(() => {%s})()" % [combined_files]
	#print(wrapper_code)
	
	var result = JavaScriptBridge.eval(wrapper_code)
	print(result)
	var output : String = "%s" % result
	var passed_tests : bool = output.contains(" 0 exceptions")
	
	if passed_tests:
		EventBus.code_problem_output_append.emit.call_deferred(output)
	else:
		EventBus.code_problem_error_append.emit.call_deferred(output)

	EventBus.code_problem_complete.emit.call_deferred(passed_tests)
