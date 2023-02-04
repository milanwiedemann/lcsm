df <- tibble::tribble(
  ~id, ~x1, ~x2, ~x3, ~x4, ~x5, ~y1, ~y2, ~y3, ~y4, ~y5,
  1, 10, 10, 10, 10, 10, 10, 10, 10, NA, NA,
  2, 10, NA, 10, NA, NA, 10, 10, 10, NA, NA,
  3, 10, 10, NA, 10, 10, 10, 10, 10, 10, 10,
)



test_that("Select uni cases works return id only", {
  df_test <- select_uni_cases(df,
    id_var = "id",
    var_list = c("x1", "x2", "x3", "x4", "x5"),
    min_count = 5, return_id_only = TRUE
  )
  expect_equal(df_test$id, c(1))
})


test_that("Select uni cases works", {
  df_test <- select_uni_cases(df,
    id_var = "id",
    var_list = c("x1", "x2", "x3", "x4", "x5"),
    min_count = 3, return_id_only = FALSE
  )
  expect_equal(df_test$id, c(1, 3))
  expect_equal(names(df_test), c("id", paste0("x", 1:5)))
})

test_that("Select bi cases works", {
  df_test <- select_bi_cases(df,
                             id_var = "id",
                             var_list_x = c("x1", "x2", "x3", "x4", "x5"),
                             var_list_y = c("y1", "y2", "y3", "y4", "y5"),
                             min_count_x = 4,
                             min_count_y = 4
  )
  expect_equal(df_test$id, c(3))
  expect_equal(names(df_test), c("id", paste0("x", 1:5), paste0("y", 1:5)))
})
