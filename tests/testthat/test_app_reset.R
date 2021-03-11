context("periscope - App reset")

test_that(".appResetButton", {
    local_edition(3)
    expect_snapshot_output(.appResetButton("myid"))
})

test_that(".appReset", {
    # there is no reset button on the UI for the app
    testServer(.appReset, {session$setInputs(resetPending = NULL)
        expect_silent(.appReset)})
    
    testServer(.appReset, {session$setInputs(resetPending = FALSE, resetButton = TRUE)
        expect_silent(.appReset)})
    
    testServer(.appReset, {session$setInputs(resetPending = TRUE, resetButton = FALSE)
        expect_silent(.appReset)})
    
    testServer(.appReset, {session$setInputs(resetPending = FALSE, resetButton = FALSE)
        expect_silent(.appReset)})
})
