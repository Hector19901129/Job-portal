<h3 class="home-label"><?php echo lang("ctn_445") ?></h3>

<div class="list-group">
<?php foreach($articles->result() as $r) : ?>
<?php $str = explode("***", wordwrap(strip_tags($r->body), 100, "***")); ?>
  <a href="<?php echo site_url("client/view_knowledge/" . $r->ID) ?>" class="list-group-item">
    <h4 class="list-group-item-heading"><?php echo $r->title ?></h4>
    <p class="list-group-item-text"><?php echo $str[0] ?> ... </p>
  </a>
<?php endforeach; ?>
</div>