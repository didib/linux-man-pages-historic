# Do "make install" to copy the pages to their destination.
# Do "make gz" before "make install" if you use compressed source pages.

MANDIR=/usr/man

GZIP=gzip -9

all: remove gz install

remove:
	for i in man?; do for j in $$i/*; do \
		rm -f $(MANDIR)/$$j $(MANDIR)/$$j.gz; done; done

gz:
	for i in man?; do $(GZIP) $$i/*; done

install:
	for i in man?; do \
		install -d -m 755 $(MANDIR)/$$i; \
		install -m 644 $$i/* $(MANDIR)/$$i; \
	done
# someone might also want to look at /var/catman/cat2 or so ...
# a problem is that the location of cat pages varies a lot
