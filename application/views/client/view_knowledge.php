<div class="panel panel-default">
<div class="panel-heading"><?php echo $article->title ?></div>
<div class="panel-body">
<?php echo $article->body ?>
<p class="small-text"><?php echo lang("ctn_471") ?>: <?php echo date($this->settings->info->date_format, $article->last_updated_timestamp) ?></p>
</div>
</div>