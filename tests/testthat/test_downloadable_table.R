context("periscope - downloadable table")


test_that("downloadableTableUI", {
    local_edition(3)
    expect_snapshot_output(downloadableTableUI(id = "myid", 
                                               downloadtypes = c("csv"), 
                                               hovertext = "myHoverText"))
})

# helper functions
data <- function() {
    mtcars
}

mydataRowIds <- function(){
    rownames(mtcars)
}

test_that("downloadableTable", {
    suppressWarnings({
        session <- MockShinySession$new()
        session$setInputs(dtableSingleSelect = "FALSE")
        session$env$filenameroot <-  "mydownload1"
        session$env$downloaddatafxns = list(csv = data, tsv = data)
        expect_silent(shiny::callModule(downloadableTable,
                                        "download",
                                        input = list(dtableSingleSelect = "FALSE"),
                                        output = list(), 
                                        session = session,
                                        logger = periscope:::fw_get_user_log(),
                                        filenameroot = "mydownload1",
                                        downloaddatafxns = list(csv = data, tsv = data),
                                        tabledata = data,
                                        selection = mydataRowIds))
    })
})
