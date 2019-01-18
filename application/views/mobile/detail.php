<div class="col-xs-12">
    
        <p><img src="<?php echo base_url('uploads/logo3.png'); ?>" width="100%" alt="" style="border-bottom:0px;margin-bottom:20px;"/></p>  
    
</div>

<div class="col-xs-12">
    <?php echo form_open_multipart(site_url("mobile/confirm"))?>
		<div class="col-xs-12" style="text-align:center ">
			<p>Property Adress</p>
		</div>
		<div class="col-xs-12" style="text-align:center ">
				<input type="text" name="job_id" class="form-control" style="width:100%;margin-bottom:20px;" value="<?php echo $job->title?>">
		</div>
        <div class="col-xs-12" style="text-align:center ">
			<p>Status</p>
		</div>
		<div class="col-xs-12" style="text-align:center ">
			<select name="job_status" class="form-control" style="width:100%;margin-bottom:20px;">
				<option value="0" <?php if($job->status == 0) echo "selected"?>>New</option>
				<option value="1" <?php if($job->status == 1) echo "selected"?>>In Progress</option>
				<option value="2" <?php if($job->status == 2) echo "selected"?>>Installed</option>
				<option value="3" <?php if($job->status == 3) echo "selected"?>>Removed</option>
				<option value="4" <?php if($job->status == 4) echo "selected"?>>Completed</option>
			</select>
		</div>
		
			<input type="hidden" name="job_id" value="<?php echo $job->ID?>">
		
		<div class="col-xs-12" style="text-align:center ">
			<p>Attach File</p>
		</div>
		<div class="col-xs-12" style="text-align:center ">
			<input type="file" name="file" class="form-control" style="width:100%;margin-bottom:15px;">
		</div>
               <div class="col-xs-12" style="text-align:center ">
                        <input type="submit" class="btn btn-primary form-control" value="Confirm" style="margin-top:10px;">
               </div>
    <?php echo form_close()?>
</div>