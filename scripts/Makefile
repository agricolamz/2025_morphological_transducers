.DEFAULT_GOAL: requirements

.PHONY: requirements

requirements:
	curl https://apertium.projectjj.com/apt/install-nightly.sh | sudo bash
	sudo apt-get install lexd
	curl https://raw.githubusercontent.com/agricolamz/2025_morphological_transducers/refs/heads/main/scripts/compare.sh
task.generator.hfst: task.lexd
	lexd task.lexd | hfst-txt2fst -o task.generator.hfst
task.analyzer.hfst: task.generator.hfst
	hfst-invert task.generator.hfst -o task.analyzer.hfst
for_test_%.csv:
	curl https://raw.githubusercontent.com/agricolamz/2025_morphological_transducers/refs/heads/main/task_tests/$@
test_%: task.generator.hfst for_test_%.csv
	bash compare.sh $< test.pass.txt