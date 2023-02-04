df <- tibble::tribble(
  ~id, ~bdi1, ~bdi2, ~bdi3, ~bdi4, ~bdi5, ~something_else1, ~something_else2, ~something_else3, ~something_else4, ~something_else5,
  1, 10, 10, 10, 10, 10, 10, 10, 10, NA, NA,
)

test_that("Renaming variables works", {
  df_test_rename_x <- rename_lcsm_vars(df, var_x = paste0("bdi", 1:5), var_y = NULL)
  df_test_rename_y <- rename_lcsm_vars(df, var_x = NULL, var_y = paste0("something_else", 1:5))
  df_test_rename_xy <- rename_lcsm_vars(df, var_x = paste0("bdi", 1:5), var_y = paste0("something_else", 1:5))

  expect_equal(nrow(df_test_rename_x), 1)
  expect_equal(nrow(df_test_rename_y), 1)
  expect_equal(nrow(df_test_rename_xy), 1)

  expect_equal(names(df_test_rename_x), c("id", paste0("x", 1:5), paste0("something_else", 1:5)))
  expect_equal(names(df_test_rename_y), c("id", paste0("bdi", 1:5), paste0("y", 1:5)))
  expect_equal(names(df_test_rename_xy), c("id", paste0("x", 1:5), paste0("y", 1:5)))
})
