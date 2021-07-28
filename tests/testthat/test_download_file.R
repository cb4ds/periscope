context("periscope - download file")


test_that("downloadFileButton", {
    local_edition(3)
    expect_snapshot_output(downloadFileButton(id = "myid",
                                              downloadtypes = c("csv"),
                                              hovertext = "myhovertext"))
})

test_that("downloadFileButton multiple types", {
    local_edition(3)
    expect_snapshot_output(downloadFileButton(id = "myid",
                                              downloadtypes = c("csv", "tsv"), 
                                              hovertext = "myhovertext"))
})

test_that("downloadFile_ValidateTypes invalid", {
    result <- downloadFile_ValidateTypes(types = "csv")

    expect_equal(result, "csv")
})

test_that("downloadFile_ValidateTypes invalid", {
    expect_warning(downloadFile_ValidateTypes(types = "csv_invalid"), "file download list contains an invalid type <csv_invalid>")
})

test_that("downloadFile_AvailableTypes", {
    result <- downloadFile_AvailableTypes()

    expect_equal(result, c("csv", "xlsx", "tsv", "txt", "png", "jpeg", "tiff", "bmp"))
})

test_that("downloadFile", {
    # helper functions
    download_plot <- function() {
        ggplot2::ggplot(data = mtcars, aes(x = wt, y = mpg)) +
            geom_point(aes(color = cyl)) +
            theme(legend.justification = c(1, 1),
                  legend.position = c(1, 1),
                  legend.title = element_blank()) +
            ggtitle("GGPlot Example w/Hover") +
            xlab("wt") +
            ylab("mpg")
    }
    
    download_plot_lattice <- function() {
        lattice::xyplot(mpg ~ wt , data = mtcars,
                        pch = 1, groups = factor(cyl),
                        auto.key = list(corner = c(1, 1)),
                        main = "Lattice Example")
    }
    
    download_data <- function() {
        mtcars
    }
    
    download_data_show_row_names <- function() {
        attr(mtcars, "show_rownames") <-  TRUE
        mtcars
    }
    
    download_openxlsx_data <- function() {
        openxlsx::createWorkbook()
    }
    
    download_string_list <- function() {
        c("test1", "test2", "tests")
    }
    
    ############# testing different modes
    testServer(downloadFile, 
               args = list(logger = periscope:::fw_get_user_log(),
                           datafxns = list(csv   = download_data,
                                           xlsx  = download_data,
                                           tsv   = download_data,
                                           txt   = download_data,
                                           png   = download_plot,
                                           jpeg  = download_plot,
                                           tiff  = download_plot,
                                           bmp   = download_plot_lattice),
                           filenameroot = "mydownload1"),
               expr = suppressWarnings({
                   expect_equal(rootname(), "mydownload1")
                   expect_true(grepl("mydownload1.csv", output$csv, fixed = TRUE))
                   expect_true(grepl("mydownload1.tsv", output$tsv, fixed = TRUE))
                   expect_true(grepl("mydownload1.txt", output$txt, fixed = TRUE))
                   expect_true(grepl("mydownload1.xlsx", output$xlsx, fixed = TRUE))
                   expect_true(grepl("mydownload1.png", output$png, fixed = TRUE))
                   expect_true(grepl("mydownload1.jpeg", output$jpeg, fixed = TRUE))
                   expect_true(grepl("mydownload1.tiff", output$tiff, fixed = TRUE))
                   expect_true(grepl("mydownload1.bmp", output$bmp, fixed = TRUE))
               }))
    
    testServer(downloadFile, 
               args = list(logger = periscope:::fw_get_user_log(),
                           datafxns = list(csv   = download_data_show_row_names,
                                           xlsx  = download_data_show_row_names,
                                           tsv   = download_data_show_row_names,
                                           txt   = download_data_show_row_names),
                           filenameroot = "mydownload1"),
               expr = suppressWarnings({
                   expect_equal(rootname(), "mydownload1")
                   expect_true(grepl("mydownload1.csv", output$csv, fixed = TRUE))
                   expect_true(grepl("mydownload1.tsv", output$tsv, fixed = TRUE))
                   expect_true(grepl("mydownload1.txt", output$txt, fixed = TRUE))
                   expect_true(grepl("mydownload1.xlsx", output$xlsx, fixed = TRUE))
               }))
    
    testServer(downloadFile, 
               args = list(logger = periscope:::fw_get_user_log(),
                           datafxns = list(xlsx  = download_openxlsx_data),
                           filenameroot = "mydownload1"),
               expr = suppressWarnings({
                   expect_equal(rootname(), "mydownload1")
                   expect_true(grepl("mydownload1.xlsx", output$xlsx, fixed = TRUE))
               }))
    
    testServer(downloadFile,
               args = list(logger = periscope:::fw_get_user_log(),
                           datafxns = list(txt  = download_string_list),
                           filenameroot = "mydownload1"),
               expr = suppressWarnings({
                   expect_equal(rootname(), "mydownload1")
                   expect_true(grepl("mydownload1.txt", output$txt, fixed = TRUE))
               }))

    testServer(downloadFile,
               args = list(logger = periscope:::fw_get_user_log(),
                           datafxns = list(txt  = function(){c(1, 2, 3)}),
                           filenameroot = "mydownload1"),
               expr = suppressWarnings({
                   expect_equal(rootname(), "mydownload1")
                   expect_error(grepl("mydownload1.txt", output$txt, fixed = TRUE))
               }))

    testServer(downloadFile,
               args = list(logger = periscope:::fw_get_user_log(),
                           datafxns = list(text  = download_string_list),
                           filenameroot = "mydownload1"),
               expr = suppressWarnings({
                   expect_equal(rootname(), "mydownload1")
                   expect_error(grepl("mydownload1.text", output$etxt, fixed = TRUE))
               }))

    testServer(downloadFile,
               args = list(logger = periscope:::fw_get_user_log(),
                           datafxns = list(jpeg  = function(){plot(mtcars$mpg)}),
                           filenameroot = "mydownload1"),
               expr = suppressWarnings({
                   expect_equal(rootname(), "mydownload1")
                   expect_error(grepl("mydownload1.jpeg", output$jpeg, fixed = TRUE))
               }))

    testServer(downloadFile,
               args = list(logger = periscope:::fw_get_user_log(),
                           datafxns = list(jbj  = download_plot),
                           filenameroot = "mydownload1"),
               expr = suppressWarnings({
                   expect_equal(rootname(), "mydownload1")
                   expect_error(grepl("mydownload1.jbj", output$jbj, fixed = TRUE))
               }))

    testServer(downloadFile,
               args = list(logger = periscope:::fw_get_user_log(),
                           datafxns = list(jbj  = download_plot_lattice()),
                           filenameroot = "mydownload1"),
               expr = suppressWarnings({
                   expect_equal(rootname(), "mydownload1")
                   expect_error(grepl("mydownload1.jbj", output$jbj, fixed = TRUE))
               }))
})
