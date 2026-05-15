test_that("calcREMINDdrivers via GDX returns 7 drivers", {
  gdxPath <- file.path(
    "C:/Users/renatoro/Desktop/Projects/Elevate/code/mrPEM",
    ".data/REMINDdrivers/fulldata.gdx"
  )
  skip_if_not(file.exists(gdxPath), message = "REMIND GDX file not available")

  # calcREMINDdrivers uses getSourceFolder() which needs madrat >= 3.x
  skip_if_not(
    exists("getSourceFolder", where = "package:madrat", mode = "function"),
    message = "getSourceFolder not exported from this madrat version"
  )

  mr_local_env()
  suppressMessages(suppressWarnings(
    madrat::setConfig(
      sourcefolder = file.path(
        "C:/Users/renatoro/Desktop/Projects/Elevate/code/mrPEM", ".data"
      )
    )
  ))
  result <- calcOutput("REMINDdrivers", aggregate = FALSE)
  expect_s4_class(result, "magpie")
  expect_equal(ndata(result), 7L)
  expected_vars <- c(
    "Coal primary energy share",
    "Oil/Gas primary energy share",
    "VRE share",
    "Electrification",
    "GDP per capita"
  )
  expect_true(all(expected_vars %in% getNames(result)))
})
