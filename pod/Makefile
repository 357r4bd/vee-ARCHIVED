all: vee veels veecat vee-reindex veerc vee-hooks

vee:
	mkdir -p ../man > /dev/null 2>&1
	pod2man vee.1.pod > ../man/vee.1

veefind:
	pod2man veefind.1.pod > ../man/veefind.1

veels:
	pod2man veels.1.pod > ../man/veels.1

veecat:
	pod2man veecat.1.pod > ../man/veecat.1

vee-reindex:
	pod2man vee-reindex.1.pod > ../man/vee-reindex.1

vee-hooks:
	pod2man vee-reindex.1.pod > ../man/vee-reindex.1

veerc:
	pod2man veerc.5.pod > ../man/veerc.5

clean:
	rm *.1  > /dev/null
	rm *.5  > /dev/null
