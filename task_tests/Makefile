.DEFAULT_GOAL: requirements

.PHONY: requirements forms

requirements:
	curl https://apertium.projectjj.com/apt/install-nightly.sh | sudo bash
	sudo apt-get install hfst lexd

task.generator.hfst: task.lexd
	@lexd task.lexd | hfst-txt2fst -o lexd.hfst
	@if test -f "task.twol"; then\
  	@hfst-twolc task.twol -o twol.hfst;\
  	@hfst-compose-intersect lexd.hfst twol.hfst -o $@;\
  else\
  	mv lexd.hfst $@;\
	fi

task.analyzer.hfst: task.generator.hfst
	@hfst-invert $^ -o $@

analysis: task.analyzer.hfst
	@echo "$(FORM)" | hfst-lookup $^
	@rm -f *.hfst

generaton: task.generator.hfst
	@echo "$(FORM)" | hfst-lookup $^
	@rm -f *.hfst

for_test_%.txt:
	curl https://raw.githubusercontent.com/agricolamz/2025_morphological_transducers/refs/heads/main/task_tests/$@ -o $@

forms: task.generator.hfst
	@hfst-fst2strings $^
	@rm -f *.hfst

test_%: for_test_%.txt task.generator.hfst
	@$(eval EXPECTED=`cat $< | wc -l`)
	@$(eval OBSERVED=`hfst-fst2strings task.generator.hfst | grep -cf $<`)
	@if [ "$(EXPECTED)" = "$(OBSERVED)" ]; then\
  	echo "\e[32mAll tests for the task have passed.\e[0m";\
	else\
		echo "\e[31mIt looks like your lexd/twol files failed one of the tests.\e[0m";\
	fi
	@rm -f *.hfst
