.DEFAULT_GOAL: requirements

.PHONY: requirements

requirements:
	curl https://apertium.projectjj.com/apt/install-nightly.sh | sudo bash
	sudo apt-get install hfst lexd

task.generator.hfst: task.lexd
	lexd task.lexd | hfst-txt2fst -o task.generator.hfst

task.analyzer.hfst: task.generator.hfst
	hfst-invert task.generator.hfst -o task.analyzer.hfst

for_test_%.txt:
	curl https://raw.githubusercontent.com/agricolamz/2025_morphological_transducers/refs/heads/main/task_tests/$@ -o $@

test_%: for_test_%.txt task.generator.hfst
	@$(eval EXPECTED=`cat $< | wc -l`)
	@$(eval OBSERVED=`hfst-fst2strings task.generator.hfst | grep -cf $<`)
	@if [ "$(EXPECTED)" = "$(OBSERVED)" ]; then\
  	echo "\e[32mAll tests pass\e[0m";\
	else\
		echo "\e[31mSome tests are NOT passing\e[0m";\
	fi
	@rm -f *.hfst
