<div class="white-area-content">
<div class="db-header clearfix">
    <div class="page-header-title"> <span class="glyphicon glyphicon-user"></span> <?php echo lang("ctn_1") ?></div>
    <div class="db-header-extra"> 
</div>
</div>

<ol class="breadcrumb">
  <li><a href="<?php echo site_url() ?>"><?php echo lang("ctn_2") ?></a></li>
  <li><a href="<?php echo site_url("admin") ?>"><?php echo lang("ctn_1") ?></a></li>
  <li class="active"><?php echo lang("ctn_407") ?></li>
</ol>


<hr>

<div class="panel panel-default">
<div class="panel-body">
<?php echo form_open(site_url("admin/job_settings_pro"), array("class" => "form-horizontal")) ?>

<div class="form-group">
    <label for="name-in" class="col-sm-3"><?php echo lang("ctn_408") ?></label>
    <div class="col-sm-9">
    	<input type="checkbox" id="name-in" name="enable_job_uploads" value="1" <?php if($this->settings->info->enable_job_uploads) echo "checked" ?>>
    	<span class="help-block"><?php echo lang("ctn_409") ?></span>
    </div>
</div>
<div class="form-group">
    <label for="name-in" class="col-sm-3"><?php echo lang("ctn_410") ?></label>
    <div class="col-sm-9">
      <input type="checkbox" id="name-in" name="enable_job_guests" value="1" <?php if($this->settings->info->enable_job_guests) echo "checked" ?>>
      <span class="help-block"><?php echo lang("ctn_411") ?></span>
    </div>
</div>
<div class="form-group">
    <label for="name-in" class="col-sm-3"><?php echo lang("ctn_412") ?></label>
    <div class="col-sm-9">
      <input type="checkbox" id="name-in" name="enable_job_edit" value="1" <?php if($this->settings->info->enable_job_edit) echo "checked" ?>>
      <span class="help-block"><?php echo lang("ctn_413") ?></span>
    </div>
</div>
<div class="form-group">
    <label for="name-in" class="col-sm-3"><?php echo lang("ctn_414") ?></label>
    <div class="col-sm-9">
      <input type="checkbox" id="name-in" name="require_login" value="1" <?php if($this->settings->info->require_login) echo "checked" ?>>
      <span class="help-block"><?php echo lang("ctn_415") ?></span>
    </div>
</div>
<div class="form-group">
    <label for="name-in" class="col-sm-3"><?php echo lang("ctn_416") ?></label>
    <div class="col-sm-9">
      <input type="checkbox" id="name-in" name="job_rating" value="1" <?php if($this->settings->info->job_rating) echo "checked" ?>>
      <span class="help-block"><?php echo lang("ctn_417") ?></span>
    </div>
</div>
<div class="form-group">
    <label for="name-in" class="col-sm-3"><?php echo lang("ctn_671") ?></label>
    <div class="col-sm-9">
      <input type="checkbox" id="name-in" name="captcha_job" value="1" <?php if($this->settings->info->captcha_job) echo "checked" ?>>
      <span class="help-block"><?php echo lang("ctn_672") ?></span>
    </div>
</div>
<h4><?php echo lang("ctn_418") ?></h4>
<div class="form-group">
    <label for="name-in" class="col-sm-3"><?php echo lang("ctn_419") ?></label>
    <div class="col-sm-9">
      <select name="protocol">
        <option value="1" <?php if($this->settings->info->protocol) echo "selected" ?>>IMap</option>
      </select>
    </div>
</div>
<div class="form-group">
    <label for="name-in" class="col-sm-3"><?php echo lang("ctn_420") ?></label>
    <div class="col-sm-9">
      <input type="text" class="form-control" id="name-in" name="protocol_path" value="<?php echo $this->settings->info->protocol_path ?>">
    </div>
</div>
<div class="form-group">
    <label for="name-in" class="col-sm-3"><?php echo lang("ctn_421") ?></label>
    <div class="col-sm-9">
      <select name="protocol_ssl" class="form-control">
      <option value="0"><?php echo lang("ctn_54") ?></option>
      <option value="1" <?php if($this->settings->info->protocol_ssl) echo "selected" ?>><?php echo lang("ctn_53") ?></option>
      </select>
    </div>
</div>
<div class="form-group">
    <label for="name-in" class="col-sm-3"><?php echo lang("ctn_422") ?></label>
    <div class="col-sm-9">
      <input type="text" class="form-control" id="name-in" name="protocol_email" value="<?php echo $this->settings->info->protocol_email ?>">
      <span class="help-block"><?php echo lang("ctn_423") ?></span>
    </div>
</div>
<div class="form-group">
    <label for="name-in" class="col-sm-3"><?php echo lang("ctn_424") ?></label>
    <div class="col-sm-9">
      <input type="password" class="form-control" id="name-in" name="protocol_password" value="<?php echo $this->settings->info->protocol_password ?>">
    </div>
</div>
<div class="form-group">
    <label for="name-in" class="col-sm-3"><?php echo lang("ctn_425") ?></label>
    <div class="col-sm-9">
      <input type="text" class="form-control" id="name-in" name="job_title" value="<?php echo $this->settings->info->job_title ?>">
    </div>
</div>
<div class="form-group">
    <label for="name-in" class="col-sm-3"><?php echo lang("ctn_615") ?></label>
    <div class="col-sm-9">
      <select name="catid" class="form-control">
      <?php foreach($categories->result() as $r) : ?>
        <option value="<?php echo $r->ID ?>" <?php if($r->ID == $this->settings->info->default_category) echo "selected" ?>><?php echo $r->name ?></option>
      <?php endforeach; ?>
      </select>
      <span class="help-block"><?php echo lang("ctn_616") ?></span>
    </div>
</div>
<h3><?php echo lang("ctn_697") ?></h3>
<p><?php echo lang("ctn_698") ?></p>
<div class="form-group">
    <label for="name-in" class="col-sm-3"><?php echo lang("ctn_699") ?></label>
    <div class="col-sm-9">
      <input type="text" class="form-control" id="name-in" name="imap_job_string" value="<?php echo $this->settings->info->imap_job_string ?>">
      <span class="help-block"><?php echo lang("ctn_700") ?></span>
    </div>
</div>
<div class="form-group">
    <label for="name-in" class="col-sm-3"><?php echo lang("ctn_701") ?></label>
    <div class="col-sm-9">
      <input type="text" class="form-control" id="name-in" name="imap_reply_string" value="<?php echo $this->settings->info->imap_reply_string ?>">
      <span class="help-block"><?php echo lang("ctn_702") ?></span>
    </div>
</div>
<div class="form-group">
    <label for="name-in" class="col-sm-3"><?php echo lang("ctn_426") ?></label>
    <div class="col-sm-9">
      <strong><?php echo lang("ctn_617") ?></strong><br />
      wget <?php echo site_url("cron/job_replies") ?><br><br />
      <strong><?php echo lang("ctn_618") ?></strong><br />
      wget <?php echo site_url("cron/job_create") ?><br><br />
    </div>
</div>
<h3><?php echo lang("ctn_703") ?></h3>
<div class="form-group">
    <label for="name-in" class="col-sm-3"><?php echo lang("ctn_704") ?></label>
    <div class="col-sm-9">
      <input type="text" class="form-control" id="name-in" name="envato_personal_token" value="<?php echo $this->settings->info->envato_personal_token ?>">
      <span class="help-block"><?php echo lang("ctn_705") ?></span>
    </div>
</div>


<input type="submit" class="btn btn-primary form-control" value="<?php echo lang("ctn_13") ?>" />
<?php echo form_close() ?>

</div>
</div>
</div>