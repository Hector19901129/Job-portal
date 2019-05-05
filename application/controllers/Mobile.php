<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Mobile extends CI_Controller 
{

	public function __construct() 
	{
		parent::__construct();
		$this->load->model("user_model");
		$this->load->model("jobs_model");
		$this->load->model("home_model");
	}

	public function index()
	{
		$content = $this->load->view('mobile/index');
		$this->load->view('layout/mobile_layout', array("content" => $content));
	}

	public function search()
	{
		$job_id = $this->input->post("job_id");
		$job = $this->jobs_model->get_job($job_id);
		if($job->num_rows() == 0) {
			$this->index();
		}else{
			$job = $job->row();
			$content = $this->load->view('mobile/detail', array("job" => $job));
			$this->load->view('layout/mobile_layout', array("content" => $content));
		}
		
	}

	//newly added 
	public function confirm_artwork(){
		$title = $this->input->get('title',true);
		$email = $this->input->get('email',true);
		$sign_type = $this->input->get('sign_type',true);
		$client_name = $this->input->get('client_name',true);
		$jobid = $this->input->get('jobid',true);
		$files = $this->jobs_model->get_job_files($jobid);
		$data = array('title' => $title, 'email' => $email, 'sign_type' => $sign_type, 'client_name' => $client_name, 'jobid' => $jobid, 'files' => $files);
		$this->load->view('jobs/confirm_artwork', $data);
	}
	public function confirm()
	{
		$jobid = intval($this->input->post("job_id"));
		$status = intval($this->input->post("job_status"));
		$job = $this->jobs_model->get_job($jobid);
		if($job->num_rows() == 0) {
			$this->template->jsonError(lang("error_84"));
		}
		$job = $job->row();

		// Check user has access
		//$this->check_job_access($job);

		// if($status < 0 || $status > 4) {
		// 	$this->template->jsonError(lang("error_113"));
		// }

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
			"userid" => 1,
			"message" => lang("ctn_664") . " " . $statuses[$status],
			"timestamp" => time(),
			"jobid" => $jobid
			)
		);

		$this->job_reply($jobid);

		redirect('/mobile', 'refresh');
	}
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
		//$this->check_job_access($job);

		//$body = $this->lib_filter->go($this->input->post("body"));
		// if(empty($body)) {
		// 	$this->template->error(lang("error_100"));
		// }
		// $assign = intval($this->input->post("assign"));

		$this->load->library("upload");

		//$file_count = intval($this->input->post("file_count"));
		$file_data = array();
		$files_flag = 0;
		/*echo '<pre>';
		print_r($this->settings);
		die;*/
		//Load email library 
		$this->load->library('email'); 
		
		if($this->settings->info->enable_job_uploads) {
			//for($i=1;$i<=$file_count;$i++) {
				if (isset($_FILES['file']) && $_FILES['file']['size'] > 0) {
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
					if ( ! $this->upload->do_upload('file'))
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
			//}
		}

		$new_message_id_hash = md5(rand(1,100000000)."fhhfh".time());

		// Add
		$replyid = $this->jobs_model->add_job_reply(array(
			"jobid" => $id,
			"userid" => 1,
			"body" => "",
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
				"userid" => 1
				)
			);
		}

		// $assignedid = $job->assignedid;
		// if($assign) {
		// 	$assignedid = 1;
		// }


		// Update last reply
		$this->jobs_model->update_job($job->ID, array(
			"last_reply_userid" => 1,
			"last_reply_timestamp" => time(),
			"last_reply_string" => date($this->settings->info->date_format, time()),
			)
		);

		// Notification
		if($job->userid == 1) {
			// Alert assigned user of new reply
			if($job->assignedid > 0) {
				$this->user_model->increment_field($job->assignedid, "noti_count", 1);
				$this->user_model->add_notification(array(
					"userid" => $job->assignedid,
					"url" => "jobs/view/" . $job->ID,
					"timestamp" => time(),
					"message" => lang("ctn_609"),
					"status" => 0,
					"fromid" => 1,
					"username" => $job->username,
					"email" => $job->email,
					"email_notification" => $job->email_notification
					)
				);
			}
		} elseif(1 == $job->assignedid) {
			// Alert user of new reply
			if($job->userid > 0) {
				$this->user_model->increment_field($job->userid, "noti_count", 1);
				$this->user_model->add_notification(array(
					"userid" => $job->userid,
					"url" => "client/view_job/" . $job->ID,
					"timestamp" => time(),
					"message" => lang("ctn_609"),
					"status" => 0,
					"fromid" => 1,
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
					"fromid" => 1,
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
					"fromid" => 1,
					"username" => $job->username,
					"email" => $job->email,
					"email_notification" => $job->email_notification
					)
				);
			}
		}

		$this->jobs_model->add_history(array(
			"userid" => 1,
			"message" => lang("ctn_665"),
			"timestamp" => time(),
			"jobid" => $job->ID
			)
		);

		//if($job->userid != 1) {
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
				"[TICKET_BODY]" => "",
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
		
		//$this->session->set_flashdata("globalmsg", lang("success_45"));
	}
}