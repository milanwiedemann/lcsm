# Test environments
## local
* macOS 15.7.7
* R version 4.6.1 (2026-06-24)

## R CMD check results
0 errors | 0 warnings | 1 note

* checking CRAN incoming feasibility ... NOTE
  Found the following (possibly) invalid DOIs:
    DOI: 10.1080/10705511.2012.713275
  This DOI is valid and resolves correctly (https://doi.org/10.1080/10705511.2012.713275).

## Reverse dependencies
There are no reverse dependencies.

## Resubmission
This is a resubmission to fix an issue #30 holding up a release of the lavaan R package:
lavaan >= 0.7-1 changed how it generates random data internally, which caused
sim_uni_lcsm() and sim_bi_lcsm() to produce different simulated values depending on which
lavaan version was installed. This release passes mass = TRUE to lavaan::simulateData()
when lavaan >= 0.7-1 is installed, so results stay the same across lavaan versions.

