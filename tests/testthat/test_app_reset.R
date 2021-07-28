context("periscope - App reset")

test_that(".appResetButton", {
    local_edition(3)
    expect_snapshot_output(.appResetButton("myid"))
})

test_that(".appReset - no reset button", {
    testServer(.appReset,
               args = list(logger = periscope:::fw_get_user_log()),
               expr = {
                   session$setInputs(resetPending = NULL)
                   suppressWarnings(expect_equal(class(session$getReturned()), c("Observer", "R6")))
               })
})
    
test_that(".appReset - reset button - no pending", {
    testServer(.appReset,
               args = list(logger = periscope:::fw_get_user_log()),
               expr = {
                   session$setInputs(resetPending = TRUE, resetButton = FALSE)
                   suppressWarnings(expect_equal(class(session$getReturned()), c("Observer", "R6")))
               })
})

test_that(".appReset - no reset button - with pending", {
    testServer(.appReset,
               args = list(logger = periscope:::fw_get_user_log()),
               expr = {
                   session$setInputs(resetPending = FALSE, resetButton = TRUE)
                   suppressWarnings(expect_equal(class(session$getReturned()), c("Observer", "R6")))
               })
})
    
test_that(".appReset - reset button - with pending", {
    testServer(.appReset,
               args = list(logger = periscope:::fw_get_user_log()),
               expr = {
                   session$setInputs(resetPending = TRUE, resetButton = TRUE)
                   suppressWarnings(expect_equal(class(session$getReturned()), c("Observer", "R6")))
               })
})
    
test_that(".appReset", {
    testServer(.appReset,
               args = list(logger = periscope:::fw_get_user_log()),
               expr = {
                   session$setInputs(resetPending = FALSE, resetButton = FALSE)
                   suppressWarnings(expect_equal(class(session$getReturned()), c("Observer", "R6")))
               })
})
