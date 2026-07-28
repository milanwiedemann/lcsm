# Select cases based on minimum number of available session scores on two longitudinal measures

Select cases based on minimum number of available session scores on two
longitudinal measures

## Usage

``` r
select_bi_cases(data, id_var, var_list_x, var_list_y, min_count_x, min_count_y)
```

## Arguments

- data:

  A data frame in "wide" format, i.e. one column for each measurement
  point and one row for each observation.

- id_var:

  String, specifying id variable.

- var_list_x:

  Vector, specifying variable names of construct X in sequential order.

- var_list_y:

  Vector, specifying variable names of construct Y in sequential order.

- min_count_x:

  Numeric, specifying minimum number of available scores for construct
  X.

- min_count_y:

  Numeric, specifying minimum number of available scores for construct
  Y.

## Value

tibble

## Examples

``` r
select_bi_cases(data_bi_lcsm,
  id_var = "id",
  var_list_x = names(data_bi_lcsm)[2:11],
  var_list_y = names(data_bi_lcsm)[12:21],
  min_count_x = 7,
  min_count_y = 7
)
#> # A tibble: 493 × 21
#>       id    x1    x2    x3    x4    x5    x6    x7    x8    x9   x10    y1    y2
#>    <int> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#>  1     1  21.1  21.4  20.5  19.4  18.4 17.1  NA    13.7  14.1  12.1   6.23  4.93
#>  2     2  20.8  20.3  19.7  18.1  17.1 16.6  14.2  12.8  12.8  11.4   4.86  4.24
#>  3     3  20.5  19.1  16.5  15.5  13.7 11.1   9.65  7.80  7.37  4.61  4.99  4.14
#>  4     4  21.7  21.3  19.1  18.8  18.0 17.9  16.0  15.3  14.5  12.7   4.71  4.76
#>  5     5  20.3  19.0  16.9  13.9  12.6 10.3   8.27  6.36 NA     2.56  3.87  4.33
#>  6     6  22.0  20.9  19.2  17.8  17.3 15.6  NA    14.0  13.5  12.9   4.53  2.83
#>  7     7  21.8  18.9  NA    16.3  13.8 12.5  11.4   8.41  7.16  5.59  5.67  4.33
#>  8     8  21.8  19.6  19.2  17.1  15.7 14.7  13.1  12.1  11.4  10.5   4.76  4.41
#>  9     9  22.4  19.2  16.6  14.9  NA    9.98  8.14  7.37  4.68  3.66  5.76  4.58
#> 10    10  21.6  19.2  18.7  NA    13.7 12.6   9.61  7.81 NA     5.75 NA     3.97
#> # ℹ 483 more rows
#> # ℹ 8 more variables: y3 <dbl>, y4 <dbl>, y5 <dbl>, y6 <dbl>, y7 <dbl>,
#> #   y8 <dbl>, y9 <dbl>, y10 <dbl>
```
