var solution = new Solution();

class Test extends BaseTest {
	runTests() {
		this.assertEqual(solution.findRange([1]), 0, "[1]");
		this.assertEqual(solution.findRange([1, 2, 3, 4]), 3, "[1,2,3,4]");
		this.assertEqual(solution.findRange([1, 2, 3, 4, -10]), 14, "[1,2,3,4,-10]");
	}
}

var test = new Test();
test.runTestsWrapper();
return test.getReport();
