# downloadableTableUI

    [[1]]
    <span id="myid-dtableButtonDiv" class="periscope-downloadable-table-button" style="">
      <span>
        <a id="myid-dtableButtonID-csv" class="btn btn-default shiny-download-link periscope-download-btn" href="" target="_blank" download>
          <i class="fa fa-download" role="presentation" aria-label="download icon"></i>
        </a>
        <script>$(document).ready(function() {setTimeout(function() {shinyBS.addTooltip('myid-dtableButtonID-csv', 'tooltip', {'placement': 'top', 'trigger': 'hover', 'title': 'myHoverText'})}, 500)});</script>
      </span>
    </span>
    
    [[2]]
    <div id="myid-dtableOutputID" style="width:100%; height:auto; " class="datatables html-widget html-widget-output"></div>
    
    [[3]]
    <input id="myid-dtableOutputHeight" type="text" class="shiny-input-container hidden" value="200px"/>
    
    [[4]]
    <input id="myid-dtableSingleSelect" type="text" class="shiny-input-container hidden" value="FALSE"/>
    

# build_datatable_arguments

    Code
      build_datatable_arguments(table_options)
    Message <simpleMessage>
      'editable' option is enabled. Please note that it needs server logic to save any dataset change Please Refer to DT package documentation for more information about using that parameter.
    Output
      $rownames
      [1] FALSE
      
      $class
      [1] "periscope-downloadable-table table-condensed table-striped table-responsive"
      
      $callback
      [1] "table.order([2, 'asc']).draw();"
      
      $caption
      [1] " Very Important Information"
      
      $colnames
      [1] "Area"     "Delta"    "Increase"
      
      $filter
      [1] "bottom"
      
      $width
      [1] "150px"
      
      $height
      [1] "50px"
      
      $extensions
      [1] "Buttons"
      
      $plugins
      [1] "natural"
      
      $editable
      [1] TRUE
      
      $options
      $options$order
      $options$order[[1]]
      $options$order[[1]][[1]]
      [1] 2
      
      $options$order[[1]][[2]]
      [1] "asc"
      
      
      $options$order[[2]]
      $options$order[[2]][[1]]
      [1] 3
      
      $options$order[[2]][[2]]
      [1] "desc"
      
      
      
      $options$deferRender
      [1] FALSE
      
      $options$paging
      [1] FALSE
      
      $options$scrollX
      [1] TRUE
      
      $options$dom
      [1] "<\"periscope-downloadable-table-header\"f>tr"
      
      $options$processing
      [1] TRUE
      
      $options$rowId
      [1] 1
      
      $options$searchHighlight
      [1] TRUE
      
      

# format_columns

    Code
      format_columns(DT::datatable(dt), list(formatCurrency = list(columns = c("A",
        "C")), formatPercentage = list(columns = c("D"), 2)))

