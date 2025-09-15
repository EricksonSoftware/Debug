var solution = new Solution();

class Test extends BaseTest {
	runTests() {
		this.assertEqual(solution.sumArray([]), 0, "[]");
		this.assertEqual(solution.sumArray([1, 2, 3, 4]), 10, "[1,2,3,4]");
		this.assertEqual(solution.sumArray([1, 2, 3, 4, -10]), 0, "[1,2,3,4,-10]");
	}
}

var test = new Test();
test.runTestsWrapper();
return test.getReport();
