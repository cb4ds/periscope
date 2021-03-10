context("periscope - downloadable table")


test_that("downloadableTableUI", {
    local_edition(3)
    expect_snapshot_output(downloadableTableUI(id = "myid", 
                                               downloadtypes = c("csv"), 
                                               hovertext = "myHoverText"))
})

test_that("downloadableTable", {
    # default values only
    testServer(downloadableTable, {
        expect_silent(downloadableTable)
    })
    
    testServer(downloadableTable, {
        session$setInputs(dtableSingleSelect = "TRUE")
        expect_silent(downloadableTable)
    })
})
