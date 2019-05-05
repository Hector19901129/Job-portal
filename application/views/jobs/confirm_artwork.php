<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Confirmation of New Artwork</title>
        <meta charset="UTF-8" />
        
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Bootstrap -->
        <link href="<?php echo base_url();?>bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
        <link href="<?php echo base_url();?>bootstrap/css/bootstrap-theme.min.css" rel="stylesheet" media="screen">

         <!-- Styles -->
        <link href="<?php echo base_url();?>styles/layouts/titan/main.css" rel="stylesheet" type="text/css">
        <link href="<?php echo base_url();?>styles/layouts/titan/dashboard.css" rel="stylesheet" type="text/css">
        <link href="<?php echo base_url();?>styles/layouts/titan/responsive.css" rel="stylesheet" type="text/css">
        <link href="<?php echo base_url();?>styles/elements.css" rel="stylesheet" type="text/css">
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

        <script src="//cdn.ckeditor.com/4.6.2/standard/ckeditor.js"></script>
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
        <style>
        textarea
        {
            width:100%;
        }
        .textwrapper
        {
            margin:5px 0;
            padding:3px;
        }   
        .left-div{
            top:0;
            bottom:0;
            left:0;
            right:0;
            overflow:hidden;
            z-index:-1; /* Remove this line if it's not going to be a background! */
        }
        label{
            margin-top: 10px;
        }
    </style>
    <script type="text/javascript" src="https://mozilla.github.io/pdf.js/build/pdf.js"></script> 
    </head>
    
    <body>

    <nav class="navbar navbar-header2 navbar-inverse navbar-fixed-top">
      <div class="container-fluid">
        <div class="navbar-header">
         <?php if(!$this->settings->info->logo_option) : ?>
          <a class="navbar-brand" href="<?php echo site_url() ?>" title="<?php echo $this->settings->info->site_name ?>"><?php echo $this->settings->info->site_name ?></a>
          <?php else : ?>
            <a class="navbar-brand-two" href="<?php echo site_url() ?>" title="<?php echo $this->settings->info->site_name ?>"><img src="<?php echo base_url() ?><?php echo $this->settings->info->upload_path_relative ?>/<?php echo $this->settings->info->site_logo ?>" width="123" height="32"></a>
          <?php endif; ?>
        </div>

      </div>
    </nav>

    <div class="container-fluid">
      <div class="row">
        <div class="col-md-6">
         <div class="panel panel-default">
          <div class="panel-body" style="position: relative;height:93vh">
            <div class="media" style="overflow: visible !important; margin: 0 auto;">
                <div style="width: min-content;margin: auto;">
                    <?php foreach($files->result() as $file){ ?>
                        <iframe src="http://docs.google.com/viewer?url=https://scportal.com.au/uploads/<?php echo $file->upload_file_name ?>&embedded=true" style="border: none;height:90vh;width:50%"></iframe>
                    <?php } ?>
                </div>
            </div>
          </div>
         </div>
        </div> <!-- End media -->

        <div class="col-md-6">
         <div class="panel panel-default">
          <div class="panel-body" style="position: relative;height:93vh">
        
            <?php echo form_open_multipart("", array("class" => "form-horizontal")) ?>
                    <div class="form-group">
                        <label for="p-in" class="col-md-3 label-heading"><?php echo "Property address" ?></label>
                        <div class="col-md-9 ui-front">
                            <h5><?php echo $title ?></h5>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="p-in" class="col-md-3 label-heading"><?php echo "Client Name" ?></label>
                        <div class="col-md-9">
                            <h5><?php echo $client_name ?></h5>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="p-in" class="col-md-3 label-heading"><?php echo "Email" ?></label>
                        <div class="col-md-9">
                            <h5><?php echo $email ?></h5>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="p-in" class="col-md-3 label-heading"><?php echo "Sign Type" ?></label>
                        <div class="col-md-9">
                            <h5><?php echo $sign_type ?></h5>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="p-in" class="col-md-3 label-heading"><?php echo "Comment" ?></label>
                        <div class="col-md-9">
                            <div class="textwrapper"><textarea cols="2" rows="10" placeholder="If you are declining this artwork please supply notes. A new file will be created" name="comment" id="comment"></textarea></div>
                        </div>
                    </div>
                    <p class="">
                        <label for="p-in" class="col-md-3 label-heading"></label>
                        <div class="col-md-9">
                            <input type="button" class="btn btn-success btn-lg form-control" value="Approve" style= "width :200px;height:52px" id="approve">
                            <input type="button" class="btn btn-danger btn-lg form-control" value="Decline" style= "width :200px;height:52px" id="decline">
                        </div>
                        
                    </p>
                    <input type="hidden" value="<?php echo $jobid ?>" id="jobid">
            <?php echo form_close() ?>
            </div>
         </div>
        </div> <!-- End media -->
      </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function() {
            var w = 850 * 0.6;
            $("iframe").width("'"+w+"'px");
            $('.nav-sidebar li').on('shown.bs.collapse', function () {
            $(this).find(".glyphicon-menu-right")
                    .removeClass("glyphicon-menu-right")
                    .addClass("glyphicon-menu-down");
            });
            $('.nav-sidebar li').on('hidden.bs.collapse', function () {
            $(this).find(".glyphicon-menu-down")
                    .removeClass("glyphicon-menu-down")
                    .addClass("glyphicon-menu-right");
            });
            $("#approve").click(function() {
                $.post("<?php echo site_url("jobs/save_status") ?>", 
                {'<?php echo $this->security->get_csrf_token_name(); ?>': '<?php echo $this->security->get_csrf_hash(); ?>', 
                    'jobid' : $("#jobid").val(), 'approve' : 1, 'comment' : ''}, 
                    function(result){
                        alert("Successfully Done!");
                        document.location.reload();

                });
            });
            $("#decline").click(function() {
                if($("#comment").val() == undefined || $("#comment").val() == "") {
                    alert("Must input text for decline!");
                    return;
                }
                $.post("<?php echo site_url("jobs/save_status") ?>", 
                {'<?php echo $this->security->get_csrf_token_name(); ?>': '<?php echo $this->security->get_csrf_hash(); ?>', 
                    'jobid': $("#jobid").val(), 'approve': 0, 'comment': $("#comment").val()}, 
                    function(result){
                        alert("Successfully Done!");
                        document.location.reload();
                });
            });
        });
        var url = 'https://scportal.com.au/uploads/<?php echo $file->upload_file_name ?>';
        //
        console.log(url);
        // The workerSrc property shall be specified.
        //
        pdfjsLib.GlobalWorkerOptions.workerSrc = 'https://mozilla.github.io/pdf.js/build/pdf.worker.js';
        //
        // Asynchronous download PDF
        //
        var loadingTask = pdfjsLib.getDocument(url);
        loadingTask.promise.then(function(pdf) {
            //
            // Fetch the first page
            //
            pdf.getPage(1).then(function(page) {
                var scale = 1.5;
                var viewport = page.getViewport({ scale: scale, });
                console.log(viewport.height);
                console.log(viewport.width);
                scale = parseFloat(viewport.height / viewport.width);
                console.log(scale);
                var w = parseInt(808 / scale);
                $("iframe").width(w);
                //
                // Prepare canvas using PDF page dimensions
                //

                //
                // Render PDF page into canvas context
                //
                
            });
        });
    </script>


    </body>
</html>
