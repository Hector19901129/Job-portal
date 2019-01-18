<script src="<?php echo base_url();?>scripts/custom/get_usernames.js"></script>
<div class="white-area-content">

<div class="db-header clearfix">
    <div class="page-header-title"> <span class="glyphicon glyphicon-send"></span> <?php echo lang("ctn_557") ?></div>
    <div class="db-header-extra">
</div>
</div>

<div class="panel panel-default">
<div class="panel-body">

<?php echo form_open_multipart(site_url("jobs/add_pro"), array("class" => "form-horizontal")) ?>
        <div class="form-group">
                <label for="p-in" class="col-md-3 label-heading"><?php echo lang("ctn_427") ?></label>
                <div class="col-md-9 ui-front">
                    <input type="text" class="form-control" name="title" value="">
                </div>
        </div>
        <div class="form-group">
                <label for="p-in" class="col-md-3 label-heading"><?php echo lang("ctn_558") ?></label>
                <div class="col-md-9">
                    <input type="text" class="form-control" name="client" id="username-search" placeholder="<?php echo lang("ctn_559") ?>">
                </div>
        </div>
        <?php if($this->settings->info->enable_job_guests) : ?>
            <div class="form-group">
                    <label for="p-in" class="col-md-3 label-heading"><?php echo lang("ctn_551") ?></label>
                    <div class="col-md-9">
                        <input type="text" class="form-control" name="guest_email">
                        <span class="help-block"><?php echo lang("ctn_560") ?></span>
                    </div>
            </div>
        <?php endif; ?>
        <div class="form-group">
                <label for="p-in" class="col-md-3 label-heading"><?php echo lang("ctn_561") ?></label>
                <div class="col-md-9">
                    <input type="text" class="form-control" name="assigned" id="username-search2" placeholder="Enter username ...">
                </div>
        </div>
        <div class="form-group">
                <label for="p-in" class="col-md-3 label-heading"><?php echo lang("ctn_562") ?></label>
                <div class="col-md-4 ui-front">
                    <select name="priority" class="form-control">
                    <option value="0"><?php echo lang("ctn_429") ?></option>
                    <option value="1"><?php echo lang("ctn_430") ?></option>
                    <option value="2"><?php echo lang("ctn_431") ?></option>
                    <option value="3"><?php echo lang("ctn_432") ?></option>
                    </select>
                </div>
        </div>
         <div class="form-group">
                <label for="p-in" class="col-md-3"><?php echo lang("ctn_563") ?></label>
                <div class="col-md-4 ui-front">
                    <select name="status" class="form-control">
                    <option value="0"><?php echo lang("ctn_465") ?></option>
                    <option value="1"><?php echo lang("ctn_466") ?></option>
                    <option value="2"><?php echo lang("ctn_467") ?></option>
                    <option value="3">Removed</option>
                    <option value="4">Completed</option>                                                          
                    </select>
                </div>
        </div>
        <div class="form-group">
                <label for="p-in" class="col-md-3 label-heading"><?php echo lang("ctn_433") ?></label>
                <div class="col-md-9 ui-front">
                    <select name="catid" id="parent_cat" class="form-control">
                        <option value="0"><?php echo lang("ctn_434") ?></option>
                        <?php foreach($categories->result() as $r) : ?>
                            <option value="<?php echo $r->ID ?>"><?php echo $r->name ?></option>
                        <?php endforeach; ?>
                    </select>
                    <div id="sub_cats"></div>
                </div>
        </div>
        <div class="form-group">
                <label for="p-in" class="col-md-3 label-heading"><?php echo lang("ctn_435") ?></label>
                <div class="col-md-9 ui-front">
                    <textarea name="body" id="job-body"></textarea>
                </div>
        </div>
        <div class="form-group yellow-bg">
                <label for="p-in" class="col-md-3 label-heading"><?php echo lang("ctn_564") ?></label>
                <div class="col-md-9 ui-front">
                    <textarea name="notes" id="job-notes"></textarea>
                    <span class="help-block"><?php echo lang("ctn_565") ?></span>
                </div>
        </div>
        <hr>
        <?php foreach($fields->result() as $r) : ?>
                    <div class="form-group">

                        <label for="name-in" class="col-md-3 label-heading"><?php echo $r->name ?> <?php if($r->required) : ?>*<?php endif; ?></label>
                        <div class="col-md-9">
                            <?php if($r->type == 0 || $r->type == 5) : ?>
                                <input type="text" class="form-control" id="name-in" name="cf_<?php echo $r->ID ?>">
                            <?php elseif($r->type == 1) : ?>
                                <textarea name="cf_<?php echo $r->ID ?>" id="field_id_<?php echo $r->ID ?>"></textarea>
                            <?php elseif($r->type == 2) : ?>
                                 <?php $options = explode(",", $r->options); ?>
                                <?php if(count($options) > 0) : ?>
                                    <?php foreach($options as $k=>$v) : ?>
                                    <div class="form-group"><input type="checkbox" name="cf_cb_<?php echo $r->ID ?>_<?php echo $k ?>" value="1"> <?php echo $v ?></div>
                                    <?php endforeach; ?>
                                <?php endif; ?>
                            <?php elseif($r->type == 3) : ?>
                                <?php $options = explode(",", $r->options); ?>
                                <?php if(count($options) > 0) : ?>
                                    <?php foreach($options as $k=>$v) : ?>
                                    <div class="form-group"><input type="radio" name="cf_radio_<?php echo $r->ID ?>" value="<?php echo $k ?>"> <?php echo $v ?></div>
                                    <?php endforeach; ?>
                                <?php endif; ?>
                            <?php elseif($r->type == 4) : ?>
                                <?php $options = explode(",", $r->options); ?>
                                <?php if(count($options) > 0) : ?>
                                    <select name="cf_<?php echo $r->ID ?>" class="form-control">
                                    <?php foreach($options as $k=>$v) : ?>
                                    <option value="<?php echo $k ?>"><?php echo $v ?></option>
                                    <?php endforeach; ?>
                                    </select>
                                <?php endif; ?>
                            <?php endif; ?>
                            <span class="help-block"><?php echo $r->help_text ?></span>
                        </div>
                </div>
                <?php endforeach; ?>
        <div id="custom_fields_extra"></div>
        <hr>
        <?php if($this->settings->info->enable_job_uploads) : ?>
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
        <input type="submit" class="btn btn-primary btn-sm form-control" value="<?php echo lang("ctn_566") ?>" />
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
