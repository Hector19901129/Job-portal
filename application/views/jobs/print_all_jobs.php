<!DOCTYPE html>
<html lang="en">
    <head>
        <title><?php if(isset($page_title)) : ?><?php echo $page_title ?> - <?php endif; ?><?php echo $this->settings->info->site_name ?></title>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Bootstrap -->
        <link href="<?php echo base_url();?>bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
        <link href="<?php echo base_url();?>bootstrap/css/bootstrap-theme.min.css" rel="stylesheet" media="screen">

         <!-- Styles -->
        <link href="<?php echo base_url();?>styles/main.css" rel="stylesheet" type="text/css">
        <link href="<?php echo base_url();?>styles/dashboard.css" rel="stylesheet" type="text/css">
        <link href="<?php echo base_url();?>styles/responsive.css" rel="stylesheet" type="text/css">
        <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,500,600,700' rel='stylesheet' type='text/css'>
        <link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/themes/smoothness/jquery-ui.css" />

        <!-- SCRIPTS -->
        <script type="text/javascript">
        var global_base_url = "<?php echo site_url('/') ?>";
        </script>
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
        <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>

        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/bs/dt-1.10.12/datatables.min.css"/>
        <script type="text/javascript" src="https://cdn.datatables.net/v/bs/dt-1.10.12/datatables.min.js"></script>

        <script type="text/javascript" src="<?php echo base_url() ?>scripts/custom/global.js"></script>

        <script type="text/javascript">
          $.widget.bridge('uitooltip', $.ui.tooltip);
        </script>
        <script src="<?php echo base_url();?>bootstrap/js/bootstrap.min.js"></script>


        <!-- Favicon: http://realfavicongenerator.net -->
        <link rel="apple-touch-icon" sizes="57x57" href="<?php echo base_url() ?>images/favicon/apple-touch-icon-57x57.png">
        <link rel="apple-touch-icon" sizes="60x60" href="<?php echo base_url() ?>images/favicon/apple-touch-icon-60x60.png">
        <link rel="apple-touch-icon" sizes="72x72" href="<?php echo base_url() ?>images/favicon/apple-touch-icon-72x72.png">
        <link rel="apple-touch-icon" sizes="76x76" href="<?php echo base_url() ?>images/favicon/apple-touch-icon-76x76.png">
        <link rel="icon" type="image/png" href="<?php echo base_url() ?>images/favicon/favicon-32x32.png" sizes="32x32">
        <link rel="icon" type="image/png" href="<?php echo base_url() ?>images/favicon/favicon-16x16.png" sizes="16x16">
        <link rel="manifest" href="<?php echo base_url() ?>images/favicon/manifest.json">
        <link rel="mask-icon" href="<?php echo base_url() ?>images/favicon/safari-pinned-tab.svg" color="#5bbad5">
        <link rel="shortcut icon" href="<?php echo base_url() ?>images/favicon/favicon.ico">
        <meta name="msapplication-TileColor" content="#da532c">
        <meta name="msapplication-config" content="<?php echo base_url() ?>images/favicon/browserconfig.xml">
        <meta name="theme-color" content="#ffffff">


        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
          <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
        <![endif]-->

        <script type="text/javascript">
          $.widget.bridge('uitooltip', $.ui.tooltip);
        </script>
        <script type="text/javascript">
            $(document).ready(function() {
              $('[data-toggle="tooltip"]').tooltip();
            });
        </script>

        <!-- CODE INCLUDES -->
        <?php if(isset($cssincludes)) : ?>
            <?php echo $cssincludes ?>
        <?php endif; ?>
        <style>
          @media all {
          .page-break { display: none; }
          }

          @media print {
          .page-break { display: block; page-break-before: always; }
          }
        </style>
    </head>
    <body>
    <?php foreach($print_array as $i => $r1){
      ?>
        <div class="container" <?php echo $i != 0 ? "style = 'padding-top:30px'" : '' ?>>
        
        <div class="row">
        <div class="col-md-12">
        <div class="white-area-content">



        <?php $prioritys = array(0 => "<span class='label label-info'>".lang("ctn_429")."</span>", 1 => "<span class='label label-primary'>".lang("ctn_430")."</span>", 2=> "<span class='label label-warning'>".lang("ctn_431")."</span>", 3 => "<span class='label label-danger'>".lang("ctn_432")."</span>"); ?>
        <?php $statuses = array(0=>lang("ctn_465"), 1 => lang("ctn_466"), 2 => lang("ctn_467"), 3 => 'Removed', 4 => 'Completed') ?>
        <?php
        if($r1["job"]->status == 0) {
        $statusbtn = "btn-info";
        } elseif($r1["job"]->status == 1) {
        $statusbtn = "btn-primary";
        } elseif($r1["job"]->status == 2) {
        $statusbtn = "btn-danger";
        }
        ?>
        <div class="panel panel-default">
        <div class="panel-body">

        <div class="row">
        <div class="col-md-8">
        <h3><?php echo $r1["job"]->title ?></h3>
        <p><?php echo $r1["job"]->body ?></p>
        <?php if(!empty($r1["job"]->notes) && $this->common->has_permissions(array("admin", "job_manager", "job_worker"), $this->user)) : ?>
        <hr>
        <p><?php echo lang("ctn_483") ?></p>
        <p><i><?php echo $r1["job"]->notes ?></i></p>
        <?php endif; ?>
        <?php if($this->settings->info->enable_job_uploads && $r1["files"]->num_rows() > 0) : ?>
            <hr>
            <h4><?php echo lang("ctn_437") ?></h4>
            <div class="form-group">
                    <div class="col-md-12">
                        <table class="table table-bordered">
                        <?php foreach($r1["files"]->result() as $r) : ?>
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
        <?php if($r1["job_fields"]) : ?>
            <?php foreach($r1["job_fields"]->result() as $r) : ?>
              <p><strong><?php echo $r->name ?></strong><br /><?php echo $r->value ?></p>
            <?php endforeach; ?>
          <?php endif; ?>
          </div>
          <hr>

        <div class="media" style="overflow: visible !important;">
          <div class="media-left">
              <?php echo $this->common->get_user_display(array("username" => $r1["job"]->client_username, "avatar" => $r1["job"]->client_avatar, "online_timestamp" => $r1["job"]->client_online_timestamp, "user" => false)) ?>
          </div>
          <div class="media-body" style="overflow: visible !important;">
            <p><?php echo lang("ctn_611") ?>: <?php echo $r1["job"]->ID ?></p>
            <p><?php echo lang("ctn_468") ?>: <?php if(isset($r1["job"]->client_username)) : ?><a href="<?php echo site_url("profile/" . $r1["job"]->client_username) ?>"><?php echo $r1["job"]->client_username ?></a> <?php else : ?> <?php echo lang("ctn_469") ?>: <?php echo $r1["job"]->guest_email ?><?php endif; ?></p>

              <div class=" small-text">
                <table class="table">
                <tr><td><?php echo lang("ctn_25") ?></td><td><?php echo $r1["job"]->client_username ?></td></tr>
                <tr><td><?php echo lang("ctn_24") ?></td><td><?php echo $r1["job"]->client_email ?></td></tr>
                <tr><td><?php echo lang("ctn_81") ?></td><td><?php echo $r1["job"]->first_name ?> <?php echo $r1["job"]->last_name ?></td></tr>
                <?php if($r1["user_fields"]) : ?>
                <?php foreach($r1["user_fields"]->result() as $r) : ?>
                  <tr><td><?php echo $r->name ?></td><td><?php echo $r->value ?></td></tr>
                <?php endforeach; ?>
                <?php endif; ?>
                </table>

            </div>
            <p><?php echo lang("ctn_470") ?>: <?php echo date($this->settings->info->date_format, $r1["job"]->timestamp); ?></p>
            <p><?php echo lang("ctn_428") ?> <?php echo $prioritys[$r1["job"]->priority] ?></p>
            <p><?php echo lang("ctn_471") ?>: <?php echo date($this->settings->info->date_format, $r1["job"]->last_reply_timestamp) ?> <?php if(isset($r1["job"]->lr_username)) : ?><?php echo lang("ctn_602") ?> <a href="<?php echo site_url("profile/" . $r1["job"]->lr_username) ?>"><?php echo $r1["job"]->lr_username ?></a><?php endif; ?> </p>

            <p><?php echo lang("ctn_603") ?>: <?php if(isset($r1["job"]->username)) : ?><a href="<?php echo site_url("profile/" . $r1["job"]->username) ?>"><?php echo $r1["job"]->username ?></a><?php else : ?><?php echo lang("ctn_46") ?> <a href="<?php echo site_url("jobs/assign_user/" . $r1["job"]->ID . "/" . $this->security->get_csrf_hash()) ?>" class="btn btn-primary btn-xs"><?php echo lang("ctn_604") ?></a><?php endif; ?></p>
            <p><?php echo lang("ctn_462") ?>: <a href=""><?php echo $r1["job"]->cat_name ?></a></p>
            <?php if($this->common->has_permissions(array("admin", "job_manager", "job_worker"), $this->user)) : ?>

          <p>Job Status: <?php echo $statuses[$r1["job"]->status] ?></p>
          <?php if($this->settings->info->job_rating) : ?>
          <p>TIcket Rating: <?php echo $r1["job"]->rating ?></p>
      <?php endif; ?>
            <hr>
          <?php endif; ?>

          </div>
        </div>

        </div>
        </div>

        </div>
        </div>

        </div>


        <?php foreach($r1["replies"]->result() as $r) : ?>
          <div class="white-area-content content-separator">

        <p><?php echo $this->common->get_user_display(array("username" => $r->username, "avatar" => $r->avatar, "online_timestamp" => $r->online_timestamp,"user" => false)) ?> <a href="<?php echo site_url("profile/" . $r->username) ?>"><?php echo $r->username ?></a></p>
        <p><?php echo $r->body ?></p>
        <p class="small-text"><?php echo date($this->settings->info->date_format, $r->timestamp); ?></p>
        <?php if($r->files && $this->settings->info->enable_job_uploads) : ?>
        <?php $files = $this->jobs_model->get_reply_files($r->ID); ?>
        <hr>
                        <div class="form-group clearfix">
                                <label for="p-in" class="col-md-4 label-heading"><?php echo lang("ctn_437") ?></label>
                                <div class="col-md-8">
                                    <table class="table table-bordered">
                                    <?php foreach($r1["files"]->result() as $r) : ?>
                                        <tr><td><a href="<?php echo base_url() . $this->settings->info->upload_path_relative . "/" . $r->upload_file_name ?>"><?php echo $r->upload_file_name ?></a></td><td><?php echo $r->file_size ?>kb</td><td>
                                          <?php if($r->userid == $this->user->info->ID || $this->common->has_permissions(array("admin", "job_manager", "job_worker"), $this->user)) : ?>

                                        <?php endif; ?>
                                        </td></tr>
                                    <?php endforeach; ?>
                                    </table>
                                </div>
                        </div>
        <?php endif; ?>
        <hr>
        </div>
        <?php endforeach; ?>

        
        </div>
        </div>
        
        </div>
        <?php if($i != sizeof($print_array) - 1) : ?> 
        <div class="page-break"></div>
      <?php endif; ?>
        <?php }?>
        <script type="text/javascript">
        $(document).ready(function() {
        $('#cannedr').change(function() {
          var body = $('#cannedr').val();

          body = body.replace('[USER]', client_user);
          body = body.replace('[ADMIN_NAME]', admin_user);
          body = body.replace('[SITE_NAME]', site_name);


          CKEDITOR.instances['job-body'].setData(body);
        });
        });
        CKEDITOR.replace('job-body', { height: '200'});

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

        var admin_user = "<?php echo $this->user->info->username ?>";
        <?php if(isset($r1["job"]->client_username)) : ?>
        var client_user = "<?php echo $r1["job"]->client_username ?>";
        <?php else : ?>
        var client_user = "<?php echo $r1["job"]->guest_email ?>";
        <?php endif; ?>
        var site_name = "<?php echo $this->settings->info->site_name ?>";


        </script>
    </body>
</html>
