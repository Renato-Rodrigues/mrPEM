test_that("calcREMINDHistoricalDrivers via cache returns 7 historical drivers", {
  cachePath <- "C:/Users/renatoro/Desktop/Input Data/remind_inputdata/cache/default/calcREMINDHistoricalDrivers.rds"
  skip_if_not(file.exists(cachePath), message = "REMINDHistoricalDrivers cache not available")

  mainFolder <- "C:/Users/renatoro/Desktop/Input Data/remind_inputdata"
  cacheFolder <- file.path(mainFolder, "cache/default")
  mr_local_env()
  suppressMessages(suppressWarnings(
    madrat::setConfig(
      sourcefolder = file.path(mainFolder, "sources"),
      mainfolder   = mainFolder,
      cachefolder  = cacheFolder,
      forcecache   = TRUE
    )
  ))
  result <- calcOutput("REMINDHistoricalDrivers", aggregate = FALSE)
  expect_s4_class(result, "magpie")
  expect_equal(ndata(result), 7L)
  expected_vars <- c(
    "Coal primary energy share",
    "Oil/Gas primary energy share",
    "Value added from Fossil Industry",
    "VRE share",
    "Electrification",
    "GDP per capita",
    "Energy Intensity"
  )
  expect_true(all(expected_vars %in% getNames(result)))
  # No completely NA variables
  for (v in expected_vars) {
    expect_false(all(is.na(result[, , v])),
      label = paste("Variable", v, "should have at least one non-NA value")
    )
  }
})

test_that("calcREMINDHistoricalDrivers set names (iso3c / year / variable)", {
  cachePath <- "C:/Users/renatoro/Desktop/Input Data/remind_inputdata/cache/default/calcREMINDHistoricalDrivers.rds"
  skip_if_not(file.exists(cachePath), message = "REMINDHistoricalDrivers cache not available")

  mainFolder <- "C:/Users/renatoro/Desktop/Input Data/remind_inputdata"
  cacheFolder <- file.path(mainFolder, "cache/default")
  mr_local_env()
  suppressMessages(suppressWarnings(
    madrat::setConfig(
      sourcefolder = file.path(mainFolder, "sources"),
      mainfolder   = mainFolder,
      cachefolder  = cacheFolder,
      forcecache   = TRUE
    )
  ))
  result <- calcOutput("REMINDHistoricalDrivers", aggregate = FALSE)
  sets <- getSets(result)
  # getSets returns a named character vector; values are the set labels
  expect_equal(unname(sets[1]), "iso3c")
  expect_equal(unname(sets[2]), "year")
  expect_equal(unname(sets[3]), "variable")
})
