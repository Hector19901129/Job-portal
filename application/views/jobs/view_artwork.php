<script src="<?php echo base_url();?>scripts/custom/get_usernames.js"></script>

<?php $prioritys = array(0 => "<span class='label label-info'>".lang("ctn_429")."</span>", 1 => "<span class='label label-primary'>".lang("ctn_430")."</span>", 2=> "<span class='label label-warning'>".lang("ctn_431")."</span>", 3 => "<span class='label label-danger'>".lang("ctn_432")."</span>"); ?>
<?php $statuses = array(0=>lang("ctn_465"), 1 => lang("ctn_466"), 2 => lang("ctn_467"), 3 => 'Removed', 4 => 'Completed') ?>
<?php
if($job->status == 0) {
$statusbtn = "btn-info";
} elseif($job->status == 1) {
$statusbtn = "btn-primary";
} elseif($job->status == 2) {
$statusbtn = "btn-primary";
} elseif($job->status == 3) {
$statusbtn = "btn-danger";
} elseif($job->status == 4) {
  $statusbtn = "btn-info";
}
?>
<div class="row">
<div class="col-md-8">

<div class="panel panel-default">
<div class="panel-body" style="position: relative;">
<div class="media" style="overflow: visible !important; margin-top: 0px;">
  <div class="media-left">
      <?php echo $this->common->get_user_display(array("username" => $job->client_username, "avatar" => $job->client_avatar, "online_timestamp" => $job->client_online_timestamp, "user" => false)) ?>
  </div>
  <div class="media-body" style="overflow: visible !important;">
<h3 class="media-title"><?php echo $job->title ?></h3>
<p><?php echo $job->body ?></p>
<?php if(!empty($job->notes) && $this->common->has_permissions(array("admin", "job_manager", "job_worker"), $this->user)) : ?>
<hr>
<p><?php echo "This is an artwork" ?></p>
<p><i><?php echo $job->notes ?></i></p>
<?php endif; ?>
<?php if($this->settings->info->enable_job_uploads && $files->num_rows() > 0) : ?>
    <hr>
    <h4><?php echo lang("ctn_437") ?></h4>
    <div class="form-group">
            <div class="col-md-12">
                <table class="table table-bordered">
                <?php foreach($files->result() as $r) : ?>
                    <tr><td><a href="<?php echo base_url() . $this->settings->info->upload_path_relative . "/" . $r->upload_file_name ?>"><?php echo $r->upload_file_name ?></a></td><td><?php echo $r->file_size ?>kb</td><td>
                          <?php if($r->userid == $this->user->info->ID || $this->common->has_permissions(array("admin", "job_manage", "job_worker"), $this->user)) : ?>
                                  <a href="<?php echo site_url("jobs/delete_file_attachment/" . $r->ID . "/" . $this->security->get_csrf_hash()) ?>" class="btn btn-danger btn-xs"><span class="glyphicon glyphicon-trash"></span></a>
                                <?php endif; ?></td></tr>
                <?php endforeach; ?>
                </table>
            </div>
    </div>
<?php endif; ?>
<div class="small-text">
<p><strong><?php echo "Property Address" ?></strong><br /><?php echo $artwork->title ?></p>
<p><strong><?php echo "Email" ?></strong><br /><?php echo $artwork->email ?></p>
<p><strong><?php echo "Sign Type" ?></strong><br /><?php echo $artwork->sign_type ?></p>
  </div>

  </div>
  </div> <!-- End media -->

</div>
</div>

