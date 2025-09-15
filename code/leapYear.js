var solution = new Solution();

class Test extends BaseTest {
	runTests() {
		this.assertEqual(solution.isLeapYear(2000), true, "2000");
		this.assertEqual(solution.isLeapYear(2004), true, "2004");
		this.assertEqual(solution.isLeapYear(1900), false, "1900");
		this.assertEqual(solution.isLeapYear(1959), false, "1959");
		this.assertEqual(solution.isLeapYear(3001), false, "3001");
	}
}

var test = new Test();
test.runTestsWrapper();
return test.getReport();
