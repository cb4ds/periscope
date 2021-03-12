context("periscope - App reset")

test_that(".appResetButton", {
    local_edition(3)
    expect_snapshot_output(.appResetButton("myid"))
})

test_that(".appReset - no reset button", {
    # there is no reset button on the UI for the app
    expect_silent(.appReset(input = list(), 
                            output = list(), 
                            session = MockShinySession$new(),
                            logger = periscope:::fw_get_user_log()))
})

test_that(".appReset - reset button - no pending", {
    session <- MockShinySession$new()
    input <- list(resetButton = TRUE, resetPending = FALSE)
    expect_silent(.appReset(input = input, 
                            output = list(),
                            session = MockShinySession$new(),
                            logger = periscope:::fw_get_user_log()))
})

test_that(".appReset - no reset button - with pending", {
    input <- list(resetButton = FALSE, resetPending = TRUE)
    expect_silent(.appReset(input = input,
                            output = list(),
                            session = MockShinySession$new(),
                            logger = periscope:::fw_get_user_log()))
})

test_that(".appReset - null reset button - with pending", {
    input <- list(resetButton = NULL, resetPending = TRUE)
    expect_silent(.appReset(input, 
                            output = list(),
                            session = MockShinySession$new(), 
                            logger = periscope:::fw_get_user_log()))
})