<?php foreach($replies->result() as $r) : ?>
  <div class="white-area-content content-separator">
  <?php if($r->userid == $this->user->info->ID || $this->common->has_permissions(array("admin", "job_manager", "job_worker"), $this->user)) : ?>
    <div class="job-reply-options">
    <a href="<?php echo site_url("jobs/edit_job_reply/" . $r->ID) ?>" class="btn btn-warning btn-xs" data-toggle="tooltip" data-placement="right" title="<?php echo lang("ctn_55") ?>"><span class="glyphicon glyphicon-cog"></span></a>
    <a href="<?php echo site_url("jobs/delete_job_reply/" . $r->ID . "/" . $this->security->get_csrf_hash()) ?>" class="btn btn-danger btn-xs" onclick="return confirm('<?php echo lang("ctn_317") ?>')" data-toggle="tooltip" data-placement="right" title="<?php echo lang("ctn_57") ?>"><span class="glyphicon glyphicon-trash"></span></a>
    </div>
  <?php endif; ?>

<div class="media">
  <div class="media-left">
    <?php echo $this->common->get_user_display(array("username" => $r->username, "avatar" => $r->avatar, "online_timestamp" => $r->online_timestamp, "user" => false)) ?>
  </div>
  <div class="media-body">
    <h4 class="media-title"><a href="<?php echo site_url("profile/" . $r->username) ?>"><?php echo $r->username ?></a></h4>
    <p><?php echo $r->body ?></p>
    <p class="small-text"><?php echo lang("ctn_628") ?>: <?php echo date($this->settings->info->date_format, $r->timestamp); ?></p>
    <?php if($r->files && $this->settings->info->enable_job_uploads) : ?>
<?php $files = $this->jobs_model->get_reply_files($r->ID); ?>
<hr>
                <div class="form-group clearfix">
                        <label for="p-in" class="col-md-4 label-heading"><?php echo lang("ctn_437") ?></label>
                        <div class="col-md-8">
                            <table class="table table-bordered">
                            <?php foreach($files->result() as $r) : ?>
                                <tr><td><a href="<?php echo base_url() . $this->settings->info->upload_path_relative . "/" . $r->upload_file_name ?>"><?php echo $r->upload_file_name ?></a></td><td><?php echo $r->file_size ?>kb</td><td>
                                  <?php if($r->userid == $this->user->info->ID || $this->common->has_permissions(array("admin", "job_manager", "job_worker"), $this->user)) : ?>
                                  <a href="<?php echo site_url("jobs/delete_file_attachment/" . $r->ID . "/" . $this->security->get_csrf_hash()) ?>" class="btn btn-danger btn-xs"><span class="glyphicon glyphicon-trash"></span></a>
                                <?php endif; ?>
                                </td></tr>
                            <?php endforeach; ?>
                            </table>
                        </div>
                </div>
<?php endif; ?>
  </div>
</div>

</div>
<?php endforeach; ?>

<div class="white-area-content content-separator">
<h4 class="media-title"><?php echo lang("ctn_473") ?></h4>
<?php echo form_open_multipart(site_url("jobs/job_reply/" . $job->ID), array("class" => "form-horizontal")) ?>
<p><textarea name="body" id="job-body"></textarea></p>
<?php if($this->settings->info->enable_job_uploads) : ?>
                <hr>
                <h4><?php echo lang("ctn_436") ?></h4>
                <input type="hidden" name="file_count" value="1" id="file_count">
                <div id="file_block">
                <div class="form-group">
                        <label for="p-in" class="col-md-4 label-heading"><?php echo lang("ctn_438") ?></label>
                        <div class="col-md-8">
                            <input type="file" name="user_file_1" class="form-control">
                        </div>
                </div>
                </div>
                <input type="button" name="s" value="<?php echo lang("ctn_439") ?>" class="btn btn-info btn-xs" onclick="add_file()">
                <hr>
            <?php endif; ?>
<?php if($canned->num_rows() > 0) : ?>
<p><?php echo lang("ctn_533") ?></p>
<p><select id="cannedr" class="form-control"><option value="0"><?php echo lang("ctn_434") ?></option>
<?php foreach($canned->result() as $r) : ?>
<option value="<?php echo html_escape($r->body) ?>"><?php echo $r->title ?></option>
<?php endforeach; ?>
</select></p>
<?php endif; ?>
<p><input type="submit" class="btn btn-primary btn-sm form-control" value="<?php echo lang("ctn_474") ?>"></p>
<?php echo form_close() ?>
</div>

