context("periscope - downloadable table")


test_that("downloadableTable", {

    local_edition(3)
    expect_snapshot_output(downloadableTableUI(id = "myid", 
                                               downloadtypes = c("csv"), 
                                               hovertext = "myHoverText"))
})

