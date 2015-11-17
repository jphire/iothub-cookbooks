function wrapper () {
	function quickSort(limit) {

		var nums = [];
		var len = limit;
		for (var i = 0; i<limit; i++) {
			nums[i] = Math.random();
		}
		var start = new Date().getTime();
		nums.sort();
		var end = new Date().getTime();
		var time = end - start;
		return time;
	};

	var times = [
		quickSort(50000),
		quickSort(100000),
		quickSort(200000),
		quickSort(300000),
		quickSort(400000),
		quickSort(500000)
	];

	return times.join('\t');
};

wrapper();
