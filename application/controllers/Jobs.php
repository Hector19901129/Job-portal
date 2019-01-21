<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Jobs extends CI_Controller
{

	public function __construct()
	{
		parent::__construct();
		$this->load->model("user_model");
		$this->load->model("jobs_model");
		$this->load->model("home_model");

		if(!$this->user->loggedin) $this->template->error(lang("error_1"));

		$this->template->loadData("activeLink",
			array("job" => array("general" => 1)));

		if(!$this->common->has_permissions(array(
			"admin", "job_manager", "job_worker"), $this->user)) {
			$this->template->error(lang("error_85"));
		}
	}
	//newly modified
	public function index($catid=0, $start_date = null, $end_date = null, $printall = 0, $showall = 0)
	{
		$catid = intval($catid);
		if(!$this->common->has_permissions(array(
			"admin", "job_manager"), $this->user)) {
			$this->template->error(lang("error_85"));
		}
		$this->template->loadData("activeLink",
			array("job" => array("general" => 1)));

		if($this->common->has_permissions(array("admin", "job_manager"),
			$this->user)) {
			$categories = $this->jobs_model->get_categories();
		} else {
			$categories = $this->jobs_model->get_user_categories($this->user->info->ID);
		}
		$start_date = $start_date == null ? $this->jobs_model->getOldestDate() : $this->common->formatDateMdYToYmd($start_date);
		$end_date = $end_date == null ? $this->jobs_model->getLatestDate() : $this->common->formatDateMdYToYmd($end_date);
		$views = $this->jobs_model->get_custom_views($this->user->info->ID);
		$this->template->loadContent("jobs/index.php", array(
			"page" => "index",
			"catid" => $catid,
			"categories" => $categories,
			"views" => $views,
			"start_date" => $start_date,
			"end_date" => $end_date,
			"printall" => $printall,
			"showall" => $showall
			)
		);
	}
	
	public function merge_job($jobid)
	{
		$jobid = intval($jobid);
		$job = $this->jobs_model->get_job($jobid);
		if($job->num_rows() == 0) {
			$this->template->error(lang("error_84"));
		}
		$job = $job->row();

		$recent_jobs = $this->jobs_model->get_recent_jobs(20);

		$this->template->loadContent("jobs/merge_job.php", array(
			"job" => $job,
			"jobs" => $recent_jobs
			)
		);
	}

	public function merge_job_pro($jobid)
	{
		$jobid = intval($jobid);
		$job = $this->jobs_model->get_job($jobid);
		if($job->num_rows() == 0) {
			$this->template->error(lang("error_84"));
		}
		$job = $job->row();

		$merge_replies = intval($this->input->post("merge_replies"));
		$merge_user = intval($this->input->post("merge_user"));
		$merge_history = intval($this->input->post("merge_history"));
		$merge_job = intval($this->input->post("merge_job"));
		$merge_files = intval($this->input->post("merge_files"));


		$primary_jobid = intval($this->input->post("primary_jobid"));
		if($primary_jobid == 0) {
			$primary_jobid = intval($this->input->post("job_id"));
		}
		$pjob = $this->jobs_model->get_job($primary_jobid);
		if($pjob->num_rows() == 0) {
			$this->template->error(lang("error_127"));
		}
		$pjob = $pjob->row();

		if($merge_replies) {
			// Update replies of merge job to primary job
			$this->jobs_model->update_all_job_replies($job->ID, array(
				"jobid" => $pjob->ID
				)
			);
		}

		if($merge_user) {
			// Replace pjob user with job user
			// if guest, replace guest + password
			$this->jobs_model->update_job($pjob->ID, array(
				"userid" => $job->userid,
				"guest_email" => $job->guest_email,
				"guest_password" => $job->guest_password
				)
			);
		}

		if($merge_history) {
			$this->jobs_model->update_all_job_history($job->ID, array(
				"jobid" => $pjob->ID
				)
			);
		}

		if($merge_job) {
			$this->jobs_model->update_job($pjob->ID, array(
				"title" => $job->title,
				"body" => $job->body,
				"assignedid" => $job->assignedid,
				"priority" => $job->priority,
				"categoryid" => $job->categoryid
				)
			);


			$this->jobs_model->delete_custom_field_data($pjob->ID);

			// Custom fields
			$this->jobs_model->update_all_job_cf($job->ID, array(
				"jobid" => $pjob->ID
				)
			);
		}

		if($merge_files) {
			$this->jobs_model->update_all_job_files($job->ID, array(
				"jobid" => $pjob->ID
				)
			);
		}

		// Delete job
		$this->jobs_model->delete_job($job->ID);

		$this->session->set_flashdata("globalmsg", lang("success_72"));
		redirect(site_url("jobs/view/" . $pjob->ID));
	}

	public function assign_user($jobid, $hash)
	{
		if($hash != $this->security->get_csrf_hash()) {
			$this->template->error(lang("error_6"));
		}
		$jobid = intval($jobid);
		$job = $this->jobs_model->get_job($jobid);
		if($job->num_rows() == 0) {
			$this->template->error(lang("error_84"));
		}
		$job = $job->row();

		if($job->assignedid > 0) {
			$this->template->error(lang("error_112"));
		}

		$this->jobs_model->update_job($jobid, array(
			"assignedid" => $this->user->info->ID
			)
		);

		$this->jobs_model->add_history(array(
			"userid" => $this->user->info->ID,
			"message" => $this->user->info->username . " " . lang("ctn_661"),
			"timestamp" => time(),
			"jobid" => $jobid
			)
		);

		$this->session->set_flashdata("globalmsg", lang("success_56"));
		redirect(site_url("jobs/view/" . $job->ID));
	}

	public function assign_user_pro($jobid)
	{
		$jobid = intval($jobid);
		$job = $this->jobs_model->get_job($jobid);
		if($job->num_rows() == 0) {
			$this->template->error(lang("error_84"));
		}
		$job = $job->row();

		$username = $this->common->nohtml($this->input->post("username"));
		$user = $this->user_model->get_user_by_username($username);
		if($user->num_rows() == 0) {
			$this->template->error("Invalid User");
		}

		$user = $user->row();

		$this->jobs_model->update_job($jobid, array(
			"assignedid" => $user->ID
			)
		);

		$this->jobs_model->add_history(array(
			"userid" => $this->user->info->ID,
			"message" => $user->username . " " . lang("ctn_662"),
			"timestamp" => time(),
			"jobid" => $jobid
			)
		);

		$this->user_model->increment_field($user->ID, "noti_count", 1);
		$this->user_model->add_notification(array(
			"userid" => $user->ID,
			"url" => "jobs/view/" . $jobid,
			"timestamp" => time(),
			"message" => lang("ctn_663"),
			"status" => 0,
			"fromid" => $this->user->info->ID,
			"username" => $user->username,
			"email" => $user->email,
			"email_notification" => $user->email_notification
			)
		);

		$this->session->set_flashdata("globalmsg", lang("success_64"));
		redirect(site_url("jobs/view/" . $job->ID));
	}

	public function assigned($catid=0)
	{
		$catid = intval($catid);
		$this->template->loadData("activeLink",
			array("job" => array("ass" => 1)));

		if($this->common->has_permissions(array("admin", "job_manager"),
			$this->user)) {
			$categories = $this->jobs_model->get_categories();
		} else {
			$categories = $this->jobs_model->get_user_categories($this->user->info->ID);
		}

		$views = $this->jobs_model->get_custom_views($this->user->info->ID);

		$this->template->loadContent("jobs/index.php", array(
			"page" => "assigned",
			"catid" => $catid,
			"categories" => $categories,
			"views" => $views
			)
		);
	}

	public function your($catid=0)
	{
		$catid = intval($catid);
		$this->template->loadData("activeLink",
			array("job" => array("your" => 1)));

		if($this->common->has_permissions(array("admin", "job_manager"),
			$this->user)) {
			$categories = $this->jobs_model->get_categories();
		} else {
			$categories = $this->jobs_model->get_user_categories($this->user->info->ID);
		}
		$views = $this->jobs_model->get_custom_views($this->user->info->ID);

		$this->template->loadContent("jobs/index.php", array(
			"page" => "your",
			"categories" => $categories,
			"catid" => $catid,
			"views" => $views
			)
		);
	}

	public function job_page($page, $catid=0, $start_date = null, $end_date = null, $showall = 0)
	{

		// get custom view
		$custom_view = $this->jobs_model
			->get_custom_view($this->user->info->custom_view,
				$this->user->info->ID);

		$catid = intval($catid);
		$this->load->library("datatables");

		$this->datatables->set_default_order("jobs.last_reply_timestamp", "desc");

		// Set page ordering options that can be used
		$this->datatables->ordering(
			array(
				 0 => array(
				 	"jobs.ID" => 0
				 ),
				 1 => array(
				 	"jobs.title" => 0
				 ),
				 2 => array(
				 	"jobs.priority" => 0
				 ),
				 3 => array(
				 	"jobs.status" => 0
				 ),
				 4 => array(
				 	"jobs.categoryid" => 0
				 ),
				 8 => array(
				 	"jobs.last_reply_timestamp" => 0
				 ),
			)
		);
		$start_date = $start_date == null ? null : $this->common->formatDateMdYToYMd($start_date);
		$end_date = $end_date == null ? null : $this->common->formatDateMdYToYMd($end_date);
		if($page == "index") {
			$this->datatables->set_total_rows(
				$this->jobs_model
					->get_jobs_total($catid, $custom_view, $this->datatables, $start_date, $end_date, $showall)
			);
			$jobs = $this->jobs_model->get_jobs($catid, $this->datatables, $custom_view, $start_date, $end_date, $showall);
		} elseif($page == "your") {
			$this->datatables->set_total_rows(
				$this->jobs_model
					->get_jobs_your_total($this->user->info->ID, $catid, $custom_view, $this->datatables)
			);
			$jobs = $this->jobs_model->get_jobs_your($this->user->info->ID, $catid, $this->datatables, $custom_view);
		} elseif($page == "assigned") {
			$this->datatables->set_total_rows(
				$this->jobs_model
					->get_jobs_assigned_total($this->user->info->ID, $catid, $custom_view, $this->datatables)
			);
			$jobs = $this->jobs_model->get_jobs_assigned($this->user->info->ID, $catid, $this->datatables, $custom_view);
		}

		$prioritys = array(0 => "<span class='label label-info'>".lang("ctn_429")."</span>", 1 => "<span class='label label-primary'>".lang("ctn_430")."</span>", 2=> "<span class='label label-warning'>".lang("ctn_431")."</span>", 3 => "<span class='label label-danger'>".lang("ctn_432")."</span>");

		foreach($jobs->result() as $r) {


			if($r->status == 0) {
				$status = lang("ctn_465");
			} elseif($r->status == 1) {
				$status = lang("ctn_466");
			} elseif($r->status == 2) {
				$status = lang("ctn_467");
			} elseif($r->status == 3) {
				$status = "Removed";
			} elseif($r->status == 4) {
			  $status = "Completed";
			}

			if(isset($r->client_username)) {
		        $user = $this->common->get_user_display(array("username" => $r->client_username, "avatar" => $r->client_avatar, "online_timestamp" => $r->client_online_timestamp, "user" => true));
		    } else {
		        $user = '<div class="user-box-avatar">'.$r->guest_email.'</div>';
		    }

		    if($r->last_reply_userid ==0) {
		    	$last_reply = $user . date($this->settings->info->date_format,$r->last_reply_timestamp);
		    } else {
		    	$last_reply =  $this->common->get_user_display(array("username" => $r->lr_username, "avatar" => $r->lr_avatar, "online_timestamp" => $r->lr_online_timestamp, "user" => false)) . date($this->settings->info->date_format,$r->last_reply_timestamp);
		    }


			$this->datatables->data[] = $page == "index" ? array(
				$r->ID,
				$r->title,
				$prioritys[$r->priority],
				$status,
				$r->cat_name,
				$user,
				$r->visible == 1 ? '<input type="checkbox" checked onchange="visibleChange(this)" id = "checkbox'.$r->ID.'">' : '<input type="checkbox" onchange="visibleChange(this)" id = "checkbox'.$r->ID.'">',
				$r->printable == 1 ? '<input type="checkbox" checked onchange="printableChange(this)" id = "printcheckbox'.$r->ID.'">' : '<input type="checkbox" onchange="printableChange(this)" id = "printcheckbox'.$r->ID.'">',
				$last_reply,
				'<a href="'.site_url('jobs/view/' . $r->ID).'" class="btn btn-info btn-xs" data-toggle="tooltip" data-placement="bottom" title="'.lang("ctn_459").'">'.lang("ctn_459").'</a> <a href="'.site_url("jobs/edit_job/" . $r->ID).'" class="btn btn-warning btn-xs" data-toggle="tooltip" data-placement="bottom" title="'.lang("ctn_55").'"><span class="glyphicon glyphicon-cog"></span></a> <a href="'.site_url("jobs/delete_job/" . $r->ID . "/" . $this->security->get_csrf_hash()).'" class="btn btn-danger btn-xs" onclick="return confirm(\''.lang("ctn_317").'\')" data-toggle="tooltip" data-placement="bottom" title="'.lang("ctn_57").'"><span class="glyphicon glyphicon-trash"></span></a>'
			) : array(
				$r->ID,
				$r->title,
				$prioritys[$r->priority],
				$status,
				$r->cat_name,
				$user,
				$this->common->get_user_display(array("username" => $r->username, "avatar" => $r->avatar, "online_timestamp" => $r->online_timestamp, "user" => false)),
				$last_reply,
				'<a href="'.site_url('jobs/view/' . $r->ID).'" class="btn btn-info btn-xs" data-toggle="tooltip" data-placement="bottom" title="'.lang("ctn_459").'">'.lang("ctn_459").'</a> <a href="'.site_url("jobs/edit_job/" . $r->ID).'" class="btn btn-warning btn-xs" data-toggle="tooltip" data-placement="bottom" title="'.lang("ctn_55").'"><span class="glyphicon glyphicon-cog"></span></a> <a href="'.site_url("jobs/delete_job/" . $r->ID . "/" . $this->security->get_csrf_hash()).'" class="btn btn-danger btn-xs" onclick="return confirm(\''.lang("ctn_317").'\')" data-toggle="tooltip" data-placement="bottom" title="'.lang("ctn_57").'"><span class="glyphicon glyphicon-trash"></span></a>'
			);
		}

		echo json_encode($this->datatables->process());
	}
	//newly added
	public function visibleChange(){
		$id = $this->input->post("id");
		$value = $this->input->post("value");
		$this->jobs_model->visibleChange($id, array("visible" => $value));
	}
	//newly added
	public function printableChange(){
		$id = $this->input->post("id");
		$value = $this->input->post("value");
		$this->jobs_model->printableChange($id, array("printable" => $value));
	}
	//newly added
	public function printall($catid = 0, $start_date = null, $end_date = null, $printall = 0){
		$this->jobs_model->printall($catid, $this->common->formatDateMdYToYMd($start_date), $this->common->formatDateMdYToYMd($end_date), $printall);
	}
	public function change_status()
	{
		$jobid = intval($this->input->get("jobid"));
		$status = intval($this->input->get("status"));
		$job = $this->jobs_model->get_job($jobid);
		if($job->num_rows() == 0) {
			$this->template->jsonError(lang("error_84"));
		}
		$job = $job->row();

		// Check user has access
		$this->check_job_access($job);

		if($status < 0 || $status > 4) {
			$this->template->jsonError(lang("error_113"));
		}

		if($status == 2) {
			$close_job = date("d-n-Y");
		} else {
			$close_job = "";
		}

		$statuses = array(0=>lang("ctn_465"), 1 => lang("ctn_466"), 2 => lang("ctn_467"), 3 => 'Removed', 4 => 'Completed');

		$this->jobs_model->update_job($jobid, array(
			"status" => $status,
			"close_job_date" => $close_job
			)
		);

		$this->jobs_model->add_history(array(
			"userid" => $this->user->info->ID,
			"message" => lang("ctn_664") . " " . $statuses[$status],
			"timestamp" => time(),
			"jobid" => $jobid
			)
		);

		echo json_encode(array("success" => 1));
		exit();
	}
	//newly inserted
	public function view($id)
	{
		$id = intval($id);
		$job = $this->jobs_model->get_job($id);
		if($job->num_rows() == 0) {
			$this->template->error(lang("error_84"));
		}
		$job = $job->row();

		$this->template->loadData("activeLink",
			array("job" => array("general" => 1)));

		// Check user has access
		$this->check_job_access($job);

		$files = $this->jobs_model->get_job_files($id);

		$replies = $this->jobs_model->get_job_replies($id);


		$user_fields = null;
		if($job->userid > 0) {
			$user_fields = $this->user_model->get_custom_fields_answers(array(
				), $job->userid);
		}

		$job_fields = $this->jobs_model->get_custom_fields_for_job($id);
		$canned = $this->jobs_model->get_all_canned_responses();
		$fields = $this->user_model->get_member_by_id($job->userid);
		$field = $fields->row()->custom_fields;
		$history = $this->jobs_model->get_job_history_limit($id, 6);

		$this->template->loadContent("jobs/view_job.php", array(
			"job" => $job,
			"files" => $files,
			"replies" => $replies,
			"user_fields" => $user_fields,
			"job_fields" => $job_fields,
			"canned" => $canned,
			"history" => $history,
			"user_field" => $field
			)
		);
	}

	public function notify_job($id, $hash)
	{
		if($hash != $this->security->get_csrf_hash()) {
			$this->template->error(lang("errpr_6"));
		}
		$id = intval($id);
		$job = $this->jobs_model->get_job($id);
		if($job->num_rows() == 0) {
			$this->template->error(lang("error_84"));
		}
		$job = $job->row();

		$this->jobs_model->add_history(array(
			"userid" => $this->user->info->ID,
			"message" =>  lang("ctn_675"),
			"timestamp" => time(),
			"jobid" => $id
			)
		);

		if($job->userid > 0) {
			$this->user_model->increment_field($job->userid, "noti_count", 1);
			$this->user_model->add_notification(array(
				"userid" => $job->userid,
				"url" => "jobs/view/" . $id,
				"timestamp" => time(),
				"message" => lang("ctn_674"),
				"status" => 0,
				"fromid" => $this->user->info->ID,
				"username" => $job->client_username,
				"email" => $job->client_email,
				"email_notification" => $job->client_email_notification
				)
			);
		} else {
			if(!isset($_COOKIE['language'])) {
				// Get first language in list as default
				$lang = $this->config->item("language");
			} else {
				$lang = $this->common->nohtml($_COOKIE["language"]);
			}

			// Send Email
			$email_template = $this->home_model->get_email_template_hook("job_reminder", $lang);
			if($email_template->num_rows() == 0) {
				$this->template->error(lang("error_48"));
			}
			$email_template = $email_template->row();

			$email_template->message = $this->common->replace_keywords(array(
				"[NAME]" => $job->guest_email,
				"[GUEST_PASS]" => $job->guest_password,
				"[SITE_URL]" => site_url(),
				"[SITE_NAME]" =>  $this->settings->info->site_name
				),
			$email_template->message);

			$this->common->send_email($email_template->title,
				 $email_template->message, $job->guest_email);
		}

		$this->session->set_flashdata("globalmsg", lang("success_69"));
		redirect(site_url("jobs/view/" . $id));
	}

	public function print_view($id)
	{
		$id = intval($id);
		$job = $this->jobs_model->get_job($id);
		if($job->num_rows() == 0) {
			$this->template->error(lang("error_84"));
		}
		$job = $job->row();

		$this->template->loadData("activeLink",
			array("job" => array("general" => 1)));

		// Check user has access
		$this->check_job_access($job);

		$files = $this->jobs_model->get_job_files($id);

		$replies = $this->jobs_model->get_job_replies($id);


		$user_fields = null;
		if($job->userid > 0) {
			$user_fields = $this->user_model->get_custom_fields_answers(array(
				), $job->userid);
		}

		$job_fields = $this->jobs_model->get_custom_fields_for_job($id);
		$canned = $this->jobs_model->get_all_canned_responses();

		$this->template->loadAjax("jobs/print_job.php", array(
			"job" => $job,
			"files" => $files,
			"replies" => $replies,
			"user_fields" => $user_fields,
			"job_fields" => $job_fields,
			"canned" => $canned
			),1
		);
	}
	//newly added
	public function print_viewall()
	{
		$id_array = $this->jobs_model->getPrintViewID();
		if($id_array->num_rows() > 0) {
			// Check if the user is any of these groups
			$print_array = array();
			foreach($id_array->result() as $r) {
				
				$id = $r->ID;
				$job = $this->jobs_model->get_job($id);
				if($job->num_rows() == 0) {
					$this->template->error(lang("error_84"));
				}
				$job = $job->row();

				$this->template->loadData("activeLink",
					array("job" => array("general" => 1)));

				// Check user has access
				$this->check_job_access($job);

				$files = $this->jobs_model->get_job_files($id);

				$replies = $this->jobs_model->get_job_replies($id);


				$user_fields = null;
				if($job->userid > 0) {
					$user_fields = $this->user_model->get_custom_fields_answers(array(
						), $job->userid);
				}

				$job_fields = $this->jobs_model->get_custom_fields_for_job($id);
				$canned = $this->jobs_model->get_all_canned_responses();
				$temp = array(
					"job" => $job,
					"files" => $files,
					"replies" => $replies,
					"user_fields" => $user_fields,
					"job_fields" => $job_fields,
					"canned" => $canned
				);
				array_push($print_array, $temp);
			}
			
			$this->template->loadAjax("jobs/print_all_jobs.php", array("print_array" => $print_array),1
			);
		}
			

		
	}
	private function check_job_access($job)
	{
		// Check user has access
		if($job->userid != $this->user->info->ID
			&& $job->assignedid != $this->user->info->ID) {
			$goodFlag = 0;
			// Check the user is in the category's assigned user group
			$groups = $this->jobs_model->get_category_groups($job->categoryid);
			if($groups->num_rows() > 0) {
				// Check if the user is any of these groups
				$groupids = array();
				foreach($groups->result() as $r) {
					$groupids[] = $r->groupid;
				}

				$userG = $this->jobs_model->get_user_groups($groupids, $this->user->info->ID);
				if($userG->num_rows() > 0) {
					$goodFlag = 1;
				}
			}

			if(!$goodFlag) {
				// Check
				if(!$this->common->has_permissions(array(
					"admin", "job_manager"), $this->user)) {
					$this->template->error(lang("error_85"));
				}
			}
		}
	}
	//newly added
	public function saveOrder(){
		$field_order = $this->input->post("str");
		$this->jobs_model->updateFieldOrder(array("field_order" => $field_order));
	}

	//modified
	public function job_reply($id)
	{
		//mail('kapilgulati19@gmail.com', 'test', 'test123');
		/*ini_set( 'display_errors', 1 );

		error_reporting( E_ALL );

		$from = "info@hotelpineview.com";

		$to = "testmailhostingserver@gmail.com";

		$to = "kapilgulati19@gmail.com";

		$subject = "PHP Mail Test script";

		$message = "This is a test to check the PHP Mail functionality";

		$headers = "From:" . $from;

		if(mail($to,$subject,$message, $headers))
		echo "Test email sent";
		else
		echo 'not sent';
		echo '<pre>';
		print_r($_POST);
		print_r($_FILES);
		die('in reply');*/
		$id = intval($id);
		$job = $this->jobs_model->get_job($id);
		if($job->num_rows() == 0) {
			$this->template->error(lang("error_84"));
		}
		$job = $job->row();

		// Check user has access
		$this->check_job_access($job);

		$body = $this->lib_filter->go($this->input->post("body"));
		if(empty($body)) {
			//$this->template->error(lang("error_100"));
			
		}
		$assign = intval($this->input->post("assign"));

		$this->load->library("upload");

		$file_count = intval($this->input->post("file_count"));
		$file_data = array();
		$files_flag = 0;
		/*echo '<pre>';
		print_r($this->settings);
		die;*/
		//Load email library 
		$this->load->library('email'); 
		
		if($this->settings->info->enable_job_uploads) {
			for($i=1;$i<=$file_count;$i++) {
				if (isset($_FILES['user_file_'. $i]) && $_FILES['user_file_' . $i]['size'] > 0) {
					$this->upload->initialize(array(
					   "upload_path" => $this->settings->info->upload_path,
				       "overwrite" => FALSE,
				       "max_filename" => 300,
				       "encrypt_name" => TRUE,
				       "remove_spaces" => TRUE,
				       "allowed_types" => $this->settings->info->file_types,
				       "max_size" => $this->settings->info->file_size,
						)
					);
					// $this->upload->initialize(array(
					// 	"upload_path" => "uploads",
					// 	"overwrite" => FALSE,
					// 	"max_filename" => 300,
					// 	"encrypt_name" => TRUE,
					// 	"remove_spaces" => TRUE,
					// 	"allowed_types" => $this->settings->info->file_types,
					// 	"max_size" => $this->settings->info->file_size,
					// 	 )
					//  );
					if ( ! $this->upload->do_upload('user_file_' . $i))
		            {
		                    $error = array('error' => $this->upload->display_errors());

		                    $this->template->error(lang("error_98") . "<br /><br />" .
		                    	 $this->upload->display_errors());
		            }

		            $data = $this->upload->data();
		            $files_flag = 1;
		            $file_data[] = array(
		            	"upload_file_name" => $data['file_name'],
		            	"file_type" => $data['file_type'],
		            	"extension" => $data['file_ext'],
		            	"file_size" => $data['file_size'],
		            	"timestamp" => time()
		            	);
		            $this->email->attach($data['full_path']);
		        }
			}
		}

		$new_message_id_hash = md5(rand(1,100000000)."fhhfh".time());

		// Add
		$replyid = $this->jobs_model->add_job_reply(array(
			"jobid" => $id,
			"userid" => $this->user->info->ID,
			"body" => $body,
			"timestamp" => time(),
			"files" => $files_flag,
			"hash" => $new_message_id_hash
			)
		);

		// Add Attached files
		foreach($file_data as $file) {
			$this->jobs_model->add_attached_files(array(
				"replyid" => $replyid,
				"jobid" => $id,
				"upload_file_name" => $file['upload_file_name'],
				"file_type" => $file['file_type'],
				"extension" => $file['extension'],
				"file_size" => $file['file_size'],
				"timestamp" => $file['timestamp'],
				"userid" => $this->user->info->ID
				)
			);
		}

		$assignedid = $job->assignedid;
		if($assign) {
			$assignedid = $this->user->info->ID;
		}


		// Update last reply
		$this->jobs_model->update_job($job->ID, array(
			"last_reply_userid" => $this->user->info->ID,
			"last_reply_timestamp" => time(),
			"last_reply_string" => date($this->settings->info->date_format, time()),
			"assignedid" => $assignedid
			)
		);

		// Notification
		if($job->userid == $this->user->info->ID) {
			// Alert assigned user of new reply
			if($job->assignedid > 0) {
				$this->user_model->increment_field($job->assignedid, "noti_count", 1);
				$this->user_model->add_notification(array(
					"userid" => $job->assignedid,
					"url" => "jobs/view/" . $job->ID,
					"timestamp" => time(),
					"message" => lang("ctn_609"),
					"status" => 0,
					"fromid" => $this->user->info->ID,
					"username" => $job->username,
					"email" => $job->email,
					"email_notification" => $job->email_notification
					)
				);
			}
		} elseif($this->user->info->ID == $job->assignedid) {
			// Alert user of new reply
			if($job->userid > 0) {
				$this->user_model->increment_field($job->userid, "noti_count", 1);
				$this->user_model->add_notification(array(
					"userid" => $job->userid,
					"url" => "client/view_job/" . $job->ID,
					"timestamp" => time(),
					"message" => lang("ctn_609"),
					"status" => 0,
					"fromid" => $this->user->info->ID,
					"username" => $job->client_username,
					"email" => $job->client_email,
					"email_notification" => $job->client_email_notification
					)
				);
			}
		} else {
			// Alert both in case of random user reply
			if($job->userid > 0) {
				$this->user_model->increment_field($job->userid, "noti_count", 1);
				$this->user_model->add_notification(array(
					"userid" => $job->userid,
					"url" => "client/view_job/" . $job->ID,
					"timestamp" => time(),
					"message" => lang("ctn_609"),
					"status" => 0,
					"fromid" => $this->user->info->ID,
					"username" => $job->client_username,
					"email" => $job->client_email,
					"email_notification" => $job->client_email_notification
					)
				);
			}
			if($job->assignedid > 0) {
				$this->user_model->increment_field($job->assignedid, "noti_count", 1);
				$this->user_model->add_notification(array(
					"userid" => $job->assignedid,
					"url" => "jobs/view/" . $job->ID,
					"timestamp" => time(),
					"message" => lang("ctn_609"),
					"status" => 0,
					"fromid" => $this->user->info->ID,
					"username" => $job->username,
					"email" => $job->email,
					"email_notification" => $job->email_notification
					)
				);
			}
		}

		$this->jobs_model->add_history(array(
			"userid" => $this->user->info->ID,
			"message" => lang("ctn_665"),
			"timestamp" => time(),
			"jobid" => $job->ID
			)
		);

		//if($job->userid != $this->user->info->ID) {
			if(!isset($_COOKIE['language'])) {
				// Get first language in list as default
				$lang = $this->config->item("language");
			} else {
				$lang = $this->common->nohtml($_COOKIE["language"]);
			}

			// Send Email
			$email_template = $this->home_model->get_email_template_hook("job_reply", $lang);
			if($email_template->num_rows() == 0) {
				$this->template->error(lang("error_48"));
			}
			$email_template = $email_template->row();

			if(isset($job->client_username)) {
				$username = $job->client_username;
				$email = $job->client_email;
			} else {
				$username = $job->guest_email;
				$email = $job->guest_email;
			}

			$email_template->message = $this->common->replace_keywords(array(
				"[NAME]" => $username,
				"[SITE_URL]" => site_url(),
				"[TICKET_BODY]" => $body,
				"[TICKET_ID]" => $id,
				"[SITE_NAME]" =>  $this->settings->info->site_name,
				"[IMAP_TICKET_REPLY_STRING]" => $this->settings->info->imap_reply_string,
				"[IMAP_TICKET_ID]" => $this->settings->info->imap_job_string
				),
			$email_template->message);

			$headers = array(
				"References" => $job->message_id_hash,
				"In-Reply-To" => $job->message_id_hash,
				"Message-ID" => $new_message_id_hash
				);
			//$this->common->send_email($this->settings->info->job_title . " [ID: " . $id . "]: " . $job->title,
				 //$email_template->message, $email, $headers);

			/*$to_email = "kapilgulati19@gmail.com"; */

			$this->email->from($this->settings->info->site_email, $this->settings->info->site_name);
			
			//$this->email->from($from_email, 'Your Name'); 
	        $this->email->to($email);

			$this->email->subject($this->settings->info->job_title . " [ID: " . $id . "]: " . $job->title);
			$logo_path = "uploads/logo3.png";
			$content = $this->load->view("jobs/email.php", array("logo_path" => $logo_path, "user_name" => $username, "job_id" => $id, "property_name" => $job->title), true);
	        //$this->email->message($email_template->message);
			$this->email->message($content);	
	        
	        foreach($headers as $key=>$value) {
	            $this->email->set_header($key, $value);
			}
			$r = $this->email->send();
			//exit();
			/*$this->email->from($from_email, 'Your Name'); 
			$this->email->to($email);
			$this->email->subject($this->settings->info->job_title . " [ID: " . $id . "]: " . $job->title); 
			$this->email->message($email_template->message); */

			//Send mail 
			/*if($this->email->send()) 
			//$this->session->set_flashdata("email_sent","Email sent successfully."); 
			echo 'mail sent';
			else 
			//$this->session->set_flashdata("email_sent","Error in sending Email.");
			echo 'not sent';
			echo '<pre>';
			print_r($this->settings);
				die;*/
			//}
		
		$this->session->set_flashdata("globalmsg", lang("success_45"));
		redirect(site_url("jobs/view/" . $id));
	}

	public function edit_job_reply($id)
	{
		$this->template->loadData("activeLink",
			array("jobs" => array("general" => 1)));

		$id = intval($id);
		$reply = $this->jobs_model->get_job_reply($id);
		if($reply->num_rows() == 0) {
			$this->template->error(lang("error_101"));
		}

		$reply = $reply->row();

		if($reply->userid != $this->user->info->ID) {
			// Check user has admin rights
			// Check
			if(!$this->common->has_permissions(array(
				"admin", "job_manager"), $this->user)) {
				$this->template->error(lang("error_85"));
			}
		}
		$this->template->loadContent("jobs/edit_job_reply.php", array(
			"reply" => $reply
			)
		);
	}

	public function edit_job_reply_pro($id)
	{
		$id = intval($id);
		$reply = $this->jobs_model->get_job_reply($id);
		if($reply->num_rows() == 0) {
			$this->template->error(lang("error_101"));
		}
		$reply = $reply->row();

		if($reply->userid != $this->user->info->ID) {
			// Check user has admin rights
			// Check
			if(!$this->common->has_permissions(array(
				"admin", "job_manager"), $this->user)) {
				$this->template->error(lang("error_85"));
			}
		}

		$body = $this->lib_filter->go($this->input->post("body"));
		if(empty($body)) {
			$this->template->error(lang("error_103"));
		}

		$this->load->library("upload");

		$file_count = intval($this->input->post("file_count"));
		$file_data = array();
		$files_flag = $reply->files;
		if($this->settings->info->enable_job_uploads) {
			for($i=1;$i<=$file_count;$i++) {
				if (isset($_FILES['user_file_'. $i]) && $_FILES['user_file_' . $i]['size'] > 0) {
					$this->upload->initialize(array(
					   "upload_path" => $this->settings->info->upload_path,
				       "overwrite" => FALSE,
				       "max_filename" => 300,
				       "encrypt_name" => TRUE,
				       "remove_spaces" => TRUE,
				       "allowed_types" => $this->settings->info->file_types,
				       "max_size" => $this->settings->info->file_size,
						)
					);

					if ( ! $this->upload->do_upload('user_file_' . $i))
		            {
		                    $error = array('error' => $this->upload->display_errors());

		                    $this->template->error(lang("error_98") . "<br /><br />" .
		                    	 $this->upload->display_errors());
		            }

		            $data = $this->upload->data();
		            $files_flag = 1;
		            $file_data[] = array(
		            	"upload_file_name" => $data['file_name'],
		            	"file_type" => $data['file_type'],
		            	"extension" => $data['file_ext'],
		            	"file_size" => $data['file_size'],
		            	"timestamp" => time()
		            	);
		        }
			}
		}

		// Add
		$this->jobs_model->update_job_reply($id, array(
			"body" => $body,
			"files" => $files_flag
			)
		);

		// Add Attached files
		foreach($file_data as $file) {
			$this->jobs_model->add_attached_files(array(
				"jobid" => $reply->jobid,
				"replyid" => $id,
				"upload_file_name" => $file['upload_file_name'],
				"file_type" => $file['file_type'],
				"extension" => $file['extension'],
				"file_size" => $file['file_size'],
				"timestamp" => $file['timestamp'],
				"userid" => $this->user->info->ID
				)
			);
		}

		$this->jobs_model->add_history(array(
			"userid" => $this->user->info->ID,
			"message" =>  lang("ctn_651") .$reply->body .
			"<br />".lang("ctn_652").":<br />" . $body,
			"timestamp" => time(),
			"jobid" => $reply->jobid
			)
		);

		$this->session->set_flashdata("globalmsg", lang("success_46"));
		redirect(site_url("jobs/view/" . $reply->jobid));
	}

	public function delete_job_reply($id, $hash)
	{
		if($hash != $this->security->get_csrf_hash()) {
			$this->template->error(lang("error_6"));
		}
		$id = intval($id);
		$reply = $this->jobs_model->get_job_reply($id);
		if($reply->num_rows() == 0) {
			$this->template->error(lang("error_101"));
		}
		$reply = $reply->row();

		if($reply->userid != $this->user->info->ID) {
			// Check user has admin rights
			// Check
			if(!$this->common->has_permissions(array(
				"admin", "job_manager"), $this->user)) {
				$this->template->error(lang("error_85"));
			}
		}

		$this->jobs_model->add_history(array(
			"userid" => $this->user->info->ID,
			"message" => lang("ctn_653").": ". $reply->body,
			"timestamp" => time(),
			"jobid" => $reply->jobid
			)
		);

		$this->jobs_model->delete_job_reply($id);
		$this->session->set_flashdata("globalmsg", lang("success_47"));
		redirect(site_url("jobs/view/" . $reply->jobid));
	}

	public function edit_job($id)
	{
		$id = intval($id);
		$job = $this->jobs_model->get_job($id);
		if($job->num_rows() == 0) {
			$this->template->error(lang("error_84"));
		}
		$job = $job->row();

		// Check user has access
		$this->check_job_access($job);

		$this->template->loadData("activeLink",
			array("job" => array("general" => 1)));

		// Get sub-categories
		$sub_cats = null;
		$sub_cat_fields = null;
		if($job->cat_parent > 0) {
			$sub_cats = $this->jobs_model->get_sub_cats($job->cat_parent);
			$sub_cat_fields = $this->jobs_model->get_custom_fields_for_cat_job($id, $job->categoryid);
		}

		$fields = $this->jobs_model->get_custom_fields_all_cats_job($id);

		$categories = $this->jobs_model->get_category_no_parent();

		$files = $this->jobs_model->get_job_files($id);

		$this->template->loadContent("jobs/edit_job.php", array(
			"job" => $job,
			"categories" => $categories,
			"fields" => $fields,
			"sub_cats" => $sub_cats,
			"sub_cat_fields" => $sub_cat_fields,
			"job_files" => $files
			)
		);

	}

	public function edit_job_pro($id)
	{
		$id = intval($id);
		$job = $this->jobs_model->get_job($id);
		if($job->num_rows() == 0) {
			$this->template->error(lang("error_84"));
		}
		$job = $job->row();

		// Check user has access
		$this->check_job_access($job);

		$title = $this->common->nohtml($this->input->post("title"));
		$client = $this->common->nohtml($this->input->post("client"));
		$guest_email = $this->common->nohtml($this->input->post("guest_email"));
		$assigned = $this->common->nohtml($this->input->post("assigned"));
		$priority = intval($this->input->post("priority"));
		$status = intval($this->input->post("status"));
		$catid = intval($this->input->post("catid"));
		$sub_catid = intval($this->input->post("sub_catid"));

		$file_count = intval($this->input->post("file_count"));

		$body = $this->lib_filter->go($this->input->post("body"));
		$notes = $this->lib_filter->go($this->input->post("notes"));

		if(empty($title)) {
			$this->template->error(lang("error_81"));
		}

		if(empty($body)) {
			$this->template->error(lang("error_92"));
		}

		if($status < 0 || $status > 2) {
			$this->template->error(lang("error_113"));
		}

		if($status == 2) {
			$close_job = date("d-n-Y");
		} else {
			$close_job = "";
		}

		if($priority < 0 || $priority > 3) {
			$this->template->error(lang("error_93"));
		}

		// Get client
		$clientid = 0;
		if(!empty($client)) {
			$user = $this->user_model->get_user_by_username($client);
			if($user->num_rows() == 0) {
				$this->template->error(lang("error_114"));
			}
			$user = $user->row();
			$clientid = $user->ID;
		}

		// Get assigned
		$assignedid = 0;
		if(!empty($assigned)) {
			$user = $this->user_model->get_user_by_username($assigned);
			if($user->num_rows() == 0) {
				$this->template->error(lang("error_115"));
			}
			$user = $user->row();
			$assignedid = $user->ID;
		}

		if($clientid == 0) {
			if($this->settings->info->enable_job_guests) {
				if(empty($guest_email)) {
					$this->template->error(lang("error_116"));
				}
			} else {
				$this->template->error(lang("error_117"));
			}
		}

		// Check categories
		$category = $this->jobs_model->get_category($catid);
		if($category->num_rows() == 0) {
			$this->template->error(lang("error_87"));
		}

		$category = $category->row();

		// Check subcat
		if($sub_catid > 0) {
			$subcat = $this->jobs_model->get_category($sub_catid);
			if($subcat->num_rows() == 0) {
				$this->template->error(lang("error_96"));
			}
			$categoryid = $sub_catid;
		} else {
			$categoryid = $catid;
		}

		if($category->no_jobs && $sub_catid == 0) {
			$this->template->error(lang("error_97"));
		}

		// Custom fields
		$fields = $this->jobs_model->get_custom_fields_all_cats();
		// Process fields
		$answers = array();
		$answers = $this->custom_field_check($fields, $answers);

		// check subcat or primary cat
		if($sub_catid > 0) {
			$fields = $this->jobs_model->get_custom_fields_for_cat($sub_catid);
		} else {
			$fields = $this->jobs_model->get_custom_fields_for_cat($catid);
		}
		$answers = $this->custom_field_check($fields, $answers);

		// Upload check
		$this->load->library("upload");

		$file_data = array();
		if($this->settings->info->enable_job_uploads) {
			for($i=1;$i<=$file_count;$i++) {
				if (isset($_FILES['user_file_' . $i]['size'])
					&& $_FILES['user_file_' . $i]['size'] > 0) {
					$this->upload->initialize(array(
					   "upload_path" => $this->settings->info->upload_path,
				       "overwrite" => FALSE,
				       "max_filename" => 300,
				       "encrypt_name" => TRUE,
				       "remove_spaces" => TRUE,
				       "allowed_types" => $this->settings->info->file_types,
				       "max_size" => $this->settings->info->file_size,
						)
					);

					if ( ! $this->upload->do_upload('user_file_' . $i))
		            {
		                    $error = array('error' => $this->upload->display_errors());

		                    $this->template->error(lang("error_98") . "<br /><br />" .
		                    	 $this->upload->display_errors());
		            }

		            $data = $this->upload->data();

		            $file_data[] = array(
		            	"upload_file_name" => $data['file_name'],
		            	"file_type" => $data['file_type'],
		            	"extension" => $data['file_ext'],
		            	"file_size" => $data['file_size'],
		            	"timestamp" => time()
		            	);
		        }
			}
		}

		// Create job
		$this->jobs_model->update_job($id, array(
			"title" => $title,
			"body" => $body,
			"userid" => $clientid,
			"assignedid" => $assignedid,
			"categoryid" => $categoryid,
			"status" => $status,
			"priority" => $priority,
			"notes" => $notes,
			"guest_email" => $guest_email,
			"close_job_date" => $close_job
			)
		);

		// Wipe out all old custom field data
		$this->jobs_model->delete_custom_field_data($id);

		// Custom field data
		foreach($answers as $d) {
			$itemname = "";
			$support = 0;
			$error = "";
			if(isset($d['itemname'])) {
				$itemname = $d['itemname'];
				$support = $d['support'];
				$error = $d['error'];
			}
			$this->jobs_model->add_custom_field_data(array(
				"jobid" => $id,
				"fieldid" => $d['fieldid'],
				"value" => $d['answer'],
				"itemname" => $itemname,
				"support" => $support,
				"error" => $error
				)
			);
		}

		// Add Attached files
		foreach($file_data as $file) {
			$this->jobs_model->add_attached_files(array(
				"jobid" => $id,
				"upload_file_name" => $file['upload_file_name'],
				"file_type" => $file['file_type'],
				"extension" => $file['extension'],
				"file_size" => $file['file_size'],
				"timestamp" => $file['timestamp'],
				"userid" => $this->user->info->ID
				)
			);
		}

		$this->jobs_model->add_history(array(
			"userid" => $this->user->info->ID,
			"message" => lang("ctn_666"),
			"timestamp" => time(),
			"jobid" => $id
			)
		);

		$this->session->set_flashdata("globalmsg", lang("success_48"));
		redirect(site_url("jobs"));



	}

	public function delete_file_attachment($id, $hash)
	{
		if($hash != $this->security->get_csrf_hash()) {
			$this->template->error(lang("error_6"));
		}

		$id = intval($id);
		$file = $this->jobs_model->get_job_file($id);
		if($file->num_rows() == 0) {
			$this->template->error(lang("error_107"));
		}
		$file = $file->row();

		if($file->userid != $this->user->info->ID) {
			// Check user has admin rights
			// Check
			if(!$this->common->has_permissions(array(
				"admin", "job_manager"), $this->user)) {
				$this->template->error(lang("error_85"));
			}
		}

		$this->jobs_model->add_history(array(
			"userid" => $this->user->info->ID,
			"message" => lang("ctn_667"),
			"timestamp" => time(),
			"jobid" => $file->jobid
			)
		);

		$this->jobs_model->delete_job_file($id);
		$this->session->set_flashdata("globalmsg", lang("success_49"));
		redirect(site_url("jobs/view/" . $file->jobid));
	}

	public function delete_job($id, $hash)
	{
		if($hash != $this->security->get_csrf_hash()) {
			$this->template->error(lang("error_6"));
		}
		$id = intval($id);
		$job = $this->jobs_model->get_job($id);
		if($job->num_rows() == 0) {
			$this->template->error(lang("error_84"));
		}
		$job = $job->row();

		// Check user has access
		$this->check_job_access($job);

		$this->jobs_model->delete_job($id);
		$this->session->set_flashdata("globalmsg", lang("success_57"));
		redirect(site_url("jobs"));
	}

	public function add()
	{
		$this->template->loadData("activeLink",
			array("job" => array("general" => 1)));

		$fields = $this->jobs_model->get_custom_fields_all_cats();

		$categories = $this->jobs_model->get_category_no_parent();

		$this->template->loadContent("jobs/add.php", array(
			"categories" => $categories,
			"fields" => $fields
			)
		);
	}

	public function add_pro()
	{
		$title = $this->common->nohtml($this->input->post("title"));
		$client = $this->common->nohtml($this->input->post("client"));
		$guest_email = $this->common->nohtml($this->input->post("guest_email"));
		$assigned = $this->common->nohtml($this->input->post("assigned"));
		$priority = intval($this->input->post("priority"));
		$status = intval($this->input->post("status"));
		$catid = intval($this->input->post("catid"));
		$sub_catid = intval($this->input->post("sub_catid"));

		$file_count = intval($this->input->post("file_count"));

		$body = $this->lib_filter->go($this->input->post("body"));
		$notes = $this->lib_filter->go($this->input->post("notes"));

		if(empty($title)) {
			$this->template->error(lang("error_81"));
		}

		if(empty($body)) {
			$this->template->error(lang("error_92"));
		}

		if($status < 0 || $status > 2) {
			$this->template->error(lang("error_113"));
		}

		if($priority < 0 || $priority > 3) {
			$this->template->error(lang("error_93"));
		}

		// Get client
		$clientid = 0;
		$client_username = "";
		if(!empty($client)) {
			$user = $this->user_model->get_user_by_username($client);
			if($user->num_rows() == 0) {
				$this->template->error(lang("error_114"));
			}
			$user = $user->row();
			$client_username = $user->username;
			$client_email = $user->email;
			$clientid = $user->ID;
		}

		// Get assigned
		$assignedid = 0;
		if(!empty($assigned)) {
			$user = $this->user_model->get_user_by_username($assigned);
			if($user->num_rows() == 0) {
				$this->template->error(lang("error_115"));
			}
			$user = $user->row();
			$assignedid = $user->ID;
		}

		if($clientid == 0) {
			if($this->settings->info->enable_job_guests) {
				if(empty($guest_email)) {
					$this->template->error(lang("error_116"));
				}
			} else {
				$this->template->error(lang("error_117"));
			}
		}

		// Check categories
		$category = $this->jobs_model->get_category($catid);
		if($category->num_rows() == 0) {
			$this->template->error(lang("error_87"));
		}

		$category = $category->row();

		// Check subcat
		if($sub_catid > 0) {
			$subcat = $this->jobs_model->get_category($sub_catid);
			if($subcat->num_rows() == 0) {
				$this->template->error(lang("error_96"));
			}
			$categoryid = $sub_catid;
		} else {
			$categoryid = $catid;
		}

		if($category->no_jobs && $sub_catid == 0) {
			$this->template->error(lang("error_97"));
		}

		// Custom fields
		$fields = $this->jobs_model->get_custom_fields_all_cats();
		// Process fields
		$answers = array();
		$answers = $this->custom_field_check($fields, $answers);

		// check subcat or primary cat
		if($sub_catid > 0) {
			$fields = $this->jobs_model->get_custom_fields_for_cat($sub_catid);
		} else {
			$fields = $this->jobs_model->get_custom_fields_for_cat($catid);
		}
		$answers = $this->custom_field_check($fields, $answers);

		// Upload check
		$this->load->library("upload");

		$file_data = array();
		if($this->settings->info->enable_job_uploads) {
			for($i=1;$i<=$file_count;$i++) {
				if (isset($_FILES['user_file_'. $i])
					&& $_FILES['user_file_' . $i]['size'] > 0) {
					$this->upload->initialize(array(
					   "upload_path" => $this->settings->info->upload_path,
				       "overwrite" => FALSE,
				       "max_filename" => 300,
				       "encrypt_name" => TRUE,
				       "remove_spaces" => TRUE,
				       "allowed_types" => $this->settings->info->file_types,
				       "max_size" => $this->settings->info->file_size,
						)
					);

					if ( ! $this->upload->do_upload('user_file_' . $i))
		            {
		                    $error = array('error' => $this->upload->display_errors());

		                    $this->template->error(lang("error_98") . "<br /><br />" .
		                    	 $this->upload->display_errors());
		            }

		            $data = $this->upload->data();

		            $file_data[] = array(
		            	"upload_file_name" => $data['file_name'],
		            	"file_type" => $data['file_type'],
		            	"extension" => $data['file_ext'],
		            	"file_size" => $data['file_size'],
		            	"timestamp" => time()
		            	);
		        }
			}
		}

		// Notifications

		// Create job
		// Message id hash
		$message_id_hash = md5(rand(1,100000) . $title . time());
		$guest_password = $this->common->randomPassword();

		// Create job
		$jobid = $this->jobs_model->add_job(array(
			"title" => $title,
			"body" => $body,
			"userid" => $clientid,
			"assignedid" => $assignedid,
			"timestamp" => time(),
			"categoryid" => $categoryid,
			"status" => $status,
			"priority" => $priority,
			"last_reply_timestamp" => time(),
			"last_reply_string" => date($this->settings->info->date_format, time()),
			"notes" => $notes,
			"message_id_hash" => $message_id_hash,
			"guest_email" => $guest_email,
			"guest_password" => $guest_password,
			"job_date" => date("d-n-Y")
			)
		);

		// Custom field data
		foreach($answers as $d) {
			$itemname = "";
			$support = 0;
			$error = "";
			if(isset($d['itemname'])) {
				$itemname = $d['itemname'];
				$support = $d['support'];
				$error = $d['error'];
			}
			$this->jobs_model->add_custom_field_data(array(
				"jobid" => $jobid,
				"fieldid" => $d['fieldid'],
				"value" => $d['answer'],
				"itemname" => $itemname,
				"support" => $support,
				"error" => $error
				)
			);
		}

		// Add Attached files
		foreach($file_data as $file) {
			$this->jobs_model->add_attached_files(array(
				"jobid" => $jobid,
				"upload_file_name" => $file['upload_file_name'],
				"file_type" => $file['file_type'],
				"extension" => $file['extension'],
				"file_size" => $file['file_size'],
				"timestamp" => $file['timestamp'],
				"userid" => $this->user->info->ID
				)
			);
		}

		$this->jobs_model->add_history(array(
			"userid" => $this->user->info->ID,
			"message" => lang("ctn_668"),
			"timestamp" => time(),
			"jobid" => $jobid
			)
		);

		if($clientid > 0) {
			if(!isset($_COOKIE['language'])) {
				// Get first language in list as default
				$lang = $this->config->item("language");
			} else {
				$lang = $this->common->nohtml($_COOKIE["language"]);
			}

			// Send Email
			$email_template = $this->home_model->get_email_template_hook("job_creation", $lang);
			if($email_template->num_rows() == 0) {
				$this->template->error(lang("error_48"));
			}
			$email_template = $email_template->row();

			if($clientid == 0) {
				$username = $guest_email;
				$email = $guest_email;
			} else {
				$username = $client_username;
				$email = $client_email;
			}

			$email_template->message = $this->common->replace_keywords(array(
				"[NAME]" => $username,
				"[SITE_URL]" => site_url(),
				"[TICKET_BODY]" => $body,
				"[TICKET_ID]" => $jobid,
				"[SITE_NAME]" =>  $this->settings->info->site_name,
				"[IMAP_TICKET_REPLY_STRING]" => $this->settings->info->imap_reply_string,
				"[IMAP_TICKET_ID]" => $this->settings->info->imap_job_string
				),
			$email_template->message);

			$headers = array(
				"Message-ID" => $message_id_hash
				);
			$this->common->send_email($this->settings->info->job_title . " [ID: " . $jobid . "]: " . $title,
				 $email_template->message, $email, $headers);
		} else {
				// Send email
				if(!isset($_COOKIE['language'])) {
					// Get first language in list as default
					$lang = $this->config->item("language");
				} else {
					$lang = $this->common->nohtml($_COOKIE["language"]);
				}

				// Send Email
				$email_template = $this->home_model->get_email_template_hook("guest_job_creation", $lang);
				if($email_template->num_rows() == 0) {
					$this->template->error(lang("error_48"));
				}
				$email_template = $email_template->row();

				if($clientid == 0) {
					$username = $guest_email;
					$email = $guest_email;
				} else {
					$username = $client_username;
					$email = $client_email;
				}

				$email_template->message = $this->common->replace_keywords(array(
					"[NAME]" => $username,
					"[SITE_URL]" => site_url(),
					"[TICKET_BODY]" => $body,
					"[TICKET_ID]" => $jobid,
					"[SITE_NAME]" =>  $this->settings->info->site_name,
					"[GUEST_EMAIL]" => $guest_email,
					"[GUEST_PASS]" => $guest_password,
					"[GUEST_LOGIN]" => site_url("client/jobs"),
					"[IMAP_TICKET_REPLY_STRING]" => $this->settings->info->imap_reply_string,
					"[IMAP_TICKET_ID]" => $this->settings->info->imap_job_string
					),
				$email_template->message);

				$headers = array(
					"Message-ID" => $message_id_hash
					);
				$this->common->send_email($this->settings->info->job_title . " [ID: " . $jobid . "]: " . $title,
					 $email_template->message, $email, $headers);
			}
		$this->session->set_flashdata("globalmsg", lang("success_44"));
		redirect(site_url("jobs"));


	}

	private function custom_field_check($fields, $answers)
	{
		foreach($fields->result() as $r) {
			$answer = "";
			if($r->type == 0) {
				// Look for simple text entry
				$answer = $this->common->nohtml($this->input->post("cf_" . $r->ID));

				if($r->required && (empty($answer) && $answer !== '0') ) {
					$this->template->error(lang("error_99") . $r->name);
				}
				// Add
				$answers[] = array(
					"fieldid" => $r->ID,
					"answer" => $answer
				);
			} elseif($r->type == 1) {
				// HTML
				$answer = $this->lib_filter->go($this->input->post("cf_" . $r->ID));

				if($r->required && (empty($answer) && $answer !== '0')) {
					$this->template->error(lang("error_99") . $r->name);
				}
				// Add
				$answers[] = array(
					"fieldid" => $r->ID,
					"answer" => $answer
				);
			} elseif($r->type == 2) {
				// Checkbox
				$options = explode(",", $r->options);
				foreach($options as $k=>$v) {
					// Look for checked checkbox and add it to the answer if it's value is 1
					$ans = $this->common->nohtml($this->input->post("cf_cb_" . $r->ID . "_" . $k));
					if($ans) {
						if(empty($answer)) {
							$answer .= $v;
						} else {
							$answer .= ", " . $v;
						}
					}
				}

				if($r->required && (empty($answer) && $answer !== '0')) {
					$this->template->error(lang("error_99") . $r->name);
				}
				$answers[] = array(
					"fieldid" => $r->ID,
					"answer" => $answer
				);

			} elseif($r->type == 3) {
				// radio
				$options = explode(",", $r->options);
				if(isset($_POST['cf_radio_' . $r->ID])) {
					$answer = intval($this->common->nohtml($this->input->post("cf_radio_" . $r->ID)));

					$flag = false;
					foreach($options as $k=>$v) {
						if($k == $answer) {
							$flag = true;
							$answer = $v;
						}
					}
					if($r->required && !$flag) {
						$this->template->error(lang("error_99") . $r->name);
					}
					if($flag) {
						$answers[] = array(
							"fieldid" => $r->ID,
							"answer" => $answer
						);
					}
				}

			} elseif($r->type == 4) {
				// Dropdown menu
				$options = explode(",", $r->options);
				$answer = intval($this->common->nohtml($this->input->post("cf_" . $r->ID)));
				$flag = false;
				foreach($options as $k=>$v) {
					if($k == $answer) {
						$flag = true;
						$answer = $v;
					}
				}
				if($r->required && !$flag) {
					$this->template->error(lang("error_99") . $r->name);
				}
				if($flag) {
					$answers[] = array(
						"fieldid" => $r->ID,
						"answer" => $answer
					);
				}
			} elseif($r->type == 5) {
				// Look for simple text entry
				$answer = $this->common->nohtml($this->input->post("cf_" . $r->ID));

				if($r->required && (empty($answer) && $answer !== '0')) {
					$this->template->error(lang("error_99") . $r->name);
				}

				$this->load->library("Envato");

				$error = "";
				$timestamp = 0;
				$itemname = "";

				$result = $this->envato->check_item_code($answer);
				if(isset($result->error)) {
					$error = $result->error . " " . $result->description;
				} else {
					// Check for item name
					if(isset($result->item->name)) {
						$itemname = $result->item->name;
						$support = $result->supported_until;

						$ed = DateTime::createFromFormat('Y-m-d\TH:i:s\+10:00', $support);
						$end_date = $ed->format('Y-m-d\TH:i:s');
						$timestamp = $ed->getTimestamp();
					}
				}
				// Add
				$answers[] = array(
					"fieldid" => $r->ID,
					"answer" => $answer,
					"itemname" => $itemname,
					"support" => $timestamp,
					"error" => $error
				);
			}
		}
		return $answers;
	}

	public function get_custom_fields($catid)
	{
		$catid = intval($catid);
		$category = $this->jobs_model->get_category($catid);
		if($category->num_rows() == 0) {
			$this->template->errori(lang("error_104"));
		}

		$fields = $this->jobs_model->get_custom_fields_for_cat($catid);
		$this->template->loadAjax("jobs/ajax_custom_fields.php", array(
				"fields" => $fields
				), 1
			);
	}

	public function get_sub_cats($parent)
	{
		$parent = intval($parent);
		$category = $this->jobs_model->get_category($parent);
		if($category->num_rows() == 0) {
			$this->template->errori(lang("error_104"));
		}
		$category = $category->row();

		if($category->cat_parent > 0) {
			$this->template->errori(lang("error_105"));
		}

		// Get sub cats
		$sub_cats = $this->jobs_model->get_sub_cats($parent);
		if($sub_cats->num_rows() > 0) {
			$this->template->loadAjax("jobs/sub_cats.php", array(
				"categories" => $sub_cats
				), 1
			);
		} else {
			exit();
		}
	}

	public function custom_fields()
	{
		if(!$this->common->has_permissions(array(
			"admin", "job_manager"), $this->user)) {
			$this->template->error(lang("error_85"));
		}
		$this->template->loadData("activeLink",
			array("job" => array("custom" => 1)));


		// $this->template->loadContent("jobs/custom_fields.php", array(
		// 	)
		// );
		$this->template->loadContent("jobs/custom_fields.php", array("data" => $this->field_page()));
	}

	public function field_page()
	{
		if(!$this->common->has_permissions(array(
			"admin", "job_manager"), $this->user)) {
			$this->template->error(lang("error_85"));
		}
		$this->load->library("datatables");

		$this->datatables->set_default_order("job_custom_fields.ID", "desc");

		// Set page ordering options that can be used
		$this->datatables->ordering(
			array(
				 0 => array(
				 	"job_custom_fields.name" => 0
				 ),
				 1 => array(
				 	"job_custom_fields.type" => 0
				 )
			)
		);

		$this->datatables->set_total_rows(
			$this->jobs_model
				->get_custom_fields_total()
		);
		$fields = $this->jobs_model->get_custom_fields($this->datatables);
		$data = array();

		foreach($fields->result() as $r) {
			if($r->type == 0) {
				$type = lang("ctn_357");
			} elseif($r->type == 1) {
				$type = lang("ctn_577");
			} elseif($r->type == 2) {
				$type = lang("ctn_578");
			} elseif($r->type == 3) {
				$type = lang("ctn_579");
			} elseif($r->type == 4) {
				$type = lang("ctn_580");
			} elseif($r->type == 5) {
				$type = lang("ctn_679");
			}

			array_push($data, array("field_name" => $r->name,
				"field_id" => $r->ID,
				"field_type" => $type,
				"edit_field" => '<a href="'.site_url("jobs/edit_custom_field/" . $r->ID).'" class="btn btn-warning btn-xs" data-toggle="tooltip" data-placement="bottom" title="'.lang("ctn_55").'"><span class="glyphicon glyphicon-cog"></span></a> <a href="'.site_url("jobs/delete_custom_field/" . $r->ID . "/" . $this->security->get_csrf_hash()).'" class="btn btn-danger btn-xs" onclick="return confirm(\''.lang("ctn_317").'\')" data-toggle="tooltip" data-placement="bottom" title="'.lang("ctn_57").'"><span class="glyphicon glyphicon-trash"></span></a>'
			));
		}

		return $data;
	}

	public function edit_custom_field($id)
	{
		if(!$this->common->has_permissions(array(
			"admin", "job_manager"), $this->user)) {
			$this->template->error(lang("error_85"));
		}
		$this->template->loadExternal(
			'<link href="'.base_url().'scripts/libraries/chosen/chosen.min.css" rel="stylesheet" type="text/css">
			<script type="text/javascript" src="'.base_url().
			'scripts/libraries/chosen/chosen.jquery.min.js"></script>'
		);
		$this->template->loadData("activeLink",
			array("job" => array("custom" => 1)));
		$id = intval($id);
		$field = $this->jobs_model->get_custom_field($id);
		if($field->num_rows() == 0) {
			$this->template->error(lang("error_118"));
		}

		$field = $field->row();

		$user_cats = $this->jobs_model->get_field_cats($field->ID);

		$this->template->loadContent("jobs/edit_custom_field.php", array(
			"field" => $field,
			"user_cats" => $user_cats
			)
		);

	}

	public function edit_custom_field_pro($id)
	{
		if(!$this->common->has_permissions(array(
			"admin", "job_manager"), $this->user)) {
			$this->template->error(lang("error_85"));
		}
		$this->template->loadData("activeLink",
			array("job" => array("custom" => 1)));
		$id = intval($id);
		$field = $this->jobs_model->get_custom_field($id);
		if($field->num_rows() == 0) {
			$this->template->error(lang("error_118"));
		}
		$field = $field->row();

		$name = $this->common->nohtml($this->input->post("name"));
		$type = intval($this->input->post("type"));
		$required = intval($this->input->post("required"));
		$options = $this->common->nohtml($this->input->post("options"));
		$help_text = $this->common->nohtml($this->input->post("help_text"));

		$user_cats = $this->input->post("user_cats");
		$all_cats = intval($this->input->post("all_cats"));

		$hide_clientside = intval($this->input->post("hide_clientside"));

		if(empty($name)) {
			$this->template->error(lang("error_119"));
		}

		// Check job categories
		$cats= array();
		if($user_cats) {
			foreach($user_cats as $cat) {
				$cat = intval($cat);
				if($cat > 0) {
					$catr = $this->jobs_model->get_category($cat);
					if($catr->num_rows() == 0) {
						$this->template->error(lang("error_110"));
					}
				}
				$cats[] = $cat;
			}
		}

		$this->jobs_model->update_custom_field($id, array(
			"name" => $name,
			"type" => $type,
			"required" => $required,
			"options" => $options,
			"help_text" => $help_text,
			"all_cats" => $all_cats,
			"hide_clientside" => $hide_clientside
			)
		);


		$this->jobs_model->delete_custom_fields_cats($id);

		// Add custom field to cats
		foreach($cats as $catid) {
			$this->jobs_model->add_field_cats(array(
				"fieldid" => $id,
				"catid" => $catid
				)
			);
		}

		$this->session->set_flashdata("globalmsg", lang("success_58"));
		redirect(site_url("jobs/custom_fields"));
	}

	public function delete_custom_field($id, $hash)
	{
		if(!$this->common->has_permissions(array(
			"admin", "job_manager"), $this->user)) {
			$this->template->error(lang("error_85"));
		}
		if($hash != $this->security->get_csrf_hash()) {
			$this->template->error(lang("error_6"));
		}
		$id = intval($id);
		$field = $this->jobs_model->get_custom_field($id);
		if($field->num_rows() == 0) {
			$this->template->error(lang("error_118"));
		}

		$this->jobs_model->delete_custom_field($id);
		$this->session->set_flashdata("globalmsg", lang("success_39"));
		redirect(site_url("jobs/custom_fields"));
	}

	public function add_custom_field()
	{
		if(!$this->common->has_permissions(array(
			"admin", "job_manager"), $this->user)) {
			$this->template->error(lang("error_85"));
		}
		$this->template->loadExternal(
			'<link href="'.base_url().'scripts/libraries/chosen/chosen.min.css" rel="stylesheet" type="text/css">
			<script type="text/javascript" src="'.base_url().
			'scripts/libraries/chosen/chosen.jquery.min.js"></script>'
		);
		$this->template->loadData("activeLink",
			array("job" => array("custom" => 1)));

		$categories = $this->jobs_model->get_categories();


		$this->template->loadContent("jobs/add_custom_field.php", array(
			"categories" => $categories
			)
		);
	}

	public function add_custom_field_pro()
	{
		if(!$this->common->has_permissions(array(
			"admin", "job_manager"), $this->user)) {
			$this->template->error(lang("error_85"));
		}
		$name = $this->common->nohtml($this->input->post("name"));
		$type = intval($this->input->post("type"));
		$required = intval($this->input->post("required"));
		$options = $this->common->nohtml($this->input->post("options"));
		$help_text = $this->common->nohtml($this->input->post("help_text"));

		$user_cats = $this->input->post("user_cats");
		$all_cats = intval($this->input->post("all_cats"));

		$hide_clientside = intval($this->input->post("hide_clientside"));

		if(empty($name)) {
			$this->template->error(lang("error_119"));
		}

		// Check job categories
		$cats= array();
		if($user_cats) {
			foreach($user_cats as $cat) {
				$cat = intval($cat);
				if($cat > 0) {
					$catr = $this->jobs_model->get_category($cat);
					if($catr->num_rows() == 0) {
						$this->template->error(lang("error_110"));
					}
				}
				$cats[] = $cat;
			}
		}

		$customid = $this->jobs_model->add_custom_field(array(
			"name" => $name,
			"type" => $type,
			"required" => $required,
			"options" => $options,
			"help_text" => $help_text,
			"all_cats" => $all_cats,
			"hide_clientside" => $hide_clientside
			)
		);


		// Add custom field to cats
		foreach($cats as $catid) {
			$this->jobs_model->add_field_cats(array(
				"fieldid" => $customid,
				"catid" => $catid
				)
			);
		}

		$this->session->set_flashdata("globalmsg", lang("success_59"));
		redirect(site_url("jobs/custom_fields"));


	}

	public function categories()
	{
		if(!$this->common->has_permissions(array(
			"admin", "job_manager"), $this->user)) {
			$this->template->error(lang("error_85"));
		}
		$this->template->loadExternal(
			'<link href="'.base_url().'scripts/libraries/chosen/chosen.min.css" rel="stylesheet" type="text/css">
			<script type="text/javascript" src="'.base_url().
			'scripts/libraries/chosen/chosen.jquery.min.js"></script>'
		);
		$this->template->loadData("activeLink",
			array("job" => array("cats" => 1)));

		$categories = $this->jobs_model->get_categories();
		$user_groups = $this->user_model->get_all_user_groups();

		$this->template->loadContent("jobs/categories.php", array(
			"categories" => $categories,
			"user_groups" => $user_groups
			)
		);
	}

	public function cat_page()
	{
		if(!$this->common->has_permissions(array(
			"admin", "job_manager"), $this->user)) {
			$this->template->error(lang("error_85"));
		}
		$this->load->library("datatables");

		$this->datatables->set_default_order("job_categories.name", "asc");

		// Set page ordering options that can be used
		$this->datatables->ordering(
			array(
				 1 => array(
				 	"job_categories.name" => 0
				 ),
				 2 => array(
				 	"t_c.name" => 0
				 )
			)
		);

		$this->datatables->set_total_rows(
			$this->jobs_model
				->get_categories_total()
		);
		$cats = $this->jobs_model->get_categories_dt($this->datatables);


		foreach($cats->result() as $r) {

			if(isset($r->name2)) {
				$cat_parent = $r->name2;
			} else {
				$cat_parent = lang("ctn_46");
			}

			$this->datatables->data[] = array(
				'<img src="'.base_url().$this->settings->info->upload_path_relative.'/'.$r->image.'" class="cat-icon">',
				$r->name,
				$cat_parent,
				'<a href="'.site_url("jobs/edit_cat/" . $r->ID).'" class="btn btn-warning btn-xs" data-toggle="tooltip" data-placement="bottom" title="'.lang("ctn_55").'"><span class="glyphicon glyphicon-cog"></span></a> <a href="'.site_url("jobs/delete_cat/" . $r->ID . "/" . $this->security->get_csrf_hash()).'" class="btn btn-danger btn-xs" onclick="return confirm(\''.lang("ctn_317").'\')" data-toggle="tooltip" data-placement="bottom" title="'.lang("ctn_57").'"><span class="glyphicon glyphicon-trash"></span></a>'
			);
		}

		echo json_encode($this->datatables->process());
	}

	public function add_category_pro()
	{
		if(!$this->common->has_permissions(array(
			"admin", "job_manager"), $this->user)) {
			$this->template->error(lang("error_85"));
		}
		$name = $this->common->nohtml($this->input->post("name"));
		$desc = $this->lib_filter->go($this->input->post("description"));
		$cat_parent = intval($this->input->post("cat_parent"));
		$no_jobs = intval($this->input->post("no_jobs"));

		$user_groups = $this->input->post("user_groups");

		// Check job categories
		$groups= array();
		if($user_groups) {
			foreach($user_groups as $groupid) {
				$groupid = intval($groupid);
				if($groupid > 0) {
					$group = $this->user_model->get_user_group($groupid);
					if($group->num_rows() == 0) {
						$this->template->error(lang("error_120"));
					}
				}
				$groups[] = $groupid;
			}
		}

		$this->load->library("upload");

		// Image
		if ($_FILES['userfile']['size'] > 0) {
			$this->upload->initialize(array(
		       "upload_path" => $this->settings->info->upload_path,
		       "overwrite" => FALSE,
		       "max_filename" => 300,
		       "encrypt_name" => TRUE,
		       "remove_spaces" => TRUE,
		       "allowed_types" => "png|jpeg|jpg|gif",
		       "max_size" => $this->settings->info->file_size,
		    ));

		    if (!$this->upload->do_upload()) {
		    	$this->template->error(lang("error_21")
		    	.$this->upload->display_errors());
		    }

		    $data = $this->upload->data();

		    $image = $data['file_name'];
		} else {
			$image= "default_cat.png";
		}

		if(empty($name)) {
			$this->template->error(lang("error_111"));
		}

		if($cat_parent > 0) {
			$cat = $this->jobs_model->get_category($cat_parent);
			if($cat->num_rows() == 0) {
				$this->template->error(lang("error_121"));
			}
		}



		$catid = $this->jobs_model->add_category(array(
			"name" => $name,
			"description" => $desc,
			"cat_parent" => $cat_parent,
			"image" => $image,
			"no_jobs" => $no_jobs
			)
		);

		// Add custom field to cats
		foreach($groups as $groupid) {
			$this->jobs_model->add_category_group(array(
				"groupid" => $groupid,
				"catid" => $catid
				)
			);
		}

		$this->session->set_flashdata("globalmsg", lang("success_53"));
		redirect(site_url("jobs/categories"));
	}

	public function delete_cat($id, $hash)
	{
		if(!$this->common->has_permissions(array(
			"admin", "job_manager"), $this->user)) {
			$this->template->error(lang("error_85"));
		}
		if($hash != $this->security->get_csrf_hash()) {
			$this->template->error(lang("error_6"));
		}
		$id = intval($id);
		$category = $this->jobs_model->get_category($id);
		if($category->num_rows() == 0) {
			$this->template->error(lang("error_110"));
		}

		$this->jobs_model->delete_category($id);
		$this->session->set_flashdata("globalmsg", lang("success_60"));
		redirect(site_url("jobs/categories"));
	}

	public function edit_cat($id)
	{
		if(!$this->common->has_permissions(array(
			"admin", "job_manager"), $this->user)) {
			$this->template->error(lang("error_85"));
		}
		$this->template->loadExternal(
			'<link href="'.base_url().'scripts/libraries/chosen/chosen.min.css" rel="stylesheet" type="text/css">
			<script type="text/javascript" src="'.base_url().
			'scripts/libraries/chosen/chosen.jquery.min.js"></script>'
		);
		$id = intval($id);
		$category = $this->jobs_model->get_category($id);
		if($category->num_rows() == 0) {
			$this->template->error(lang("error_110"));
		}

		$category = $category->row();

		$this->template->loadData("activeLink",
			array("job" => array("cats" => 1)));

		$categories = $this->jobs_model->get_categories();

		$user_groups = $this->jobs_model->get_cat_groups($id);

		$this->template->loadContent("jobs/edit_cat.php", array(
			"categories" => $categories,
			"category" => $category,
			"user_groups" => $user_groups
			)
		);
	}

	public function edit_category_pro($id)
	{
		if(!$this->common->has_permissions(array(
			"admin", "job_manager"), $this->user)) {
			$this->template->error(lang("error_85"));
		}
		$id = intval($id);
		$category = $this->jobs_model->get_category($id);
		if($category->num_rows() == 0) {
			$this->template->error(lang("error_110"));
		}

		$category = $category->row();

		$name = $this->common->nohtml($this->input->post("name"));
		$desc = $this->lib_filter->go($this->input->post("description"));
		$cat_parent = intval($this->input->post("cat_parent"));
		$no_jobs = intval($this->input->post("no_jobs"));

		$user_groups = $this->input->post("user_groups");

		// Check job categories
		$groups= array();
		if($user_groups) {
			foreach($user_groups as $groupid) {
				$groupid = intval($groupid);
				if($groupid > 0) {
					$group = $this->user_model->get_user_group($groupid);
					if($group->num_rows() == 0) {
						$this->template->error(lang("error_120"));
					}
				}
				$groups[] = $groupid;
			}
		}

		$this->load->library("upload");

		// Image
		if ($_FILES['userfile']['size'] > 0) {
			$this->upload->initialize(array(
		       "upload_path" => $this->settings->info->upload_path,
		       "overwrite" => FALSE,
		       "max_filename" => 300,
		       "encrypt_name" => TRUE,
		       "remove_spaces" => TRUE,
		       "allowed_types" => "png|jpeg|jpg|gif",
		       "max_size" => $this->settings->info->file_size,
		    ));

		    if (!$this->upload->do_upload()) {
		    	$this->template->error(lang("error_21")
		    	.$this->upload->display_errors());
		    }

		    $data = $this->upload->data();

		    $image = $data['file_name'];
		} else {
			$image= $category->image;
		}

		if(empty($name)) {
			$this->template->error(lang("error_111"));
		}

		if($cat_parent > 0) {
			$cat = $this->jobs_model->get_category($cat_parent);
			if($cat->num_rows() == 0) {
				$this->template->error(lang("error_121"));
			}
			if($cat_parent == $category->ID) {
				$this->template->error(lang("error_122"));
			}
		}

		$this->jobs_model->update_category($id, array(
			"name" => $name,
			"description" => $desc,
			"image" => $image,
			"cat_parent" => $cat_parent,
			"no_jobs" => $no_jobs
			)
		);

		$this->jobs_model->delete_category_groups($id);

		// Add custom field to cats
		foreach($groups as $groupid) {
			$this->jobs_model->add_category_group(array(
				"groupid" => $groupid,
				"catid" => $id
				)
			);
		}


		$this->session->set_flashdata("globalmsg", lang("success_55"));
		redirect(site_url("jobs/categories"));
	}

	public function canned_responses()
	{
		$this->template->loadData("activeLink",
			array("job" => array("canned" => 1)));
		$this->template->loadContent("jobs/canned_responses.php", array(
			)
		);
	}

	public function canned_page()
	{
		$this->load->library("datatables");

		$this->datatables->set_default_order("canned_responses.ID", "desc");

		// Set page ordering options that can be used
		$this->datatables->ordering(
			array(
				 0 => array(
				 	"canned_responses.title" => 0
				 )
			)
		);

		$this->datatables->set_total_rows(
			$this->jobs_model
				->get_canned_total()
		);
		$canned = $this->jobs_model->get_canned_responses($this->datatables);


		foreach($canned->result() as $r) {

			$this->datatables->data[] = array(
				$r->title,
				'<a href="'.site_url("jobs/edit_canned_response/" . $r->ID).'" class="btn btn-warning btn-xs" data-toggle="tooltip" data-placement="bottom" title="'.lang("ctn_55").'"><span class="glyphicon glyphicon-cog"></span></a> <a href="'.site_url("jobs/delete_canned_response/" . $r->ID . "/" . $this->security->get_csrf_hash()).'" class="btn btn-danger btn-xs" onclick="return confirm(\''.lang("ctn_317").'\')" data-toggle="tooltip" data-placement="bottom" title="'.lang("ctn_57").'"><span class="glyphicon glyphicon-trash"></span></a>'
			);
		}

		echo json_encode($this->datatables->process());
	}

	public function add_canned_response()
	{
		$this->template->loadData("activeLink",
			array("job" => array("canned" => 1)));

		$this->template->loadContent("jobs/add_canned_responses.php", array(
			)
		);
	}

	public function add_canned_response_pro()
	{
		$title = $this->common->nohtml($this->input->post("title"));
		$body = $this->lib_filter->go($this->input->post("body"));

		if(empty($title)) {
			$this->template->error(lang("error_81"));
		}

		$this->jobs_model->add_canned_response(array(
			"title" => $title,
			"body" => $body
			)
		);
		$this->session->set_flashdata("globalmsg", lang("success_61"));
		redirect(site_url("jobs/canned_responses"));

	}

	public function edit_canned_response($id)
	{
		$this->template->loadData("activeLink",
			array("job" => array("canned" => 1)));

		$id = intval($id);
		$canned = $this->jobs_model->get_canned_response($id);
		if($canned->num_rows() == 0) {
			$this->template->error(lang("error_123"));
		}
		$canned = $canned->row();
		$this->template->loadContent("jobs/edit_canned_response.php", array(
			"canned" => $canned
			)
		);
	}

	public function edit_canned_response_pro($id)
	{
		$id = intval($id);
		$canned = $this->jobs_model->get_canned_response($id);
		if($canned->num_rows() == 0) {
			$this->template->error(lang("error_123"));
		}
		$canned = $canned->row();

		$title = $this->common->nohtml($this->input->post("title"));
		$body = $this->lib_filter->go($this->input->post("body"));

		if(empty($title)) {
			$this->template->error(lang("error_81"));
		}

		$this->jobs_model->update_canned_response($id, array(
			"title" => $title,
			"body" => $body
			)
		);
		$this->session->set_flashdata("globalmsg", lang("success_62"));
		redirect(site_url("jobs/canned_responses"));
	}

	public function delete_canned_response($id, $hash)
	{
		if($hash != $this->security->get_csrf_hash()) {
			$this->template->error(lang("error_6"));
		}
		$id = intval($id);
		$canned = $this->jobs_model->get_canned_response($id);
		if($canned->num_rows() == 0) {
			$this->template->error(lang("error_123"));
		}

		$this->jobs_model->delete_canned_response($id);
		$this->session->set_flashdata("globalmsg", lang("success_63"));
		redirect(site_url("jobs/canned_responses"));
	}

	public function job_history($jobid)
	{
		$jobid = intval($jobid);
		$job = $this->jobs_model->get_job($jobid);
		if($job->num_rows() == 0) {
			$this->template->error(lang("error_84"));
		}
		$job = $job->row();

		$this->template->loadContent("jobs/job_history.php", array(
			"job" => $job
			)
		);
	}

	public function job_history_page($jobid)
	{
		$jobid = intval($jobid);
		$job = $this->jobs_model->get_job($jobid);
		if($job->num_rows() == 0) {
			$this->template->error(lang("error_84"));
		}
		$job = $job->row();

		$this->load->library("datatables");

		$this->datatables->set_default_order("job_history.ID", "desc");

		// Set page ordering options that can be used
		$this->datatables->ordering(
			array(
				 0 => array(
				 	"users.username" => 0
				 ),
				 1 => array(
				 	"job_history.message" => 0
				 ),
				 2 => array(
				 	"job_history.timestamp" => 0
				 ),
			)
		);

		$this->datatables->set_total_rows(
			$this->jobs_model
				->get_job_history_count($jobid)
		);
		$history = $this->jobs_model->get_job_history($jobid, $this->datatables);


		foreach($history->result() as $r) {

			$this->datatables->data[] = array(
				$this->common->get_user_display(array("username" => $r->username, "avatar" => $r->avatar, "online_timestamp" => $r->online_timestamp, "user" => false)),
				$r->message,
				date($this->settings->info->date_format, $r->timestamp)
			);
		}

		echo json_encode($this->datatables->process());
	}

	public function active_view($id, $page)
	{
		$id = intval($id);
		if($id > 0) {
			$view = $this->jobs_model->get_custom_view($id, $this->user->info->ID);
			if($view->num_rows() == 0) {
				$this->template->error(lang("error_124"));
			}
		}

		$this->user_model->update_user($this->user->info->ID, array(
			"custom_view" => $id
			)
		);

		$this->session->set_flashdata("globalmsg", lang("success_65"));
		redirect(site_url("jobs/" . $page));
	}

	public function custom_views()
	{
		$this->template->loadData("activeLink",
			array("job" => array("custom_view" => 1)));
		$categories = $this->jobs_model->get_categories();
		$this->template->loadContent("jobs/custom_views.php", array(
			"categories" => $categories
			)
		);
	}

	public function custom_view_page()
	{
		$this->load->library("datatables");

		$this->datatables->set_default_order("custom_views.ID", "desc");

		// Set page ordering options that can be used
		$this->datatables->ordering(
			array(
				 0 => array(
				 	"custom_views.name" => 0
				 ),
				 1 => array(
				 	"custom_views.status" => 0
				 ),
				 2 => array(
				 	"job_categories.name" => 0
				 )
			)
		);

		$this->datatables->set_total_rows(
			$this->jobs_model->get_custom_views_total($this->user->info->ID)
		);
		$views = $this->jobs_model->get_custom_views_dt($this->user->info->ID, $this->datatables);


		foreach($views->result() as $r) {

			if($r->status == -1) {
				$status = "All";
			} elseif($r->status == 0) {
				$status = lang("ctn_465");
			} elseif($r->status == 1) {
				$status = lang("ctn_466");
			} elseif($r->status == 2) {
				$status = lang("ctn_467");
			} elseif($r->status == 3) {
				$status = 'Removed';
			} elseif($r->status == 4) {
			  $status = "Completed";
			}

			if($r->categoryid == 0) {
				$category = "All";
			} else {
				$category = $r->cat_name;
			}

			$this->datatables->data[] = array(
				$r->name,
				$status,
				$category,
				'<a href="'.site_url("jobs/edit_custom_view/" . $r->ID).'" class="btn btn-warning btn-xs" data-toggle="tooltip" data-placement="bottom" title="'.lang("ctn_55").'"><span class="glyphicon glyphicon-cog"></span></a> <a href="'.site_url("jobs/delete_custom_view/" . $r->ID . "/" . $this->security->get_csrf_hash()).'" class="btn btn-danger btn-xs" onclick="return confirm(\''.lang("ctn_317").'\')" data-toggle="tooltip" data-placement="bottom" title="'.lang("ctn_57").'"><span class="glyphicon glyphicon-trash"></span></a>'
			);
		}

		echo json_encode($this->datatables->process());
	}

	public function edit_custom_view($id)
	{
		$id = intval($id);
		$view = $this->jobs_model->get_custom_view($id, $this->user->info->ID);
		if($view->num_rows() == 0) {
			$this->template->error(lang("error_125"));
		}

		$this->template->loadData("activeLink",
			array("job" => array("custom_view" => 1)));
		$categories = $this->jobs_model->get_categories();
		$this->template->loadContent("jobs/edit_custom_view.php", array(
			"view" => $view->row(),
			"categories" => $categories
			)
		);
	}

	public function edit_custom_view_pro($id)
	{
		$id = intval($id);
		$view = $this->jobs_model->get_custom_view($id, $this->user->info->ID);
		if($view->num_rows() == 0) {
			$this->template->error(lang("error_125"));
		}

		$name = $this->common->nohtml($this->input->post("name"));
		$status = intval($this->input->post("status"));
		$categoryid = intval($this->input->post("categoryid"));
		$order_by = intval($this->input->post("order_by"));
		$order_by_type = $this->common->nohtml($this->input->post("order_by_type"));

		if($order_by_type != "asc" && $order_by_type != "desc") {
			$this->template->error(lang("error_126"));
		}

		$this->jobs_model->update_custom_view($id, array(
			"name" => $name,
			"status" => $status,
			"categoryid" => $categoryid,
			"order_by" => $order_by,
			"order_by_type" => $order_by_type
			)
		);

		$this->session->set_flashdata("globalmsg", lang("success_66"));
		redirect(site_url("jobs/custom_views"));


	}

	public function add_custom_view()
	{
		$name = $this->common->nohtml($this->input->post("name"));
		$status = intval($this->input->post("status"));
		$categoryid = intval($this->input->post("categoryid"));
		$order_by = intval($this->input->post("order_by"));
		$order_by_type = $this->common->nohtml($this->input->post("order_by_type"));

		if($order_by_type != "asc" && $order_by_type != "desc") {
			$this->template->error(lang("error_126"));
		}

		$this->jobs_model->add_custom_view(array(
			"userid" => $this->user->info->ID,
			"name" => $name,
			"status" => $status,
			"categoryid" => $categoryid,
			"order_by" => $order_by,
			"order_by_type" => $order_by_type
			)
		);

		$this->session->set_flashdata("globalmsg", lang("success_67"));
		redirect(site_url("jobs/custom_views"));
	}

	public function delete_custom_view($id, $hash)
	{
		if($hash != $this->security->get_csrf_hash()) {
			$this->template->error("Invalid Hash!");
		}
		$id = intval($id);
		$view = $this->jobs_model->get_custom_view($id, $this->user->info->ID);
		if($view->num_rows() == 0) {
			$this->template->error(lang("error_125"));
		}

		$this->jobs_model->delete_custom_view($id);
		$this->session->set_flashdata("globalmsg", lang("success_68"));
		redirect(site_url("jobs/custom_views"));
	}

	public function get_usernames()
	{
		$query = $this->common->nohtml($this->input->get("query"));

		if(!empty($query)) {
			$usernames = $this->user_model->get_usernames_user_role($query);
			if($usernames->num_rows() == 0) {
				echo json_encode(array());
			} else {
				$array = array();
				foreach($usernames->result() as $r) {
					$array[] = $r->username;
				}
				echo json_encode($array);
				exit();
			}
		} else {
			echo json_encode(array());
			exit();
		}
	}

	public function get_jobs_id()
	{
		$query = intval($this->input->get("query"));

		if(!empty($query)) {
			$jobs = $this->jobs_model->get_jobs_id($query);
			if($jobs->num_rows() == 0) {
				echo json_encode(array());
			} else {
				$array = array();
				foreach($jobs->result() as $r) {
					$item = new STDclass;
					$item->value = $r->ID;
					$item->label = "#" . $r->ID . " - " . $r->title;
					$array[] = $item;;
				}
				echo json_encode($array);
				exit();
			}
		} else {
			echo json_encode(array());
			exit();
		}
	}

	public function edit_job_note_pro($jobid)
	{
		$jobid = intval($jobid);
		$job = $this->jobs_model->get_job($jobid);
		if($job->num_rows() == 0) {
			$this->template->error(lang("error_84"));
		}
		$job = $job->row();
		$note = $this->lib_filter->go($this->input->post("note"));

		$this->jobs_model->update_job($jobid, array(
			"notes" => $note
			)
		);

		$this->session->set_flashdata("globalmsg", "The job notes were updated!");
		redirect(site_url("jobs/view/" . $jobid));
	}

}

?>