</div>
<div class="col-md-4">

<div class="panel panel-default">
<div class="panel-body">
<h4 class="media-title"><?php echo lang("ctn_629") ?></h4>
<table class="table">
<tr><td><?php echo lang("ctn_611") ?></td><td> <?php echo $job->ID ?></td></tr>
<tr><td><?php echo lang("ctn_468") ?></td><td> <?php if(isset($job->client_username)) : ?><a href="<?php echo site_url("profile/" . $job->client_username) ?>"><?php echo $job->client_username ?></a> <?php else : ?> <?php echo lang("ctn_469") ?>: <?php echo $job->guest_email ?><?php endif; ?></td></tr>
<tr><td colspan="2"><button class="btn btn-default btn-xs" type="button" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample"><?php echo lang("ctn_601") ?></button>
    <div class="collapse" id="collapseExample">
      <div class=" small-text">
        <table class="table">
        <tr><td><?php echo lang("ctn_25") ?></td><td><?php echo $job->client_username ?></td></tr>
        <tr><td><?php echo lang("ctn_24") ?></td><td><?php echo $job->client_email ?></td></tr>
        <tr><td><?php echo lang("ctn_81") ?></td><td><?php echo $job->first_name ?> <?php echo $job->last_name ?></td></tr>
        <?php if($user_fields) : ?>
        <?php foreach($user_fields->result() as $r) : ?>
          <tr><td><?php echo $r->name ?></td><td><?php echo $r->value ?></td></tr>
        <?php endforeach; ?>
        <?php endif; ?>
        <?php if($this->common->has_permissions(array("admin", "admin_members"), $this->user)) : ?>
          <tr><td colspan="2"><a href="<?php echo site_url("admin/edit_member/" . $job->userid) ?>" class="btn btn-warning btn-xs">Edit Member</a></td></tr>
        <?php endif; ?>
        </table>
      </div>
    </div></td></tr>
  <tr><td><?php echo lang("ctn_470") ?></td><td> <?php echo date($this->settings->info->date_format, $job->timestamp); ?></td></tr>
  <tr><td><?php echo lang("ctn_471") ?></td><td> <?php echo date($this->settings->info->date_format, $job->last_reply_timestamp) ?> <?php if(isset($job->lr_username)) : ?><?php echo lang("ctn_602") ?> <a href="<?php echo site_url("profile/" . $job->lr_username) ?>"><?php echo $job->lr_username ?></a><?php endif; ?> </td></tr>
  <!--  -->
    <?php if($this->settings->info->job_rating) : ?>
    <tr><td>Job Rating</td><td>
      <?php for($i=1;$i<=5;$i++) : ?>
      <?php if($i > $job->rating) : ?>
        <span class="glyphicon glyphicon-star-empty click" id="job<?php echo $i ?>"></span>
      <?php else : ?>
        <span class="glyphicon glyphicon-star click" id="job<?php echo $i ?>"></span>
      <?php endif; ?>
    <?php endfor; ?>
    </td></tr>
  <?php endif; ?>
    </table>
    <?php if($this->common->has_permissions(array("admin", "job_manager", "job_worker"), $this->user)) : ?>
    <p>
