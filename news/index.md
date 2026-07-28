# Changelog

## lcsm 0.3.3

- Fixed a bug where
  [`sim_uni_lcsm()`](https://milanwiedemann.github.io/lcsm/reference/sim_uni_lcsm.md)
  and
  [`sim_bi_lcsm()`](https://milanwiedemann.github.io/lcsm/reference/sim_bi_lcsm.md)
  gave different simulated numbers depending on which version of lavaan
  was installed. Thanks to Yves Rosseel for reporting this and
  suggesting the fix.

## lcsm 0.1.2

CRAN release: 2020-07-24

- Minor changes to address new variable names from broom package
- Temporary fix for lavInspect error from broom, this has been fixed in
  <https://github.com/tidymodels/broom/commit/5f584190cc2e6b061b98c9930baaa6c4e6409106/>

## lcsm 0.1.1

CRAN release: 2020-06-05

- Added a `NEWS.md` file to track changes to the package.
- Submission to CRAN
