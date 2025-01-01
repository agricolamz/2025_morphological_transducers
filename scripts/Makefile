.DEFAULT_GOAL: requirements

.PHONY: requirements

requirements:
	curl https://apertium.projectjj.com/apt/install-nightly.sh | sudo bash
	sudo apt-get install lexd hfst
	curl https://raw.githubusercontent.com/agricolamz/2025_morphological_transducers/refs/heads/main/scripts/compare.sh -o compare.sh

task.generator.hfst: task.lexd
	lexd task.lexd | hfst-txt2fst -o task.generator.hfst

task.analyzer.hfst: task.generator.hfst
	hfst-invert task.generator.hfst -o task.analyzer.hfst

for_test_%.txt:
	curl https://raw.githubusercontent.com/agricolamz/2025_morphological_transducers/refs/heads/main/task_tests/$@ -o $@

test_%: task.generator.hfst for_test_%.txt
	bash compare.sh $^
	rm for_test_*