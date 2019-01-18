<div class="white-area-content">

<?php $prioritys = array(0 => "<span class='label label-info'>".lang("ctn_429")."</span>", 1 => "<span class='label label-primary'>".lang("ctn_430")."</span>", 2=> "<span class='label label-warning'>".lang("ctn_431")."</span>", 3 => "<span class='label label-danger'>".lang("ctn_432")."</span>"); ?>
<?php $statuses = array(0=>lang("ctn_465"), 1 => lang("ctn_466"), 2 => lang("ctn_467"), 3 => 'Removed', 4 => 'Completed') ?>
<?php
if($job->status == 0) {
$statusbtn = "btn-info";
} elseif($job->status == 1) {
$statusbtn = "btn-primary";
} elseif($job->status == 2) {
$statusbtn = "btn-danger";
}
?>

<div class="row">
<div class="col-md-8">

<div class="panel panel-default">
<div class="panel-body">
<div class="media" style="overflow: visible !important;">
  <div class="media-left">
      <?php echo $this->common->get_user_display(array("username" => $job->client_username, "avatar" => $job->client_avatar, "online_timestamp" => $job->client_online_timestamp, "user" => false)) ?>
  </div>
  <div class="media-body" style="overflow: visible !important;">
<h3 class="media-title"><?php echo $job->title ?></h3>
<p><?php echo $job->body ?></p>
<?php if($this->settings->info->enable_job_uploads && $files->num_rows() > 0) : ?>
    <hr>
    <h4><?php echo lang("ctn_437") ?></h4>
    <div class="form-group">
            <div class="col-md-12">
                <table class="table table-bordered">
                <?php foreach($files->result() as $r) : ?>
                    <tr><td><a href="<?php echo base_url() . $this->settings->info->upload_path_relative . "/" . $r->upload_file_name ?>"><?php echo $r->upload_file_name ?></a></td><td><?php echo $r->file_size ?>kb</td><td>
                          <?php if( ($this->user->loggedin && $r->userid == $this->user->info->ID) || $this->common->has_permissions(array("admin", "job_manage", "job_worker"), $this->user)) : ?>
                                  <a href="<?php echo site_url("client/delete_file_attachment/" . $r->ID . "/" . $this->security->get_csrf_hash()) ?>" class="btn btn-danger btn-xs"><span class="glyphicon glyphicon-trash"></span></a>
                                <?php endif; ?></td></tr>
                <?php endforeach; ?>
                </table>
            </div>
    </div>
<?php endif; ?>
<div class="small-text">
<?php if($job_fields && $job->cat_name != 'Removal'): ?>
    <?php foreach($job_fields->result() as $r) : ?>
      <?php if(in_array($r->ID, explode(",", $user_field))) : ?>
      <?php if(!$r->hide_clientside) : ?>
        <?php if($r->type == 5) : ?>
          <p><strong><?php echo $r->name ?></strong><br /><?php echo $r->value ?></p>
            <?php if(isset($r->itemname) && !empty($r->itemname)) : ?>
                  <p><?php echo lang("ctn_680") ?>: <strong><?php echo $r->itemname ?></strong></p>
              <?php endif; ?>
              <?php if(isset($r->support) && !empty($r->support)) : ?>
                  <p><?php echo lang("ctn_681") ?>: <strong><?php echo date($this->settings->info->date_format, $r->support) ?></strong></p>
              <?php endif; ?>
              <?php if(isset($r->error) && !empty($r->error)) : ?>
                  <p><?php echo lang("ctn_682") ?>: <?php echo $r->error ?></p>
              <?php endif; ?>
        <?php else :?>
          <p><strong><?php echo $r->name ?></strong><br /><?php echo $r->value ?></p>
        <?php endif; ?>
      <?php endif; ?>
      <?php endif; ?>
    <?php endforeach; ?>
  <?php endif; ?>
  </div>

  </div>
  </div><!-- end media -->

</div>
</div>

</div>
<div class="col-md-4" style="display: none;">

