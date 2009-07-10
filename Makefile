.PHONEY: clean test check build install

install: clean
	R CMD INSTALL --no-multiarch pkg

test: install
	Rscript pkg/inst/unittests/runner.r

check: clean
	R CMD check pkg && rm -fR pkg.Rcheck

clean:
	rm -fR pkg/src/*.o pkg/src/*.so pkg.Rcheck .RData .Rhistory

pkg: clean
	echo "Date: $(date +%Y-%m-%d)" >> pkg/DESCRIPTION
	R CMD build pkg
	R CMD build --binary pkg
	git checkout pkg/DESCRIPTION
