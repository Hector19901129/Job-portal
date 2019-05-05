<script src="<?php echo base_url();?>scripts/custom/get_usernames.js"></script>
<div class="white-area-content">

<div class="db-header clearfix">
    <div class="page-header-title"> <span class="glyphicon glyphicon-send"></span> <?php echo lang("ctn_518") ?></div>
    <div class="db-header-extra">
</div>
</div>

<div class="panel panel-default">
<div class="panel-body">

<?php echo form_open_multipart(site_url("jobs/save_edited_artwork/" . $job->ID), array("class" => "form-horizontal")) ?>
        <div class="form-group">
                <label for="p-in" class="col-md-3 label-heading"><?php echo "Property Address" ?></label>
                <div class="col-md-9 ui-front">
                    <input type="text" class="form-control" name="title" value="<?php echo $job->title ?>">
                </div>
        </div>
        <div class="form-group">
                <label for="p-in" class="col-md-3 label-heading"><?php echo "Client Name" ?></label>
                <div class="col-md-9">
                    <input type="text" class="form-control" name="client_name" id="username-search" value="<?php echo $job->client_username ?>">
                </div>
        </div>
        <?php if($this->settings->info->enable_job_guests) : ?>
            <div class="form-group">
                    <label for="p-in" class="col-md-3 label-heading"><?php echo "Email" ?></label>
                    <div class="col-md-9">
                        <input type="text" class="form-control" name="email" value="<?php echo $job->guest_email ?>">
                    </div>
            </div>
        <?php endif; ?>
        <div class="form-group">
                <label for="p-in" class="col-md-3 label-heading"><?php echo "Sign Type" ?></label>
                <div class="col-md-4 ui-front">
                    <select name="sign_type" class="form-control">
                    <option value="0" <?php if($job->categoryid == 0) echo "selected" ?>><?php echo "sign1" ?></option>
                    <option value="1" <?php if($job->categoryid == 1) echo "selected" ?>><?php echo "sign2" ?></option>
                    <option value="2" <?php if($job->categoryid == 2) echo "selected" ?>><?php echo "sign3" ?></option>
                    </select>
                </div>
        </div>
        
        <hr>
        
        
        <hr>
        <?php if($this->settings->info->enable_job_uploads) : ?>
        <h4><?php echo lang("ctn_436") ?></h4>
                <div class="form-group">
                        <label for="p-in" class="col-md-4 label-heading"><?php echo lang("ctn_437") ?></label>
                        <div class="col-md-8">
                            <table class="table table-bordered">
                            <?php foreach($job_files->result() as $r) : ?>
                                <tr><td><a href="<?php echo base_url() . $this->settings->info->upload_path_relative . "/" . $r->upload_file_name ?>"><?php echo $r->upload_file_name ?></a></td><td><?php echo $r->file_size ?>kb</td><td><a href="<?php echo site_url("jobs/delete_file_attachment/" . $r->ID . "/" . $this->security->get_csrf_hash()) ?>" class="btn btn-danger btn-xs"><span class="glyphicon glyphicon-trash"></span></a></td></tr>
                            <?php endforeach; ?>
                            </table>
                        </div>
                </div>
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
        <input type="submit" class="btn btn-primary btn-sm form-control" value="<?php echo lang("ctn_599") ?>" />
<?php echo form_close() ?>
</div>
</div>
</div>
<script type="text/javascript">

$(document).ready(function() {
    <?php foreach($fields->result() as $r) : ?>
    <?php if($r->type == 1) : ?>
    CKEDITOR.replace('field_id_<?php echo $r->ID ?>', { height: '100'});
    <?php endif; ?>
    <?php endforeach; ?>
    CKEDITOR.replace('job-body', { height: '200'});
    CKEDITOR.replace('job-notes', { height: '100'});

    $('#parent_cat').change(function() {
        // Get any sub cats
        var parent_cat = $('#parent_cat').val();
        $.ajax({
            url: global_base_url + "jobs/get_sub_cats/" + parent_cat,
            type: "get",
            data: {
            },
            success: function(msg) {
                $('#sub_cats').html(msg);
                load_custom_fields(parent_cat);
            }
        });
    });

    $('#sub_cats').on("change", "#sub_cat", function() {
        var catid = $('#sub_cat').val();
        load_custom_fields(catid);
    });

    function load_custom_fields(parent_cat) {
        $.ajax({
            url: global_base_url + "jobs/get_custom_fields/" + parent_cat,
            type: "get",
            data: {
            },
            success: function(msg) {
                $('#custom_fields_extra').html(msg);
            }
        });
    }

});
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
</script>
