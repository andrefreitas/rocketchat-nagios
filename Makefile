.PHONY: test-unknown test-ok test-critical test-warning

URL=$(shell cat url.txt)

test-unknown:
	./rocketchat.py \
	--url $(URL) \
	--hostalias alfredo \
	--notificationtype RECOVERY \
	--servicestate UNKNOWN \
	--serviceoutput "PING 100% LOSS" \
	--servicedesc counter

test-ok:
	./rocketchat.py \
	--url $(URL) \
	--hostalias alfredo \
	--notificationtype RECOVERY \
	--servicestate OK \
	--serviceoutput "PING 100% LOSS" \
	--servicedesc counter

test-critical:
	./rocketchat.py \
	--url $(URL) \
	--hostalias alfredo \
	--notificationtype RECOVERY \
	--servicestate CRITICAL \
	--serviceoutput "PING 100% LOSS" \
	--servicedesc counter

test-warning:
	./rocketchat.py \
	--url $(URL) \
	--hostalias alfredo \
	--notificationtype RECOVERY \
	--servicestate WARNING \
	--serviceoutput "PING 100% LOSS" \
	--servicedesc counter