<div class="dropdown ui-front form-inline">
    <button id="status-button-update" type="button" class="btn btn-default btn-xs"> <span class="glyphicon glyphicon-refresh spin"></span></button>
  <button class="btn <?php echo $statusbtn ?> btn-xs dropdown-toggle" type="button" id="status-button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
    <?php echo $statuses[$job->status] ?>
    <span class="caret"></span>
  </button>
  <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
    <li><a href="javascript: void(0)" onclick="changeStatus(<?php echo $job->ID ?>,0);"><?php echo "new" ?></a></li>
    <li><a href="javascript: void(0)" onclick="changeStatus(<?php echo $job->ID ?>,1);"><?php echo "approved" ?></a></li>
    <li><a href="javascript: void(0)" onclick="changeStatus(<?php echo $job->ID ?>,2);"><?php echo "declined" ?></a></li>
  </ul>

     <a href="<?php echo site_url("jobs/print_artwork_view/" . $job->ID) ?>" class="btn btn-default btn-xs" data-toggle="tooltip" data-placement="right" title="<?php echo lang("ctn_632") ?>"><span class="glyphicon glyphicon-print"></span></a> 
     
     <a href="<?php echo site_url("jobs/edit_artwork/" . $job->ID) ?>" class="btn btn-warning btn-xs" data-toggle="tooltip" data-placement="right" title="<?php echo lang("ctn_55") ?>"><span class="glyphicon glyphicon-cog"></span></a> 
     
     <a href="<?php echo site_url("jobs/delete_artwork/" . $job->ID . "/" . $this->security->get_csrf_hash()) ?>" class="btn btn-danger btn-xs" onclick="return confirm('<?php echo lang("ctn_317") ?>')" data-toggle="tooltip" data-placement="right" title="<?php echo lang("ctn_57") ?>"><span class="glyphicon glyphicon-trash"></span></a>
</div>

    </p>
  <?php endif; ?>

  </div>
</div>

<div class="panel panel-default">
<div class="panel-body">
<h4 class="media-title"><?php echo lang("ctn_633") ?></h4>

<?php foreach($history->result() as $r) : ?>
<div class="media">
  <div class="media-left">
    <?php echo $this->common->get_user_display(array("username" => $r->username, "avatar" => $r->avatar, "online_timestamp" => $r->online_timestamp, "user" => false)) ?>
  </div>
  <div class="media-body">
    <p><?php echo $r->message ?></p>
    <p class="small-text"><?php echo date($this->settings->info->date_format, $r->timestamp) ?></p>
  </div>
</div>
<hr>
<?php endforeach; ?>

<p class="align-center"><a href="<?php echo site_url("jobs/job_history/" . $job->ID) ?>" class="btn btn-info btn-sm"><?php echo lang("ctn_634") ?></a></p>

</div>
</div>


</div>
</div>

<div class="modal fade" id="assignModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel"><span class="glyphicon glyphicon-pushpin"></span> <?php echo lang("ctn_561") ?></h4>
      </div>
      <div class="modal-body">
         <?php echo form_open(site_url("jobs/assign_user_pro/" . $job->ID), array("class" => "form-horizontal")) ?>
            <div class="form-group">
                    <label for="p-in" class="col-md-4 label-heading"><?php echo lang("ctn_25") ?></label>
                    <div class="col-md-8 ui-front">
                        <input type="text" class="form-control" name="username" id="username-search" value="">
                    </div>
            </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal"><?php echo lang("ctn_60") ?></button>
        <input type="submit" class="btn btn-primary" value="<?php echo lang("ctn_561") ?>">
        <?php echo form_close() ?>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="closeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel"><span class="glyphicon glyphicon-pushpin"></span> <?php echo lang("ctn_564") ?></h4>
      </div>
      <div class="modal-body">
         <?php echo form_open(site_url("jobs/edit_job_note_pro/" . $job->ID), array("class" => "form-horizontal")) ?>
            <div class="form-group">
                    <label for="p-in" class="col-md-4 label-heading"><?php echo lang("ctn_564") ?></label>
                    <div class="col-md-8 ui-front">
                        <textarea id="note-area" name="note"><?php echo $job->notes ?></textarea>
                    </div>
            </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal"><?php echo lang("ctn_60") ?></button>
        <input type="submit" class="btn btn-primary" value="<?php echo lang("ctn_599") ?>">
        <?php echo form_close() ?>
      </div>
    </div>
  </div>
</div>