<div class="panel panel-default">
<div class="panel-body">

  <p><?php echo lang("ctn_611") ?>: <?php echo $job->ID ?></p>
    <p><?php echo lang("ctn_468") ?>: <?php if(isset($job->client_username)) : ?><a href="<?php echo site_url("profile/" . $job->client_username) ?>"><?php echo $job->client_username ?></a> <?php else : ?><strong><?php echo $job->guest_email ?> [<?php echo lang("ctn_469") ?>]</strong><?php endif; ?></p>
    <p><?php echo lang("ctn_470") ?>: <?php echo date($this->settings->info->date_format, $job->timestamp); ?></p>
    <p><?php echo lang("ctn_428") ?> <?php echo $prioritys[$job->priority] ?></p>
    <p><?php echo lang("ctn_471") ?>: <?php echo date($this->settings->info->date_format, $job->last_reply_timestamp) ?> <?php if(isset($job->lr_username)) : ?>by <a href="<?php echo site_url("profile/" . $job->lr_username) ?>"><?php echo $job->lr_username ?></a><?php endif; ?> </p>
    <p><?php echo lang("ctn_462") ?>: <?php echo $job->cat_name ?></p>
    <p><button class="btn <?php echo $statusbtn ?> btn-xs" type="button" id="status-button" ><?php echo $statuses[$job->status] ?></button></p>
    <?php if($this->settings->info->enable_job_edit) : ?>
    <hr>
    <p><a href="<?php echo site_url("client/edit_job/" . $job->ID) ?>" class="btn btn-warning btn-xs" data-toggle="tooltip" data-placement="right" title="<?php echo lang("ctn_55") ?>"><span class="glyphicon glyphicon-cog"></span></a></p>
  <?php endif; ?>
  <?php if($this->settings->info->job_rating) : ?>
    <hr>
    <div class="job-rating">
    <strong><?php echo lang("ctn_472") ?></strong><br />
    <?php for($i=1;$i<=5;$i++) : ?>
      <?php if($i > $job->rating) : ?>
        <span class="glyphicon glyphicon-star-empty click" id="job<?php echo $i ?>"></span>
      <?php else : ?>
        <span class="glyphicon glyphicon-star click" id="job<?php echo $i ?>"></span>
      <?php endif; ?>
    <?php endfor; ?>
    </div>
  <?php endif; ?>

</div>
</div>

</div>
</div>

</div>


<?php foreach($replies->result() as $r) : ?>
  <?php
    if($r->userid == 0 || $r->userid == $job->userid) {
      $class = "panel-primary";
    } else {
      $class = "panel-admin";
    }
  ?>
<div class="panel <?php echo $class ?>">
<div class="panel-body">
  <?php if( (isset($_SESSION['jobid']) && isset($_SESSION['jobpass']) && $r->userid == 0) || ($this->user->loggedin && $r->userid == $this->user->info->ID) || $this->common->has_permissions(array("admin", "job_manager", "job_worker"), $this->user)) : ?>
    <div class="job-reply-options">
    <a href="<?php echo site_url("client/edit_job_reply/" . $r->ID) ?>" class="btn btn-warning btn-xs" data-toggle="tooltip" data-placement="right" title="<?php echo lang("ctn_55") ?>"><span class="glyphicon glyphicon-cog"></span></a>
    <a href="<?php echo site_url("client/delete_job_reply/" . $r->ID . "/" . $this->security->get_csrf_hash()) ?>" class="btn btn-danger btn-xs" onclick="return confirm('<?php echo lang("ctn_317") ?>')" data-toggle="tooltip" data-placement="right" title="<?php echo lang("ctn_57") ?>"><span class="glyphicon glyphicon-trash"></span></a>
    </div>
  <?php endif; ?>
  <div class="media">
  <div class="media-left">
    <?php echo $this->common->get_user_display(array("username" => $r->username, "avatar" => $r->avatar, "online_timestamp" => $r->online_timestamp, "user" => false)) ?>
  </div>
  <div class="media-body">
    <h4 class="media-title"><?php if(isset($r->username)) : ?><a href="<?php echo site_url("profile/" . $r->username) ?>"><?php echo $r->username ?></a><?php else : ?><strong><?php echo $job->guest_email ?></strong><?php endif; ?></h4>
