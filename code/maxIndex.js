var solution = new Solution();

class Test extends BaseTest {
	runTests() {
		this.assertEqual(solution.maxIndex([]), -1, "[]");
		this.assertEqual(solution.maxIndex([1, 2, 3, 4]), 3, "[1,2,3,4]");
		this.assertEqual(solution.maxIndex([1, 21, 3, 4, -10]), 1, "[1,21,3,4,-10]");
	}
}

var test = new Test();
test.runTestsWrapper();
return test.getReport();
