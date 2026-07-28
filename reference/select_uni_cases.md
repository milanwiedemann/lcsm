# Select cases based on minimum number of available session scores on one longitudinal measure

Select cases based on minimum number of available session scores on one
longitudinal measure

## Usage

``` r
select_uni_cases(data, id_var, var_list, min_count, return_id_only = FALSE)
```

## Arguments

- data:

  Dataset in wide format.

- id_var:

  String, specifying id variable.

- var_list:

  Vector, specifying variable names in sequential order.

- min_count:

  Numeric, specifying minimum number of available scores

- return_id_only:

  Logical, if TRUE only return ID. This is needed for select_bi_cases

## Value

tibble

## Examples

``` r
select_uni_cases(data_uni_lcsm,
  id_var = "id",
  var_list = names(data_uni_lcsm)[-1],
  min_count = 7
)
#> # A tibble: 335 × 11
#>       id    x1    x2    x3    x4    x5    x6    x7    x8    x9   x10
#>    <int> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#>  1     1  17.9  NA    16.2  14.7  13.7  12.7  10.6  10.7  8.48 NA   
#>  2     3  21.9  20.1  NA    18.6  18.3  16.6  15.9  15.0 13.5  12.5 
#>  3     4  22.1  21.3  NA    NA    19.3  19.2  18.4  17.9 17.9  17.0 
#>  4     9  NA    21.2  21.7  19.8  NA    NA    17.9  17.7 16.2  15.0 
#>  5    10  19.3  NA    18.0  NA    14.9  13.8  12.7  NA   10.6   8.78
#>  6    11  20.3  19.1  18.3  NA    17.3  15.6  14.6  14.2 13.0  12.5 
#>  7    12  21.7  NA    22.3  21.7  21.7  21.8  22.0  21.5 NA    21.5 
#>  8    13  20.9  20.3  19.7  NA    18.0  16.2  NA    NA   13.3  12.0 
#>  9    14  19.9  19.2  18.3  NA    15.7  NA    13.7  12.5 11.7  NA   
#> 10    15  NA    20.9  18.5  18.7  17.0  15.3  14.2  14.3 12.8  12.1 
#> # ℹ 325 more rows
```