<p><?php echo $r->body ?></p>
<p class="small-text"><?php echo date($this->settings->info->date_format, $r->timestamp); ?></p>
<?php if($r->files && $this->settings->info->enable_job_uploads) : ?>
<?php $files = $this->jobs_model->get_reply_files($r->ID); ?>
<hr>
                <div class="form-group clearfix">
                        <label for="p-in" class="col-md-4 label-heading"><?php echo lang("ctn_437") ?></label>
                        <div class="col-md-8">
                            <table class="table table-bordered">
                            <?php foreach($files->result() as $r) : ?>
                                <tr><td><a href="<?php echo base_url() . $this->settings->info->upload_path_relative . "/" . $r->upload_file_name ?>"><?php echo $r->upload_file_name ?></a></td><td><?php echo $r->file_size ?>kb</td><td>
                                  <?php if($this->user->loggedin && $r->userid == $this->user->info->ID || $this->common->has_permissions(array("admin", "job_manager", "job_worker"), $this->user)) : ?>
                                  <a href="<?php echo site_url("client/delete_file_attachment/" . $r->ID . "/" . $this->security->get_csrf_hash()) ?>" class="btn btn-danger btn-xs"><span class="glyphicon glyphicon-trash"></span></a>
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
</div>
<?php endforeach; ?>

<div class="panel panel-default" style="display: none;">
<div class="panel-body">
<h4><?php echo lang("ctn_473") ?></h4>
<?php echo form_open_multipart(site_url("client/job_reply/" . $job->ID), array("class" => "form-horizontal")) ?>
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
<p><input type="submit" class="btn btn-primary btn-sm form-control" value="<?php echo lang("ctn_474") ?>"></p>
<?php echo form_close() ?>
</div>
</div>

<script type="text/javascript">

CKEDITOR.replace('job-body', { height: '100'});

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
        $('#status-button').addClass("btn btn-danger btn-xs dropdown-toggle");
        $('#status-button').html('<?php echo lang("ctn_467") ?>  <span class="caret"></span>');
      } else if(id == 3) {
        $('#status-button').removeClass();
        $('#status-button').addClass("btn btn-danger btn-xs dropdown-toggle");
        $('#status-button').html('Removed  <span class="caret"></span>');
      } else if(id == 4) {
        $('#status-button').removeClass();
        $('#status-button').addClass("btn btn-info btn-xs dropdown-toggle");
        $('#status-button').html('Completed  <span class="caret"></span>');
      }
      //$('#status-button-update').html(msg);
      $('#status-button-update').fadeOut(500);
    }
  })
}

$(document).ready(function() {

  var rated = 0;
  $('#job1').hover(function() {
    fill_stars(1);
  }, function() {
    empty_stars(5);
  });

  $('#job2').hover(function() {
    fill_stars(2);
  }, function() {
    empty_stars(5);
  });

  $('#job3').hover(function() {
    fill_stars(3);
  }, function() {
    empty_stars(5);
  });

  $('#job4').hover(function() {
    fill_stars(4);
  }, function() {
    empty_stars(5);
  });

  $('#job5').hover(function() {
    fill_stars(5);
  }, function() {
    empty_stars(5);
  });

  function fill_stars(stars)
  {
    for(var i = 0; i<=stars;i++) {
      $('#job'+i).removeClass("glyphicon glyphicon-star-empty");
      $('#job'+i).addClass("glyphicon glyphicon-star");
    }
  }

  function empty_stars(stars)
  {
    for(var i = 0; i<=stars;i++) {
      if(rated < i) {
        $('#job'+i).removeClass("glyphicon glyphicon-star");
        $('#job'+i).addClass("glyphicon glyphicon-star-empty");
      }
    }
  }



  $('#job1').click(function() {
    rate_job(1);
    fill_stars(1);
  });

  $('#job2').click(function() {
    rate_job(2);
    fill_stars(2);
  });

  $('#job3').click(function() {
    rate_job(3);
    fill_stars(3);
  });

  $('#job4').click(function() {
    rate_job(4);
    fill_stars(4);
  });

  $('#job5').click(function() {
    rate_job(5);
    fill_stars(5);
  });

  function rate_job(stars)
  {
    rated = stars;
    $.ajax({
      url: global_base_url + "client/rate_job/" + <?php echo $job->ID ?> + "/" + global_hash,
      type: "get",
      data: {
        rating : stars
      },
      success: function(msg) {

      }
    });
  }
});

</script>
