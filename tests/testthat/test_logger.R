context("periscope - logger.R")

test_that("namedLevel", {
    level_out <- periscope:::namedLevel("NOTSET")
    expect_equal(level_out, c(NOTSET = 0))
    expect_equal(names(level_out), "NOTSET")
})

test_that("namedLevel.default", {
    level_out <- periscope:::namedLevel.default("NOTSET")
    expect_equal(level_out, c(NOTSET = 0))
    expect_equal(names(level_out), "NOTSET")
})

test_that("namedLevel.character", {
    level_out <- periscope:::namedLevel.character("FINE")
    expect_equal(level_out, c(FINE = 7))
    expect_equal(names(level_out), "FINE")
    
    level_out <- periscope:::namedLevel.character("XYZ")
    expect_equal(level_out, c(NOTSET = 0))
    expect_equal(names(level_out), "NOTSET")
})

test_that("namedLevel.numeric", {
    level_out <- periscope:::namedLevel.numeric(30)
    expect_equal(level_out, c(WARNING = 30))
    expect_equal(names(level_out), "WARNING")
    
    level_out <- periscope:::namedLevel.numeric(2)
    expect_equal(level_out, c(NOTSET = 0))
    expect_equal(names(level_out), "NOTSET")
})

test_that("Logger class", {
    logger <- periscope:::Logger$new()
    logger_parent <- logger$getParent()
    expect_s4_class(logger_parent, "Logger")
    
    logger_msgComposer <- logger_parent$getMsgComposer()
    expect_equal(logger_msgComposer(msg = "message"), "message")
    
    composer_f <- function(msg, ...) { return(paste("msg parameter value is", msg))}
    logger_parent$setMsgComposer(composer_f)
    logger_msgComposer <- logger_parent$getMsgComposer()
    expect_equal(logger_msgComposer(msg = "true"), "msg parameter value is true")
    
    expect_error(logger_parent$setMsgComposer(NULL), 
                 regexp = "message composer(passed as composer_f) must be function  with signature function(msg, ...)",
                 fixed  = TRUE)
    
    
    # .duducelevel
    logger1 <- periscope:::Logger$new(level = 100)
    level_out <- logger1$.deducelevel(initial_level = 10)
    expect_equal(level_out, 10)
    level_out <- logger1$.deducelevel(initial_level = 0)
    expect_equal(level_out, 100)
    
    logger2 <- periscope:::Logger$new(name = "", level = 0)
    level_out <- logger2$.deducelevel(initial_level = 0)
    expect_equal(level_out, 1)
    
    logger3 <- periscope:::Logger$new(name = "xyz", level = 0)
    level_out <- logger3$.deducelevel()
    expect_equal(level_out, c(INFO = 20))
    
    # setLevel/getLevel
    expect_equal(logger1$getLevel(), 100)
    logger1$setLevel(5)
    expect_equal(logger1$getLevel(), c(NOTSET = 0))
    
    # log
    log_out <- logger3$log(msglevel = "WARN", msg = "This is warning message")
    expect_true(log_out)
    
    expect_true(logger3$finest("message"))
    expect_true(logger3$finer("message"))
    expect_true(logger3$fine("message"))
    expect_true(logger3$debug("message"))
    expect_true(logger3$info("message"))
    expect_true(logger3$warn("message"))
    expect_true(logger3$error("message"))
    
    # getHandler / addHandler
    test_file_name <- file.path(tempdir(), c("1", "2", "3"))
    expect_error(logger$addHandler(handler = "new"), "No action for the handler provided")
   # logger$addHandler("basic.stdout", writeToConsole)
    
    
})


test_that("logging-entrypoints", {
    logger <- periscope:::Logger$new(name = "xyz", level = 0)
    expect_true(periscope:::logdebug(msg = "message",logger = logger))
    expect_true(periscope:::logfinest(msg = "message",logger = logger))
    expect_true(periscope:::logfiner(msg = "message",logger = logger))
    expect_true(periscope:::logfine(msg = "message",logger = logger))
    expect_true(periscope:::loginfo(msg = "message",logger = logger))
    expect_true(periscope:::logwarn(msg = "message",logger = logger))
    expect_true(periscope:::logerror(msg = "message",logger = logger))
    expect_true(periscope:::levellog(level = 0, msg = "message",logger = logger))
})

test_that("rest" ,{
    periscope:::basicConfig()
    periscope:::logReset()
})
