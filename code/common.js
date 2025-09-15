class BaseTest {
	constructor() {
		this.fail = 0;
		this.pass = 0;
		this.exceptions = [];
	}

	runTestsWrapper() {
		try {
			this.runTests();
		} catch (error) {
			this.logError(error, "Critical ERROR while running tests.", "Fix the following issue and try again:");
		}
	}

	runTests() {
		this.assertEqual(false, true, "No tests found");
	}

	assertEqual(actual, expected, message = "") {
		try {
			if (this.isEqual(actual, expected)) {
				this.pass += 1;
			} else {
				message = this.reduceStringLength(message);
				var expectedMessage = this.reduceStringLength(JSON.stringify(expected));
				var actualMessage = this.reduceStringLength(JSON.stringify(actual));
				this.logError(null, `Test: ${message}`, `Expected: ${expectedMessage}\n   Found: ${actualMessage}`)
			}
		} catch (error) {
			this.logError(error, `Test: ${message}`);
		}
	}

	logError(error, firstMessage = "", secondMessage = "") {
		var message = "";
		if (firstMessage) {
			message += firstMessage + "\n";
		}
		if (secondMessage) {
			message += secondMessage + "\n";
		}
		if (error) {
			message += `${error}`;
		}
		this.exceptions.push(message);
		this.fail += 1;
	}

	reduceStringLength(str, maxLength = 120) {
		const n = str.length;
		if (n < maxLength) return str;
		const sideLength = Math.floor((maxLength - 8) / 2);
		return str.slice(0, sideLength) + "..." + str.slice(n - sideLength);
	}

	isEqual(actual, expected) {
		if ((actual == null && expected != null) || (expected == null && actual != null)) {
			return false;
		}
		if (actual instanceof Array && expected instanceof Array) {
			if (actual.length != expected.length) return false;
			for (var i = 0; i < actual.length; i++) {
				var isEqual = this.isEqual(actual[i], expected[i]);
				if (!isEqual) return false;
			}
		}
		return actual == expected || actual.toString() === expected.toString();
	}

	getReport() {
		const max_errors_shown = 1;
		let report = "";
		let total = this.pass + this.fail;
		report += `${this.pass}/${total} tests passed. ${this.exceptions.length} exceptions.\n`;
		for (let i = 0; i < this.exceptions.length && i < max_errors_shown; i++) {
			report += `${this.exceptions[i]}\n`;
		}
		return report;
	}
}

class TreeNode {
	constructor(value, left, right) {
		this.value = value ?? 0;
		this.left = left ?? null;
		this.right = right ?? null;
	}
}

class ListNode {
	constructor(value, next) {
		this.value = value ?? 0;
		this.next = next ?? null;
	}
}

class Util {
	/**
	 * @param {ListNode} node 
	 * @returns {number[]}
	 */
	static listToArray(node) {
		var arr = [];
		while (node) {
			arr.push(node.value);
			node = node.next;
		}
		return arr;
	}

	/**
	 * @param {number[]} arr
	 * @returns {ListNode}
	 */
	static arrayToList(arr) {
		if (!arr || arr.length == 0) return null;
		var head = new ListNode(arr[0]);
		var node = head;
		for (var i = 1; i < arr.length; i++) {
			node.next = new ListNode(arr[i]);
			node = node.next;
		}
		return head;
	}

	static areTreesEqual(tree1, tree2) {
		if (tree1 == null && tree2 == null) return true;
		if (tree1 == null) return false;
		if (tree2 == null) return false;
		if (tree1.value != tree2.value) return false;
		return Util.areTreesEqual(tree1.left, tree2.left) && Util.areTreesEqual(tree1.right, tree2.right);
	}
}
