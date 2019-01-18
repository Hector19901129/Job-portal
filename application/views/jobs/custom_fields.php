<div class="white-area-content">
<script type="text/javascript" src="<?php echo base_url() ?>scripts/redips/header.js"></script>
<script type="text/javascript" src="<?php echo base_url() ?>scripts/redips/redips-drag-min.js"></script>
<script type="text/javascript" src="<?php echo base_url() ?>scripts/redips/script.js"></script>
  <style>
    #redips-drag {
      border: 1px solid LightBlue;
      width: 100%;
      padding: 0px;
      margin: 0px auto;
    }

    /* set border-collapse */
    div#redips-drag table {
      border-collapse: collapse;
      width: 100%;
    }

    .redips-drag {
      margin: auto;
      margin-bottom: 1px;
      margin-top: 1px;
      text-align: center;
      font-size: 10pt;
      width: 100%;
      height: 20px;
      line-height: 20px;
      border-width: 2px;
      border-style: solid;
      background-color: white;
      /* round corners */
      border-radius: 4px; /* Opera, Chrome */
      -moz-border-radius: 4px; /* FF */
    }
    .redips-row {
      width: 20px;
      margin: 2px;
      border-color: SteelBlue;
      background-color: SteelBlue;
      /* round corners */
      border-radius: 14px; /* Opera, Chrome */
      -moz-border-radius: 14px; /* FF */
    }

    /* marked cells (forbidden access for header and message line) */

  </style>
<div class="db-header clearfix">
    <div class="page-header-title"> <span class="glyphicon glyphicon-send"></span> <?php echo lang("ctn_573") ?></div>
    <div class="db-header-extra form-inline"> 

      <div class="form-group has-feedback no-margin">
          <div class="input-group">
            <input type="text" class="form-control input-sm" placeholder="<?php echo lang("ctn_336") ?>" id="form-search-input" />
            <div class="input-group-btn">
                <input type="hidden" id="search_type" value="0">
                    <button type="button" class="btn btn-info btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span class="glyphicon glyphicon-search" aria-hidden="true"></span></button>
                    <ul class="dropdown-menu small-text" style="min-width: 90px !important; left: -90px;">
                      <li><a href="#" onclick="change_search(0)"><span class="glyphicon glyphicon-ok" id="search-like"></span> <?php echo lang("ctn_337") ?></a></li>
                      <li><a href="#" onclick="change_search(1)"><span class="glyphicon glyphicon-ok no-display" id="search-exact"></span> <?php echo lang("ctn_338") ?></a></li>
                      <li><a href="#" onclick="change_search(2)"><span class="glyphicon glyphicon-ok no-display" id="title-exact"></span> <?php echo lang("ctn_574") ?></a></li>
                    </ul>
                  </div><!-- /btn-group -->
            </div>
          </div>

          <a href="<?php echo site_url("jobs/add_custom_field") ?>" class="btn btn-primary btn-sm"><?php echo lang("ctn_373") ?></a>
        </div>
    </div>

<div class="table-responsive">
  <!-- <div class="redips-drag">
    <table id="custom-table" class="table table-bordered table-striped table-hover">
      
      <tr class="table-header"><td>Drag</td><td><?php echo lang("ctn_574") ?></td><td><?php echo lang("ctn_575") ?></td><td><?php echo lang("ctn_52") ?></td></tr>
      
      
          <tr id="v1">
						<td class="redips-rowhandler">
							<div class="redips-drag redips-row"></div>
						</td>
						<td>View 0 
            </td>
            <td>View 0 
            </td>
            <td>View 0 
            </td>
            
					</tr>
					<tr id="v2">
						<td class="redips-rowhandler">
							<div class="redips-drag redips-row"></div>
						</td>
						<td>View 1 
            </td>
            <td>View 1 
            </td>
            <td>View 1 
						</td>
					</tr>
					<tr id="v3">
						<td class="redips-rowhandler">
							<div class="redips-drag redips-row"></div>
						</td>
						<td>View 2 
            </td>
            <td>View 2 
            </td>
            <td>View 2 
            </td>
            
					</tr>
       
    </table>
  </div> -->
  <div id="redips-drag">
				<table id="custom-table" class="table table-bordered table-striped table-hover">
        <tr class="table-header"><td>Drag</td><td><?php echo lang("ctn_574") ?></td><td><?php echo lang("ctn_575") ?></td><td><?php echo lang("ctn_52") ?></td></tr>
					<?php foreach($data as $key => $r){?>
          <tr id="draganddrop<?php echo $r["field_id"]?>">
						<td class="redips-rowhandler">
							<div class="redips-drag redips-row"></div>
						</td>
						<td><?php echo $r["field_name"]?> 
            </td>
            <td><?php echo $r["field_type"]?>
            </td>
            <td><?php echo $r["edit_field"]?>
						</td>
					</tr>
          <?php }?>
					
				</table>
        <input type="submit" class="btn btn-primary form-control" value="Save Order" id="submit">
			</div>
</div>

</div>
<script type="text/javascript">
// $(document).ready(function() {

//    var st = $('#search_type').val();
//     var table = $('#custom-table').DataTable({
//         "dom" : "<'row'<'col-sm-12'tr>>" +
//                 "<'row'<'col-sm-5'i><'col-sm-7'p>>",
//         "processing": false,
//         "pagingType" : "full_numbers",
//         "pageLength" : 15,
//         "serverSide": true,
//         "orderMulti": false,
//         "order": [
//         ],
//         'createdRow': function( row, data, dataIndex ) {
//       		$(row).attr('id', 'row-' + dataIndex);
//         },
//         'columnDefs': [
//           {
//               'targets': 0,
//               'createdCell':  function (td, cellData, rowData, row, col) {
//                   $(td).addClass("redips-rowhandler");
//               }
//           }
//   		  ],
//         "columns": [
//           null,
//           null,
//           null,
//         { "orderable": false }
//         ],
//         "ajax": {
//             url : "<?php echo site_url("jobs/field_page") ?>",
//             type : 'GET',
//             data : function ( d ) {
//                 d.search_type = $('#search_type').val();
//             }
//         },
//         "drawCallback": function(settings, json) {
//         $('[data-toggle="tooltip"]').tooltip();
//       }
//     });
//     $('#form-search-input').on('keyup change', function () {
//     table.search(this.value).draw();
// });

// } );
function change_search(search) 
    {
      var options = [
        "search-like", 
        "search-exact",
        "title-exact",
      ];
      set_search_icon(options[search], options);
        $('#search_type').val(search);
        $( "#form-search-input" ).trigger( "change" );
    }

function set_search_icon(icon, options) 
    {
      for(var i = 0; i<options.length;i++) {
        if(options[i] == icon) {
          $('#' + icon).fadeIn(10);
        } else {
          $('#' + options[i]).fadeOut(10);
        }
      }
    }
function disp(trs){
  var str = "";
  for(var i = 0; i < trs.length; i++){
      str += trs[i].id.substring(11);
      str += ",";
  }
  return str;
}
$(document).ready(function(){
  $("#submit").click(function(){
    var str = disp($("[id^='draganddrop']").toArray());
    $.post("<?php echo site_url("jobs/saveOrder") ?>", 
      {'<?php echo $this->security->get_csrf_token_name(); ?>': '<?php echo $this->security->get_csrf_hash(); ?>', 
        str: str}, 
        function(result){
           alert("Saved orders successfully.");
        });
  });
});
</script>