<script type="text/javascript">
$(document).ready(function() {

  /* Get list of usernames */
  $('#username-search').autocomplete({
    delay : 300,
    minLength: 2,
    source: function (request, response) {
         $.ajax({
             type: "GET",
             url: global_base_url + "jobs/get_usernames",
             data: {
                query : request.term
             },
             dataType: 'JSON',
             success: function (msg) {
                 response(msg);
             }
         });
      }
  });
$('#cannedr').change(function() {
  var body = $('#cannedr').val();

  body = body.replace('[USER]', client_user);
  body = body.replace('[ADMIN_NAME]', admin_user);
  body = body.replace('[SITE_NAME]', site_name);
  body = body.replace('[FIRST_NAME]', client_first_name);
  body = body.replace('[LAST_NAME]', client_last_name);
  body = body.replace('[STAFF_FIRST_NAME]', staff_first_name);
  body = body.replace('[STAFF_LAST_NAME]', staff_last_name);


  CKEDITOR.instances['job-body'].setData(body);
});
});
CKEDITOR.replace('job-body', { height: '200'});
CKEDITOR.replace('note-area', { height: '200'});

function add_file()
{
    var count = $('#file_count').val();
    count++;
    var html = '<div class="form-group">'+
                    '<label for="p-in" class="col-md-4 label-heading"><?php echo lang("ctn_438") ?></label>'+
                    '<div class="col-md-8">'+
                        '<input type="file" name="user_file_'+count+'" class="form-control">'+
                    '</div>'+
            '</div>';
    $('#file_block').append(html);
    $('#file_count').val(count);
}

function changeStatus(jobid, id) {
  $('#status-button-update').fadeIn(100);
  $.ajax({
    url: global_base_url + "jobs/change_status",
    type: "GET",
    data: {
      status : id,
      jobid : jobid
    },
    dataType : 'json',
    success: function(msg) {
      if(msg.error) {
        alert(msg.error_msg);
        return;
      }
      if(id == 0) {
        $('#status-button').removeClass();
        $('#status-button').addClass("btn btn-info btn-xs dropdown-toggle");
        $('#status-button').html('<?php echo lang("ctn_465") ?>  <span class="caret"></span>');
      } else if(id == 1) {
        $('#status-button').removeClass();
        $('#status-button').addClass("btn btn-primary btn-xs dropdown-toggle");
        $('#status-button').html('<?php echo lang("ctn_466") ?>  <span class="caret"></span>');
      } else if(id == 2) {
        $('#status-button').removeClass();
        $('#status-button').addClass("btn btn-primary btn-xs dropdown-toggle");
        $('#status-button').html('<?php echo lang("ctn_467") ?>  <span class="caret"></span>');
      } else if(id == 3) {
        $('#status-button').removeClass();
        $('#status-button').addClass("btn btn-danger btn-xs dropdown-toggle");
        $('#status-button').html('Removed  <span class="caret"></span>');
      } else if(id == 4) {
        $('#status-button').removeClass();
        $('#status-button').addClass("btn btn-info btn-xs dropdown-toggle");
        $('#status-button').html('Completed  <span class="caret"></span>');

        // Load Close Job Note
        $('#closeModal').modal();
      }
      //$('#status-button-update').html(msg);
      $('#status-button-update').fadeOut(500);
    }
  })
}

var admin_user = "<?php echo $this->user->info->username ?>";
var staff_first_name = "<?php echo $this->user->info->first_name ?>";
var staff_last_name = "<?php echo $this->user->info->last_name ?>";
<?php if(isset($job->client_username)) : ?>
var client_user = "<?php echo $job->client_username ?>";
var client_first_name = "<?php echo $job->first_name ?>";
var client_last_name = "<?php echo $job->last_name ?>";
<?php else : ?>
var client_user = "<?php echo $job->guest_email ?>";
var client_first_name = "<?php echo $job->guest_email ?>"
var client_last_name = "";
<?php endif; ?>
var site_name = "<?php echo $this->settings->info->site_name ?>";


</script>
