context("periscope - Body footer")

test_that(".bodyFooterOutput", {
    local_edition(3)
    expect_snapshot_output(.bodyFooterOutput("myid"))
})

test_that(".bodyFooter", {
    local_edition(3)
    # Helper functions
    data <- function(){
        c("line 1", "line 2", "line 3")
    }
    testServer(.bodyFooter,
               args = list(logdata = data),
               expr = {
                   expect_snapshot_output(output$dt_userlog)
               })
})
