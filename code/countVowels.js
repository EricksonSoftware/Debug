var solution = new Solution();

class Test extends BaseTest {
	runTests() {
		this.assertEqual(solution.countVowels("apple"), 2, "apple");
		this.assertEqual(solution.countVowels("Apple"), 2, "Apple");
		this.assertEqual(solution.countVowels("vowels"), 2, "vowels");
		this.assertEqual(solution.countVowels("nth"), 0, "nth");
		this.assertEqual(solution.countVowels("QUESTIONABLE"), 6, "QUESTIONABLE");
	}
}

var test = new Test();
test.runTestsWrapper();
return test.getReport();
