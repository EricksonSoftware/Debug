var solution = new Solution();

class Test extends BaseTest {
	runTests() {
		for (var i = 1; i <= 1000; i++) {
			this.assertEqual(solution.blackBox(i), Math.floor(Math.PI * i), "n=" + i);
		}
	}
}

var test = new Test();
test.runTestsWrapper();
return test.getReport();
