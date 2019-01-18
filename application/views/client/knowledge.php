<div class="panel panel-default">
<div class="panel-body">

<h3 class="home-label"><?php echo lang("ctn_456") ?></h3>

<?php foreach($categories->result() as $r) : ?>
<div class="category-page">
<img src="<?php echo base_url() ?><?php echo $this->settings->info->upload_path_relative ?>/<?php echo $r->image ?>" class="category-image">
<p class="category-title"><a href="<?php echo site_url("client/view_knowledge_cat/" . $r->ID) ?>"><?php echo $r->name ?></a></p>
<?php echo $r->description ?>
<hr>
<div class="circle-buttons"><a href="<?php echo site_url("client/view_knowledge_cat/" . $r->ID) ?>"><span class="glyphicon glyphicon-list"></span></a></div>
</div>
<?php endforeach; ?>


<hr>

<h4><?php echo lang("ctn_457") ?></h4>

<div class="row">

<?php foreach($articles->result() as $r) : ?>
<div class="col-md-6 article-padding">
<span class="glyphicon glyphicon-file"></span> <a href="<?php echo site_url("client/view_knowledge/" . $r->ID) ?>"><?php echo $r->title ?></a>
<hr>
</div>
<?php endforeach; ?>

</div>

</div>
</div>