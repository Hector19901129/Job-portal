<div class="row">
<div class="col-md-8">
  <?php $kr = $this->input->get('R');
  if(empty($kr)){
    $kr = 0;
  }
  ?>
<h3 class="home-label"><?php if($kr == 1){
  echo 'Remove A Sign';
} elseif($kr == 2){
  echo 'Add Task';
} else { echo lang("ctn_453"); } ?></h3>
<div class="panel panel-default">
<div class="panel-body">

<?php echo form_open_multipart(site_url("client/add_pro"), array("class" => "form-horizontal")) ?>
        <div class="form-group">
                <label for="p-in" class="col-md-3 label-heading"><?php echo lang("ctn_427") ?></label>
                <div class="col-md-9 ui-front">
                    <input type="text" class="form-control" id='article-title' name="title" value="">
                </div>
        </div>
        <?php if(!$this->user->loggedin && $this->settings->info->enable_job_guests) : ?>
            <div class="form-group">
                    <label for="p-in" class="col-md-3 label-heading"><?php echo lang("ctn_454") ?></label>
                    <div class="col-md-9">
                        <input type="text" class="form-control" name="guest_email">
                    </div>
            </div>
        <?php endif; ?>
        <div class="form-group" style="display: none;">
                <label for="p-in" class="col-md-3 label-heading"><?php echo lang("ctn_428") ?></label>
                <div class="col-md-9 ui-front">
                    <select name="priority" class="form-control" value="2">
                    <option value="0"><?php echo lang("ctn_429") ?></option>
                    <option value="1"><?php echo lang("ctn_430") ?></option>
                    <option value="2" selected="selected"><?php echo lang("ctn_431") ?></option>
                    <option value="3"><?php echo lang("ctn_432") ?></option>
                    </select>
                </div>
        </div>
        <div class="form-group" style="display: none;">
                <label for="p-in" class="col-md-3 label-heading"><?php echo lang("ctn_433") ?></label>
                <div class="col-md-9 ui-front">
                    <select name="catid" id="parent_cat" class="form-control">
                        <?php foreach($categories->result() as $r) : ?>
                            <option value="<?php echo $r->ID; ?>"><?php echo $r->name ?></option>
                        <?php endforeach; ?>
                    </select>
                    <div id="sub_cats"></div>
                </div>
        </div>
        <div class="form-group" style="display: none;">
            <label for="p-in" class="col-md-3 label-heading"></label>
                <div class="col-md-9 ui-front help-block" id='cat-desc'>

                </div>
        </div>
        <div class="form-group" style="display: none;">
                <label for="p-in" class="col-md-3 label-heading"><?php echo lang("ctn_435") ?></label>
                <div class="col-md-9 ui-front">
                    <textarea name="body" id="job-body"><?php if($kr == 1){
                      echo 'This is a new removal';
                    } elseif($kr == 2) { echo 'This is a new task'; } else { echo 'This is a new job'; } ?></textarea>
                </div>
        </div>
        <?php foreach($fields->result() as $r) : ?>
             <?php if(!$r->hide_clientside && empty($kr)) : ?>
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
            <?php endif; ?>
                <?php endforeach; ?>
        <div id="custom_fields_extra"></div>
        <hr <?php if(!empty($kr)){
          echo 'style="display: none;"';
        } ?> >
        <div class="form-group">
            
            <div class="col-md-10" style="text-align:left"><span>By adding this job you accept and agree to Sign Creators Terms & Conditions</span></div>
            
        </div>
        <?php if($this->settings->info->enable_job_uploads && ($kr == 0 || $kr == 2)) : ?>
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
        <?php if($this->settings->info->captcha_job) : ?>
            <?php if(!$this->settings->info->google_recaptcha) : ?>
                <div class="form-group">

                    <label for="name-in" class="col-md-3 label-heading"><?php echo lang("ctn_220") ?></label>
                    <div class="col-md-9">
                        <p><?php echo $cap['image'] ?></p>
                        <input type="text" class="form-control" id="captcha-in" name="captcha" placeholder="<?php echo lang("ctn_306") ?>" value="">
                    </div>
                </div>
                <?php else: ?>
                    <div class="form-group">

                    <label for="name-in" class="col-md-3 label-heading"><?php echo lang("ctn_220") ?></label>
                    <div class="col-md-9">
                        <div class="g-recaptcha" data-sitekey="<?php echo $this->settings->info->google_recaptcha_key ?>"></div>
                    </div>
                </div>
                <?php endif ?>
        <?php endif; ?>
        <input type="submit" class="btn btn-primary btn-sm form-control" value="<?php if($kr == 1){
          echo 'Book Removal';
        } else { echo lang("ctn_455"); } ?>" />
        <?php echo form_close() ?>
</div>
</div>

</div>

</div>
<script type="text/javascript">

$(document).ready(function() {
  $("#parent_cat").val(<?php echo (int)$kr + 1; ?>);

  load_custom_fields(<?php echo (int)$kr + 1; ?>);

	$('#article-title').autocomplete({
  	delay : 300,
  	minLength: 2,
  	source: function (request, response) {
         $.ajax({
             type: "GET",
             url: global_base_url + "client/get_articles",
             data: {
             		query : request.term
             },
             success: function (msg) {
             	if(msg != 0) {
                 $('#knowledgebase').html(msg);
             	}
             }
         });
      }
  });
    <?php foreach($fields->result() as $r) : ?>
    <?php if($r->type == 1) : ?>
    CKEDITOR.replace('field_id_<?php echo $r->ID ?>', { height: '100'});
    <?php endif; ?>
    <?php endforeach; ?>
    CKEDITOR.replace('job-body', { height: '200'});

    $('#parent_cat').change(function() {
        // Get any sub cats

        var parent_cat = $('#parent_cat').val();
        get_cat_desc(parent_cat);
        $.ajax({
            url: global_base_url + "client/get_sub_cats/" + parent_cat,
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
        get_cat_desc(catid);
        load_custom_fields(catid);
    });

    function load_custom_fields(parent_cat) {
        $.ajax({
            url: global_base_url + "client/get_custom_fields/" + parent_cat,
            type: "get",
            data: {
            },
            success: function(msg) {
                $('#custom_fields_extra').html(msg);
            }
        });
    }

});

function get_cat_desc(id)
{
    $.ajax({
            url: global_base_url + "client/get_category_description/" + id,
            type: "get",
            data: {
            },
            success: function(msg) {
                if(!msg) return;
                $('#cat-desc').html(msg);
            }
        });
}

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
