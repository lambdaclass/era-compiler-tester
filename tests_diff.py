def open_old_results():
    return open('old_results.txt', 'r')

def open_new_results():
    return open('new_results.txt', 'r')

def parse_failed_tests(results_file):
    failed_tests = []
    for line in results_file:
        if "FAILED" in line:
            text_failed_index = line.split().index("FAILED")
            test_name = line.split()[text_failed_index + 1]
            failed_tests.append(test_name)
    
    # Skip the last line which is the summary of the tests
    failed_tests.pop()
    return failed_tests

def calculate_diff(old_failed_tests, new_failed_tests):
    diff_result_file = open('diff_results.txt', 'w')
    new_passing_tests = set(old_failed_tests) - set(new_failed_tests)
    new_failing_tests = set(new_failed_tests) - set(old_failed_tests)
    for test in new_passing_tests:
        diff_result_file.write(f"Test {test} was failing and is now passing ✅\n")

    for test in new_failing_tests:
        diff_result_file.write(f"Test {test} was passing and is now failing ❌\n")
        
if __name__ == '__main__':
    old_results_file = open_old_results()
    new_results_file = open_new_results()
    old_failed_tests = parse_failed_tests(old_results_file)
    new_failed_tests = parse_failed_tests(new_results_file)
    calculate_diff(old_failed_tests, new_failed_tests)
    old_results_file.close()
    new_results_file.close()
