<div class="col-xs-12">
    
        <p><img src="<?php echo base_url('uploads/logo3.png'); ?>" width="100%" alt="" style="border-bottom:0px;margin-bottom:20px;"/></p>  
    
</div>
<div class="col-xs-12" style="text-align:center;margin-bottom:20px;">
    <p>Enter Job ID Number</p>
</div>
<div class="col-xs-12">
    <?php echo form_open(site_url("mobile/search"))?>
        
        <input type="text" name="job_id" class="form-control" style="width:100%;margin-bottom:20px;">
        
        <input type="submit" class="btn btn-primary form-control" value="Search">
    <?php echo form_close()?>
</div>