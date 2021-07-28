context("periscope - downloadable table")


test_that("downloadableTableUI", {
    local_edition(3)
    expect_snapshot_output(downloadableTableUI(id = "myid", 
                                               downloadtypes = c("csv"), 
                                               hovertext = "myHoverText"))
})

test_that("downloadableTable", {
    local_edition(3)
    # helper functions
    data <- function() {
        mtcars
    }
    
    mydataRowIds <- function(){
        rownames(mtcars)
    }
    
    testServer(downloadableTable, 
               args = list(logger = periscope:::fw_get_user_log(),
                           filenameroot = "mydownload1",
                           downloaddatafxns = list(csv = data, tsv = data),
                           tabledata = data,
                           selection = mydataRowIds),
               expr = {
                   session$setInputs(dtableSingleSelect = "TRUE")
                   expect_equal(dtInfo$selection[[1]], "single")
                   expect_equal(dtInfo$selection[[2]], "Mazda RX4")
                   expect_equal(dtInfo$selected, NULL)
                   expect_equal(dim(dtInfo$tabledata), c(32, 11))
                   expect_equal(length(dtInfo$downloaddatafxns), 2)
                   expect_equal(class(output$dtableOutputID), "json")
                   expect_snapshot_output(output$dtableOutputID)
                   
                   session$setInputs(dtableSingleSelect = "FALSE")
                   expect_equal(dtInfo$selection[[1]], "multiple")
                   expect_equal(dtInfo$selection[[2]][1:2], c("Mazda RX4", "Mazda RX4 Wag"))
                   expect_equal(dtInfo$selected, NULL)
                   expect_equal(dim(dtInfo$tabledata), c(32, 11))
                   expect_equal(length(dtInfo$downloaddatafxns), 2)
                   expect_equal(class(output$dtableOutputID), "json")
                   expect_snapshot_output(output$dtableOutputID)
               })
})
