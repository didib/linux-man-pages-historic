# Do "make install" to copy the pages to their destination.
# Do "make gz" before "make install" if you use compressed source pages.
# We now unconditionally do "make remove".

MANDIR=/usr/man

# make this "gzip -9" to squeeze out the last byte
GZIP=gzip

example: remove gz install

remove:
	for i in man?; do for j in $$i/*; do \
		rm -f $(MANDIR)/$$i/$$j $(MANDIR)/$$i/$$j.gz; done; done
	touch remove

gz: remove
	for i in man?; do $(GZIP) $$i/*; done

install: remove
	for i in man?; do \
		install -d -m 755 $(MANDIR)/$$i; \
		install -m 644 $$i/* $(MANDIR)/$$i; \
	done
# remove pages from man2 that are now in man3
	for j in cfgetispeed cfgetospeed cfsetispeed cfsetospeed \
		tcdrain tcflow tcflush tcgetattr tcgetpgrp \
		tcsendbreak tcsetattr tcsetpgrp termios ;\
	do rm -f $(MANDIR)/man2/$$j.2 $(MANDIR)/man2/$$j.2.gz \
		$(MANDIR)/cat2/$$j.2 $(MANDIR)/cat2/$$j.2.gz; done
# someone might also want to look at /var/catman/cat2 or so ...
