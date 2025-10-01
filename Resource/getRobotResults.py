from robot.api import ExecutionResult, ResultVisitor

class MyResultVisitor(ResultVisitor):
    def __init__(self, markdown_file='report.md'):
        self.failed_tests = []
        self.passed_tests = []
        self.markdown_file = markdown_file

    def visit_test(self, test):
        if test.status == 'FAIL':
            self.failed_tests.append(test.name)
        elif test.status == 'PASS':
            self.passed_tests.append(test.name)

    def end_result(self, result):
        with open(self.markdown_file, "w") as f:
            f.write("# Robot Framework Report\n")
            f.write("|Test|Status|\n")
            f.write("|---|---|\n")
            for test in self.passed_tests:
                f.write(f"|{test}|PASS|\n")
            for test in self.failed_tests:
                f.write(f"|{test}|FAIL|\n")

result = ExecutionResult('Y:/RobotResults/Results_sprints-PREDEV/06-03-2025-02-36-55/output.xml')
result.visit(MyResultVisitor())