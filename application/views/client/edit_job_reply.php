<div class="panel panel-default">
<div class="panel-body">

<h4><?php echo lang("ctn_441") ?></h4>
<?php echo form_open_multipart(site_url("client/edit_job_reply_pro/" . $reply->ID), array("class" => "form-horizontal")) ?>
<p><textarea name="body" id="job-body"><?php echo $reply->body ?></textarea></p>
<?php if($this->settings->info->enable_job_uploads) : ?>
                <hr>
                <h4><?php echo lang("ctn_437") ?></h4>
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
<p><input type="submit" class="btn btn-primary btn-sm form-control" value="<?php echo lang("ctn_442") ?>"></p>
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
</script>