var solution = new Solution();

class Test extends BaseTest {
	runTests() {
		this.assertEqual(solution.listLength(Util.arrayToList([])), 0, "[]");
		this.assertEqual(solution.listLength(Util.arrayToList([1])), 1, "1]");
		this.assertEqual(solution.listLength(Util.arrayToList([1, 3, 5, 7])), 4, "[1,3,5,7]");
	}
}

var test = new Test();
test.runTestsWrapper();
return test.getReport();
