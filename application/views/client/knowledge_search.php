
<hr>


<?php if($articles->num_rows() > 0) : ?>
<table id="job-table" class="table table-bordered table-hover table-striped">
<thead>
<tr class="table-header"><td><?php echo lang("ctn_389") ?></td><td><?php echo lang("ctn_458") ?></td><td><?php echo lang("ctn_459") ?></td></tr>
</thead>
<tbody>
<?php foreach($articles->result() as $r) : ?>
  <?php
    $summary = substr(strip_tags($r->body), 0, 100);
  ?>
<tr><td><?php echo $r->title ?></td><td><?php echo $summary ?></td><td><a href="<?php echo site_url("client/view_knowledge/" . $r->ID) ?>" class="btn btn-info btn-xs"><?php echo lang("ctn_459") ?></a></td></tr>
<?php endforeach; ?>
</tbody>
</table>
<?php else : ?>

  <p><?php echo lang("ctn_460") ?></p>
<?php endif; ?>