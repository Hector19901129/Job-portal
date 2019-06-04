<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Client extends CI_Controller
{

	public function __construct()
	{
		parent::__construct();
		$this->load->model("user_model");
		$this->load->model("jobs_model");
		$this->load->model("knowledge_model");
		$this->load->model("funds_model");
		$this->load->model("home_model");
		$this->template->set_error_view("error/client_error.php");
		$this->template->set_layout("layout/client_layout.php");

		if($this->settings->info->require_login) {
			if(!$this->user->loggedin) {
				redirect(site_url("login"));
			}
			if($this->settings->info->global_premium &&
			($this->user->info->premium_time != -1 &&
					$this->user->info->premium_time < time()) ) {
				$this->session->set_flashdata("globalmsg", lang("success_29"));
				redirect(site_url("funds/plans"));
			}
		}
	}

	public function index()
	{
        $fields = $this->jobs_model->get_custom_fields_all_cats();

		$categories = $this->jobs_model->get_category_no_parent();

		$articles = $this->knowledge_model->get_recent_articles(4);

		$this->template->loadExternal(
			'<script src="https://www.google.com/recaptcha/api.js"></script>'
		);

		$cap = null;
		if($this->settings->info->captcha_job && !$this->settings->info->google_recaptcha) {
			$this->load->helper("captcha");
			$rand = rand(4000,100000);
			$_SESSION['sc'] = $rand;
			$vals = array(
			    'word' => $rand,
			    'img_path' => './images/captcha/',
	    		'img_url' => base_url() . 'images/captcha/',
			    'img_width' => 150,
			    'img_height' => 30,
			    'expiration' => 7200
			    );

			$cap = create_captcha($vals);
		}

		$this->template->loadContent("client/index.php", array(
			"cap" => $cap,
			"articles" => $articles,
			"fields" => $fields,
			"categories" => $categories
			)
		);
	}

	public function funds()
	{
		$this->template->loadData("activeLink",
			array("funds" => array("general" => 1)));
		if(!$this->settings->info->payment_enabled) {
			$this->template->error(lang("error_60"));
		}

		if(!empty($this->settings->info->stripe_secret_key) && !empty($this->settings->info->stripe_publish_key)) {
			// Stripe
			require_once(APPPATH . 'third_party/stripe/init.php');

			$stripe = array(
			  "secret_key"      => $this->settings->info->stripe_secret_key,
			  "publishable_key" => $this->settings->info->stripe_publish_key
			);

			\Stripe\Stripe::setApiKey($stripe['secret_key']);
		} else {
			$stripe = null;
		}

		$this->template->loadContent("client/funds.php", array(
			"stripe" => $stripe
			)
		);
	}

	public function plans()
	{
		if(!$this->user->loggedin) {
			redirect(site_url("login"));
		}
		$this->template->loadData("activeLink",
			array("funds" => array("plans" => 1)));
		if(!$this->settings->info->payment_enabled) {
			$this->template->error(lang("error_60"));
		}

		$plans = $this->funds_model->get_plans();
		$this->template->loadContent("client/plans.php", array(
			"plans" => $plans
			)
		);
	}

	public function buy_plan($id, $hash)
	{
		if(!$this->user->loggedin) {
			redirect(site_url("login"));
		}
		if($hash != $this->security->get_csrf_hash()) {
			$this->template->error(lang("error_6"));
		}
		$id = intval($id);
		$plan = $this->funds_model->get_plan($id);
		if($plan->num_rows() == 0) $this->template->error(lang("error_61"));
		$plan = $plan->row();

		// Check user has dolla
		if($this->user->info->points < $plan->cost) {
			$this->template->error(lang("error_62"));
		}

		if($this->user->info->premium_time == -1) {
			$this->template->error(lang("error_63"));
		}

		if($plan->days > 0) {
			$premium_time = $this->user->info->premium_time;
			$time_added = (24*3600) * $plan->days;

			// Check to see if user currently has time.
			if($premium_time > time()) {
				// If plan does not equal current one, then we reset
				// the timer
				if($this->user->info->premium_planid != $plan->ID) {
					$premium_time = time() + $time_added;
				} else {
					$premium_time = $premium_time + $time_added;
				}
			} else {
				$premium_time = time() + $time_added;
			}
		} else {
			// Unlimited Time modifier
			$premium_time = -1;
		}

		$this->user->info->points = $this->user->info->points - $plan->cost;

		$this->user_model->update_user($this->user->info->ID, array(
			"premium_time" => $premium_time,
			"points" => $this->user->info->points,
			"premium_planid" => $plan->ID
			)
		);

		$this->funds_model->update_plan($id, array(
			"sales" => $plan->sales + 1
			)
		);

		$this->session->set_flashdata("globalmsg", lang("success_28"));
		redirect(site_url("client/plans"));
	}

	public function get_articles()
	{
		$query = $this->common->nohtml($this->input->get("query"));

		if(!empty($query)) {
			$articles = $this->knowledge_model->get_articles_title($query);
			if($articles->num_rows() == 0) {
				return 0;
			} else {
				$this->template->loadAjax("client/get_articles.php", array(
					"articles" => $articles,
					), 1
				);
			}
		} else {
			return 0;
		}
	}

	public function rate_job($jobid, $hash)
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

		$userid = 0;

		// Check user logged in
		if($this->user->loggedin) {
			$userid = $this->user->info->ID;
			if($job->userid != $this->user->info->ID) {
				// Check admin permission
				if(!$this->common->has_permissions(array(
					"admin", "job_manager"), $this->user)) {
					$this->template->error(lang("error_85"));
				}
			}
		} else {
			if(isset($_SESSION['jobid']) && isset($_SESSION['jobpass'])) {
				// Check valid
				if($job->ID != $_SESSION['jobid']) {
					$this->template->error(lang("error_84"));
				}
				if($job->message_id_hash != $_SESSION['jobpass']) {
					$this->template->error(lang("error_84"));
				}
			} else {
				$this->template->error(lang("error_84"));
			}
		}

		$rating = intval($this->input->get("rating"));
		if($rating > 5) $rating =5;
		if($rating < 1) $rating =1;

		$this->jobs_model->update_job($jobid, array(
			"rating" => $rating
			)
		);

		$this->jobs_model->add_history(array(
			"userid" => $userid,
			"message" => lang("ctn_655") . ": " . $rating . " " . lang("ctn_656"),
			"timestamp" => time(),
			"jobid" => $jobid
			)
		);

		echo 1;
		exit();
	}

	public function knowledge()
	{
		$categories = $this->knowledge_model->get_categories_no_parents();
		$articles = $this->knowledge_model->get_recent_articles(4);
		$this->template->loadContent("client/knowledge.php", array(
			"categories" => $categories,
			"articles" => $articles
			)
		);
	}

	public function view_knowledge($id)
	{
		$id = intval($id);
		$article = $this->knowledge_model->get_article($id);
		if($article->num_rows() == 0) {
			$this->template->error(lang("error_86"));
		}
		$article = $article->row();
		$this->template->loadContent("client/view_knowledge.php", array(
			"article" => $article
			)
		);
	}

	public function view_knowledge_cat($catid)
	{
		$catid = intval($catid);
		$category = $this->knowledge_model->get_category($catid);
		if($category->num_rows() == 0) {
			$this->template->error(lang("error_87"));
		}
		$category = $category->row();

		// Get sub cats
		$subcats = $this->knowledge_model->get_subcats($catid);

		$this->template->loadContent("client/view_knowledge_cat.php", array(
			"category" => $category,
			"subcats" => $subcats
			)
		);
	}

	public function knowledge_search()
	{
		$search = $this->common->nohtml($this->input->post("search"));

		if(empty($search)) {
			$this->template->error(lang("error_88"));
		}

		$articles = $this->knowledge_model->get_articles_search($search);
		$this->template->loadContent("client/knowledge_search.php", array(
			"articles" => $articles
			)
		);
	}

	public function knowledge_cat_page($catid)
	{
		$catid = intval($catid);
		$category = $this->knowledge_model->get_category($catid);
		if($category->num_rows() == 0) {
			$this->template->error(lang("error_87"));
		}
		$category = $category->row();

		$this->load->library("datatables");

		$this->datatables->set_default_order("knowledge_articles.title", "desc");

		// Set page ordering options that can be used
		$this->datatables->ordering(
			array(
				 0 => array(
				 	"knowledge_articles.title" => 0
				 )
			)
		);

		$this->datatables->set_total_rows(
			$this->knowledge_model
				->get_articles_cat_total($catid)
		);
		$articles = $this->knowledge_model->get_articles_cat($catid, $this->datatables);

		foreach($articles->result() as $r) {

			$summary = explode("***", wordwrap(strip_tags($r->body), 100, "***"));
			$this->datatables->data[] = array(
				$r->title,
				$summary[0],
				'<a href="'.site_url('client/view_knowledge/' . $r->ID).'" class="btn btn-info btn-xs" data-toggle="tooltip" data-placement="bottom" title="'.lang("ctn_459").'">'.lang("ctn_459").'</a>'
			);
		}

		echo json_encode($this->datatables->process());
	}
	//newly inserted
	public function jobs()
	{
		
		if($this->user->loggedin) {
			
			$userid = $this->user->info->ID;
			$fields = $this->user_model->get_member_by_id($userid);
			$field = $fields->row()->custom_fields;
			// Get user jobs
			$this->template->loadContent("client/jobs.php", array("user_field" => $field
				)
			);
		} else {
			if(!$this->settings->info->enable_job_guests) {
				$this->template->error(lang("error_89"));
			}
			// Guest login
			// Get user jobs
			$this->template->loadContent("client/guest_job.php", array(
				)
			);
		}
	}
	//newly inserted
	public function job_page()
	{
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
				 	"j1.value" => 0
				 ),
				 3 => array(
				 	"j2.value" => 0
				 ),
				 4 => array(
				 	"jobs.priority" => 0
				 ),
				 5 => array(
				 	"jobs.status" => 0
				 ),
				 6 => array(
				 	"jobs.categoryid" => 0
				 ),
				 7 => array(
				 	"jobs.last_reply_timestamp" => 0
				 ),
			)
		);

		$userid = $this->user->info->ID;

		$this->datatables->set_total_rows(
			$this->jobs_model
				->get_client_jobs_total($userid)
		);
		$jobs = $this->jobs_model->get_client_jobs($userid, $this->datatables);


		$prioritys = array(0 => "<span class='label label-info'>".lang("ctn_429")."</span>", 1 => "<span class='label label-primary'>".lang("ctn_430")."</span>", 2=> "<span class='label label-warning'>".lang("ctn_431")."</span>", 3 => "<span class='label label-danger'>".lang("ctn_432")."</span>");
		$fields = $this->user_model->get_member_by_id($userid);
		$field = $fields->row()->custom_fields;
		$user_field = explode(",", $field);
		foreach($jobs->result() as $r) {
			/*echo '<pre>';
			print_r($r);
			echo '</pre>';*/

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

			$options = '<a href="'.site_url('client/view_job/' . $r->ID).'" class="btn btn-info btn-xs" data-toggle="tooltip" data-placement="bottom" title="'.lang("ctn_459").'">'.lang("ctn_459").'</a>';
			if($this->settings->info->enable_job_edit) {
				$options .= ' <a href="'.site_url("client/edit_job/" . $r->ID).'" class="btn btn-warning btn-xs" data-toggle="tooltip" data-placement="bottom" title="'.lang("ctn_55").'"><span class="glyphicon glyphicon-cog"></span></a>';
			}


			$this->datatables->data[] = array(
				$r->ID,
				$r->title,
				in_array('10', $user_field) ? $r->nm : 'NA',
				in_array('9', $user_field) ? $r->nm2 : 'NA',
				//$r->title,
				//$prioritys[$r->priority],
				$status,
				//$r->cat_name,
				date($this->settings->info->date_format,$r->timestamp),
				$options
			);
		}

		echo json_encode($this->datatables->process());
	}

	public function guest_login_pro()
	{
		if(!$this->settings->info->enable_job_guests) {
			$this->template->error(lang("error_89"));
		}

		$email = $this->common->nohtml($this->input->post("email"));
		$pass = $this->common->nohtml($this->input->post("pass"));

		if(empty($email) || empty($pass)) {
			$this->template->error(lang("error_90"));
		}

		// Get job
		$job = $this->jobs_model->get_guest_job($email, $pass);
		if($job->num_rows() == 0) {
			$this->template->error(lang("error_91"));
		}

		$job = $job->row();

		$_SESSION['jobid'] = $job->ID;
		$_SESSION['jobpass'] = $job->message_id_hash;

		$this->jobs_model->add_history(array(
			"userid" => 0,
			"message" => lang("ctn_657"),
			"timestamp" => time(),
			"jobid" => $job->ID
			)
		);

		redirect(site_url("client/view_job/" . $job->ID));
	}

	public function add_pro()
	{
		$title = $this->common->nohtml($this->input->post("title"));
		$guest_email = $this->common->nohtml($this->input->post("guest_email"));
		$priority = intval($this->input->post("priority"));
		$catid = intval($this->input->post("catid"));
		$sub_catid = intval($this->input->post("sub_catid"));

		$file_count = intval($this->input->post("file_count"));

		$body = $this->lib_filter->go($this->input->post("body"));


		if($this->settings->info->captcha_job) {
			if (!$this->settings->info->google_recaptcha) {
				$captcha = $this->common->nohtml($this->input->post("captcha"));
				if ($captcha != $_SESSION['sc']) {
					$this->template->error(lang("error_55"));
				}
			} else {
				require(APPPATH . 'third_party/autoload.php');
				$recaptcha = new \ReCaptcha\ReCaptcha(
					$this->settings->info->google_recaptcha_secret);
				$resp = $recaptcha->verify($_POST['g-recaptcha-response'], $_SERVER['REMOTE_ADDR']);
				if ($resp->isSuccess()) {
				    // verified!
				} else {
				    $errors = $resp->getErrorCodes();
				    $this->template->error(lang("error_55"));
				}
			}
		}

		if(empty($title)) {
			$this->template->error(lang("error_81"));
		}

		if(empty($body)) {
			$this->template->error(lang("error_92"));
		}

		if($priority < 0 || $priority > 3) {
			$this->template->error(lang("error_93"));
		}

		// Get client
		$clientid = 0;
		if($this->user->loggedin) {
			$clientid = $this->user->info->ID;
			$client_username = $this->user->info->username;
			$client_email = $this->user->info->email;
		}

		if($clientid == 0) {
			if($this->settings->info->enable_job_guests) {
				if(empty($guest_email)) {
					$this->template->error(lang("error_94"));
				}
			} else {
				$this->template->error(lang("error_95"));
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
			"timestamp" => time(),
			"categoryid" => $categoryid,
			"status" => 0,
			"priority" => $priority,
			"last_reply_timestamp" => time(),
			"last_reply_string" => date($this->settings->info->date_format, time()),
			"message_id_hash" => $message_id_hash,
			"guest_email" => $guest_email,
			"guest_password" => $guest_password,
			"job_date" => date("d-n-Y")
			)
		);

		$extra = "";
		if($clientid == 0) {
			// Send email with guest details

			// Attach guest details to alert
			$extra = lang("ctn_606") . "<br />
			" . lang("ctn_24") . ": <b>$guest_email</b><br />
			".lang("ctn_450").": <b>$guest_password</b>.";
			// Verify guest automagically
			$_SESSION['jobid'] = $jobid;
			$_SESSION['jobpass'] = $message_id_hash;
		}

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
				"userid" => $clientid
				)
			);
		}

		// Alert users of new job for this category
		if($clientid == 0) {
			$msg = lang("ctn_607");
		} else {
			$msg = lang("ctn_608");
		}
		$users = $this->jobs_model->get_users_from_groups($categoryid);
		foreach($users->result() as $r) {
			$this->user_model->increment_field($r->ID, "noti_count", 1);
				$this->user_model->add_notification(array(
					"userid" => $r->ID,
					"url" => "jobs/view/" . $jobid,
					"timestamp" => time(),
					"message" => $msg,
					"status" => 0,
					"fromid" => $clientid,
					"username" => $r->username,
					"email" => $r->email,
					"email_notification" => $r->email_notification
					)
				);
		}

		$this->jobs_model->add_history(array(
			"userid" => $clientid,
			"message" => lang("ctn_649"),
			"timestamp" => time(),
			"jobid" => $jobid
			)
		);

		if($clientid > 0) {
			// Send email
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



		$this->session->set_flashdata("globalmsg", lang("success_44") . $extra);
		redirect(site_url("client/view_job/" . $jobid));
	}

	private function custom_field_check($fields, $answers)
	{
		foreach($fields->result() as $r) {
			if($r->hide_clientside) continue;
			$answer = "";
			if($r->type == 0) {
				// Look for simple text entry
				$answer = $this->common->nohtml($this->input->post("cf_" . $r->ID));

				if($r->required && (empty($answer) && $answer !== '0')) {
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
	//newly inserted for user_field
	public function view_job($jobid)
	{
		$jobid = intval($jobid);
		$job = $this->jobs_model->get_job($jobid);
		if($job->num_rows() == 0) {
			$this->template->error(lang("error_84"));
		}
		$job = $job->row();

		// Check user logged in
		if($this->user->loggedin) {
			if($job->userid != $this->user->info->ID) {
				// Check admin permission
				if(!$this->common->has_permissions(array(
					"admin", "job_manager"), $this->user)) {
					$this->template->error(lang("error_85"));
				}
			}
		} else {
			if(isset($_SESSION['jobid']) && isset($_SESSION['jobpass'])) {
				// Check valid
				if($job->ID != $_SESSION['jobid']) {
					$this->template->error(lang("error_84"));
				}
				if($job->message_id_hash != $_SESSION['jobpass']) {
					$this->template->error(lang("error_84"));
				}
			} else {
				$this->template->error(lang("error_84"));
			}
		}

		$this->template->loadData("activeLink",
			array("job" => array("general" => 1)));

		$files = $this->jobs_model->get_job_files($jobid);

		$replies = $this->jobs_model->get_job_replies($jobid);


		$user_fields = null;
		if($job->userid > 0) {
			$user_fields = $this->user_model->get_custom_fields_answers(array(
				), $job->userid);
		}

		$job_fields = $this->jobs_model->get_custom_fields_for_job($jobid);
		$fields = $this->user_model->get_member_by_id($job->userid);
		$field = $fields->row()->custom_fields;
		$this->template->loadContent("client/view_job.php", array(
			"job" => $job,
			"files" => $files,
			"replies" => $replies,
			"user_fields" => $user_fields,
			"job_fields" => $job_fields,
			"user_field" => $field
			)
		);
	}

	public function job_reply($id)
	{
		$id = intval($id);
		$job = $this->jobs_model->get_job($id);
		if($job->num_rows() == 0) {
			$this->template->error(lang("error_84"));
		}
		$job = $job->row();

		// Check user logged in
		if($this->user->loggedin) {
			if($job->userid != $this->user->info->ID) {
				// Check admin permission
				if(!$this->common->has_permissions(array(
					"admin", "job_manager"), $this->user)) {
					$this->template->error(lang("error_85"));
				}
			}
		} else {
			if(isset($_SESSION['jobid']) && isset($_SESSION['jobpass'])) {
				// Check valid
				if($job->ID != $_SESSION['jobid']) {
					$this->template->error(lang("error_84"));
				}
				if($job->message_id_hash != $_SESSION['jobpass']) {
					$this->template->error(lang("error_84"));
				}
			} else {
				$this->template->error(lang("error_84"));
			}
		}

		$body = $this->lib_filter->go($this->input->post("body"));
		if(empty($body)) {
			$this->template->error(lang("error_100"));
		}
		$this->load->library("upload");

		$file_count = intval($this->input->post("file_count"));
		$file_data = array();
		$files_flag = 0;
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

		$new_message_id_hash = md5(rand(1,100000000)."fhhfh".time());

		$userid = 0;
		if($this->user->loggedin) {
			$userid = $this->user->info->ID;
		}

		// Add
		$replyid = $this->jobs_model->add_job_reply(array(
			"jobid" => $id,
			"userid" => $userid,
			"body" => $body,
			"timestamp" => time(),
			"files" => $files_flag,
			"hash" => $new_message_id_hash
			)
		);

		$this->jobs_model->add_history(array(
			"userid" => $userid,
			"message" => lang("ctn_650"),
			"timestamp" => time(),
			"jobid" => $id
			)
		);

		// Add Attached files
		foreach($file_data as $file) {
			$this->jobs_model->add_attached_files(array(
				"replyid" => $replyid,
				"jobid" => $job->ID,
				"upload_file_name" => $file['upload_file_name'],
				"file_type" => $file['file_type'],
				"extension" => $file['extension'],
				"file_size" => $file['file_size'],
				"timestamp" => $file['timestamp'],
				"userid" => $userid
				)
			);
		}


		// Update last reply
		$this->jobs_model->update_job($job->ID, array(
			"last_reply_userid" => $userid,
			"last_reply_timestamp" => time(),
			"last_reply_string" => date($this->settings->info->date_format, time()),
			)
		);

		// Notification
		if($job->userid == $userid) {
			// Alert assigned user of new reply
			if($job->assignedid > 0) {
				$this->user_model->increment_field($job->assignedid, "noti_count", 1);
				$this->user_model->add_notification(array(
					"userid" => $job->assignedid,
					"url" => "jobs/view/" . $job->ID,
					"timestamp" => time(),
					"message" => lang("ctn_609"),
					"status" => 0,
					"fromid" => $userid,
					"username" => $job->username,
					"email" => $job->email,
					"email_notification" => $job->email_notification
					)
				);
			}
		} elseif($userid == $job->assignedid) {
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
					"fromid" => $userid,
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
					"fromid" => $userid,
					"username" => $job->username,
					"email" => $job->email,
					"email_notification" => $job->email_notification
					)
				);
			}
		}

		if($job->userid != $userid) {
			// Send email
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
			$this->common->send_email($this->settings->info->job_title . " [ID: " . $id . "]: " . $job->title,
				 $email_template->message, $email, $headers);
		}

		$this->session->set_flashdata("globalmsg", lang("success_45"));
		redirect(site_url("client/view_job/" . $id));
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

		$job = $this->jobs_model->get_job($reply->jobid);
		if($job->num_rows() == 0) {
			$this->template->error(lang("error_84"));
		}
		$job = $job->row();

		// Check user logged in
		if($this->user->loggedin) {
			if($job->userid != $this->user->info->ID) {
				// Check admin permission
				if(!$this->common->has_permissions(array(
					"admin", "job_manager"), $this->user)) {
					$this->template->error(lang("error_85"));
				}
			}
		} else {
			if($reply->userid != 0) $this->template->error(lang("error_102"));
			if(isset($_SESSION['jobid']) && isset($_SESSION['jobpass'])) {
				// Check valid
				if($job->ID != $_SESSION['jobid']) {
					$this->template->error(lang("error_84"));
				}
				if($job->message_id_hash != $_SESSION['jobpass']) {
					$this->template->error(lang("error_84"));
				}
			} else {
				$this->template->error(lang("error_84"));
			}
		}

		$userid = 0;
		if($this->user->loggedin) {
			$userid = $this->user->info->ID;
		}

		if($userid > 0) {
			if($reply->userid != $userid) {
				// Check user has admin rights
				// Check
				if(!$this->common->has_permissions(array(
					"admin", "job_manager"), $this->user)) {
					$this->template->error(lang("error_85"));
				}
			}
		}
		$this->template->loadContent("client/edit_job_reply.php", array(
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

		$job = $this->jobs_model->get_job($reply->jobid);
		if($job->num_rows() == 0) {
			$this->template->error(lang("error_84"));
		}
		$job = $job->row();

		// Check user logged in
		if($this->user->loggedin) {
			if($job->userid != $this->user->info->ID) {
				// Check admin permission
				if(!$this->common->has_permissions(array(
					"admin", "job_manager"), $this->user)) {
					$this->template->error(lang("error_85"));
				}
			}
		} else {
			if(isset($_SESSION['jobid']) && isset($_SESSION['jobpass'])) {
				// Check valid
				if($job->ID != $_SESSION['jobid']) {
					$this->template->error(lang("error_84"));
				}
				if($job->message_id_hash != $_SESSION['jobpass']) {
					$this->template->error(lang("error_84"));
				}
			} else {
				$this->template->error(lang("error_84"));
			}
		}

		$userid = 0;
		if($this->user->loggedin) {
			$userid = $this->user->info->ID;
		}

		$body = $this->lib_filter->go($this->input->post("body"));
		if(empty($body)) {
			$this->template->error(lang("error_103"));
		}

		$this->load->library("upload");

		$file_count = intval($this->input->post("file_count"));
		$file_data = array();
		$files_flag = $reply->files;
		if(!$this->settings->info->disable_job_upload) {
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

		$this->jobs_model->add_history(array(
			"userid" => $userid,
			"message" => lang("ctn_651") ."<br />" .
			$reply->body . "<br />".lang("ctn_652").":<br />" . $body,
			"timestamp" => time(),
			"jobid" => $reply->jobid
			)
		);

		// Add Attached files
		foreach($file_data as $file) {
			$this->jobs_model->add_attached_files(array(
				"replyid" => $id,
				"upload_file_name" => $file['upload_file_name'],
				"file_type" => $file['file_type'],
				"extension" => $file['extension'],
				"file_size" => $file['file_size'],
				"timestamp" => $file['timestamp'],
				"userid" => $userid
				)
			);
		}

		$this->session->set_flashdata("globalmsg", lang("success_46"));
		redirect(site_url("client/view_job/" . $reply->jobid));
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

		$job = $this->jobs_model->get_job($reply->jobid);
		if($job->num_rows() == 0) {
			$this->template->error(lang("error_84"));
		}
		$job = $job->row();

		// Check user logged in
		if($this->user->loggedin) {
			if($job->userid != $this->user->info->ID) {
				// Check admin permission
				if(!$this->common->has_permissions(array(
					"admin", "job_manager"), $this->user)) {
					$this->template->error(lang("error_85"));
				}
			}
		} else {
			if(isset($_SESSION['jobid']) && isset($_SESSION['jobpass'])) {
				// Check valid
				if($job->ID != $_SESSION['jobid']) {
					$this->template->error(lang("error_84"));
				}
				if($job->message_id_hash != $_SESSION['jobpass']) {
					$this->template->error(lang("error_84"));
				}
			} else {
				$this->template->error(lang("error_84"));
			}
		}

		$userid = 0;
		if($this->user->loggedin) {
			$userid = $this->user->info->ID;
		}

		$this->jobs_model->add_history(array(
			"userid" => $userid,
			"message" => lang("ctn_653") .":<br />" .
			$reply->body,
			"timestamp" => time(),
			"jobid" => $job->ID
			)
		);

		$this->jobs_model->delete_job_reply($id);
		$this->session->set_flashdata("globalmsg", lang("success_47"));
		redirect(site_url("client/view_job/" . $job->ID));
	}

	//newly inserted
	public function get_custom_fields($catid)
	{
		$catid = intval($catid);
		$category = $this->jobs_model->get_category($catid);
		if($category->num_rows() == 0) {
			$this->template->errori(lang("error_104"));
		}
		$user_id = $this->user->info->ID;
		$fields = $this->user_model->get_member_by_id($user_id);
		$field = $fields->row()->custom_fields;
		$fields = $this->jobs_model->get_custom_fields_for_cat($catid);
		$order_array = explode(",", $this->settings->info->field_order);
		
		$data = array();
		foreach($order_array as $order){
			$id = intval($order);
			foreach($fields->result() as $r){
				if($id == $r->ID){
					array_push($data, $r);
					break;
				}
			}
		}
		$this->template->loadAjax("jobs/ajax_custom_fields.php", array(
				"fields" => $data, "user_field" => $field
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

	public function get_category_description($catid)
	{
		$category = $this->jobs_model->get_category($catid);
		if($category->num_rows() == 0) {
			return 0;
		}
		$category = $category->row();

		echo $category->description;
		exit();
	}

	public function edit_job($id)
	{
		$id = intval($id);
		$job = $this->jobs_model->get_job($id);
		if($job->num_rows() == 0) {
			$this->template->error(lang("error_84"));
		}
		$job = $job->row();

		if(!$this->settings->info->enable_job_edit) {
			$this->template->error(lang("error_106"));
		}

		// Check user logged in
		if($this->user->loggedin) {
			if($job->userid != $this->user->info->ID) {
				// Check admin permission
				if(!$this->common->has_permissions(array(
					"admin", "job_manager"), $this->user)) {
					$this->template->error(lang("error_85"));
				}
			}
		} else {
			if(isset($_SESSION['jobid']) && isset($_SESSION['jobpass'])) {
				// Check valid
				if($job->ID != $_SESSION['jobid']) {
					$this->template->error(lang("error_84"));
				}
				if($job->message_id_hash != $_SESSION['jobpass']) {
					$this->template->error(lang("error_84"));
				}
			} else {
				$this->template->error(lang("error_84"));
			}
		}

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

		$this->template->loadContent("client/edit_job.php", array(
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
		if(!$this->settings->info->enable_job_edit) {
			$this->template->error(lang("error_106"));
		}
		$id = intval($id);
		$job = $this->jobs_model->get_job($id);
		if($job->num_rows() == 0) {
			$this->template->error(lang("error_84"));
		}
		$job = $job->row();

		// Check user logged in
		if($this->user->loggedin) {
			if($job->userid != $this->user->info->ID) {
				// Check admin permission
				if(!$this->common->has_permissions(array(
					"admin", "job_manager"), $this->user)) {
					$this->template->error(lang("error_85"));
				}
			}
		} else {
			if(isset($_SESSION['jobid']) && isset($_SESSION['jobpass'])) {
				// Check valid
				if($job->ID != $_SESSION['jobid']) {
					$this->template->error(lang("error_84"));
				}
				if($job->message_id_hash != $_SESSION['jobpass']) {
					$this->template->error(lang("error_84"));
				}
			} else {
				$this->template->error(lang("error_84"));
			}
		}

		$title = $this->common->nohtml($this->input->post("title"));
		$priority = intval($this->input->post("priority"));
		$catid = intval($this->input->post("catid"));
		$sub_catid = intval($this->input->post("sub_catid"));

		$file_count = intval($this->input->post("file_count"));

		$body = $this->lib_filter->go($this->input->post("body"));

		if(empty($title)) {
			$this->template->error(lang("error_81"));
		}

		if(empty($body)) {
			$this->template->error(lang("error_92"));
		}

		if($priority < 0 || $priority > 3) {
			$this->template->error(lang("error_93"));
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

		$userid = 0;
		if($this->user->loggedin) {
			$userid = $this->user->info->ID;
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
			"categoryid" => $categoryid,
			"priority" => $priority,
			)
		);

		$this->jobs_model->add_history(array(
			"userid" => $userid,
			"message" => lang("ctn_654"),
			"timestamp" => time(),
			"jobid" => $id
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
				"userid" => $userid
				)
			);
		}

		$this->session->set_flashdata("globalmsg", lang("success_48"));
		redirect(site_url("client/view_job/" . $id));
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

		$userid = 0;
		if($this->user->loggedin) {
			$userid = $this->user->info->ID;
		}

		if($userid > 0) {
			if($file->userid != $userid) {
				// Check user has admin rights
				// Check
				if(!$this->common->has_permissions(array(
					"admin", "job_manager"), $this->user)) {
					$this->template->error(lang("error_85"));
				}
			}
		}

		$this->jobs_model->delete_job_file($id);
		$this->session->set_flashdata("globalmsg", lang("success_49"));
		redirect(site_url("client/view_job/" . $file->jobid));
	}

	public function view_announcement($id)
	{
		$id = intval($id);
		$announcement = $this->user_model->get_announcement($id);
		if($announcement->num_rows() == 0) {
			$this->template->error(lang("error_82"));
		}

		$announcement = $announcement->row();

		// Set user cookie
		$config = $this->config->item("cookieprefix");
		$cookie = $this->input->cookie($config . "announcement_" . $id, TRUE);

		if(!$cookie) {
			$ttl = 3600 * 72 * 30;
			setcookie($config . "announcement_" . $id, "1", time()+$ttl, "/");
		}

		$this->template->loadContent("client/view_announcement.php", array(
			"announcement" => $announcement
			)
		);
	}

	public function notifications()
	{
		$this->template->loadContent("client/notifications.php", array(
			)
		);
	}

	public function notifications_page()
	{
		$this->load->library("datatables");

		$this->datatables->set_default_order("user_notifications.timestamp", "desc");

		// Set page ordering options that can be used
		$this->datatables->ordering(
			array(
				 2 => array(
				 	"user_notifications.timestamp" => 0
				 )
			)
		);
		$this->datatables->set_total_rows(
			$this->user_model
			->get_notifications_all_total($this->user->info->ID)
		);
		$notifications = $this->user_model
			->get_notifications_all($this->user->info->ID, $this->datatables);



		foreach($notifications->result() as $r) {
			$msg = '<a href="'.site_url("profile/" . $r->username).'">'.$r->username.'</a> ' . $r->message;
			if($r->status !=1) {
				$msg .='<label class="label label-danger">'.lang("ctn_610").'</label>';
			}

			$this->datatables->data[] = array(
				$this->common->get_user_display(array("username" => $r->username, "avatar" => $r->avatar, "online_timestamp" => $r->online_timestamp)),
				$msg,
				date($this->settings->info->date_format, $r->timestamp),
				'<a href="'.site_url("home/load_notification/" . $r->ID).'" class="btn btn-primary btn-xs">'.lang("ctn_459").'</a>'
			);
		}
		echo json_encode($this->datatables->process());
	}

	public function payment_log()
	{
		$this->template->loadContent("client/payment_log.php", array(
			)
		);
	}

	public function payment_logs_page()
	{
		$this->load->library("datatables");

		$this->datatables->set_default_order("users.joined", "desc");

		// Set page ordering options that can be used
		$this->datatables->ordering(
			array(
				 2 => array(
				 	"payment_logs.amount" => 0
				 ),
				 3 => array(
				 	"payment_logs.timestamp" => 0
				 ),
				 4 => array(
				 	"payment_logs.processor" => 0
				 )
			)
		);

		$this->datatables->set_total_rows(
			$this->user_model
				->get_total_payment_logs_count($this->user->info->ID)
		);
		$logs = $this->user_model->get_payment_logs($this->user->info->ID, $this->datatables);

		foreach($logs->result() as $r) {
			$this->datatables->data[] = array(
				$this->common->get_user_display(array("username" => $r->username, "avatar" => $r->avatar, "online_timestamp" => $r->online_timestamp)),
				$r->email,
				number_format($r->amount, 2),
				date($this->settings->info->date_format, $r->timestamp),
				$r->processor
			);
		}
		echo json_encode($this->datatables->process());
	}

}

?>
