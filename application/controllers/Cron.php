<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Cron extends CI_Controller 
{
	var $debug;

	public function __construct() 
	{
		parent::__construct();
		$this->load->model("admin_model");
		$this->load->model("user_model");
	}

	public function job_create() 
	{
		$enable_debug = 0;
		$debug = "";
		$this->load->model("jobs_model");
		include(APPPATH . "/libraries/IMap.php");

		$imapPath = $this->settings->info->protocol_path;
		$username = $this->settings->info->protocol_email;
		$password = $this->settings->info->protocol_password;

		if($this->settings->info->protocol ==1) {
			$protocol = "imap";
		} elseif($this->settings->info->protocol == 2) {
			$protocol = "pop3";
		}
		if($this->settings->info->protocol_ssl) {
			$ssl = "/ssl";
		} else {
			$ssl = "";
		}

		$host = $this->settings->info->protocol_path . "/" . $protocol . $ssl;

		$imap = new IMap("{" .$host. "}INBOX", $username, $password);
		$emails = $imap->search(array(
			"unseen" => 1
			)
		);

		if($emails) {
			$debug .="Count: " . count($emails);
			foreach($emails as $mail) {
				$header = $imap->get_header_info($mail);
				$message = $imap->getmsg($mail);
				if(isset($message['htmlmsg']) && !empty($message['htmlmsg'])) {
					$body = $message['htmlmsg'];
				} elseif(isset($message['plainmsg']) && !empty($message['plainmsg'])) {
					$body = $message['plainmsg'];
				} else {
					$body = "";
				}

				$header->subject = mb_decode_mimeheader($header->subject);

				if(strpos($header->subject, $this->settings->info->job_title . " [ID:") === false) {

					// Check title doesn't match.
					// No match = no reply.

					// Now we need to extract job id.
					$pos = strpos($body, $this->settings->info->imap_job_string);
					if($pos === false) {
						// New job creation
						$debug .="Found new email. Creating job ...";

						$body = $imap->extract_gmail_message($body);
						$body = $imap->extract_outlook_message($body);

						$body = strip_tags($body, "<br><p>");

						// Job variables
						$title = $header->subject;
						$body = $body;
						$clientid = 0;
						$assignedid = 0;
						$categoryid = $this->settings->info->default_category;
						$status = 0;
						$priority = 0;
						$notes = lang("ctn_660");
						$guest_email = $header->from;

						// Create job
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

						// Send reply
						// Send email
						$this->load->model("home_model");
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

						$username = $guest_email;
						$email = $guest_email;
						

						$email_template->message = $this->common->replace_keywords(array(
							"[NAME]" => $username,
							"[SITE_URL]" => site_url(),
							"[TICKET_BODY]" => $body,
							"[TICKET_ID]" => $jobid,
							"[SITE_NAME]" =>  $this->settings->info->site_name,
							"[GUEST_EMAIL]" => $guest_email,
							"[GUEST_PASS]" => $guest_password,
							"[GUEST_LOGIN]" => site_url("client/jobs")
							),
						$email_template->message);

						$headers = array(
							"Message-ID" => $message_id_hash
							);
						$this->common->send_email($this->settings->info->job_title . " [ID: " . $jobid . "]: " . $title,
							 $email_template->message, $email, $headers);
						$debug .= "... Sending Email ... ";

						$this->jobs_model->add_history(array(
							"userid" => 0,
							"message" => lang("ctn_658"),
							"timestamp" => time(),
							"jobid" => $jobid
							)
						);
						// Mark as read
						$imap->mark_as_read($mail);
						continue;
					}
				}
			}
		}

		if($enable_debug) {
			echo "DEBUG OUTPUT: <br />";
			echo $debug;
		}

		exit();
	}

	public function job_replies() 
	{
		$enable_debug = 0;
		$debug = "";
		$this->load->model("jobs_model");
		include(APPPATH . "/libraries/IMap.php");

		$imapPath = $this->settings->info->protocol_path;
		$username = $this->settings->info->protocol_email;
		$password = $this->settings->info->protocol_password;

		if($this->settings->info->protocol ==1) {
			$protocol = "imap";
		} elseif($this->settings->info->protocol == 2) {
			$protocol = "pop3";
		}
		if($this->settings->info->protocol_ssl) {
			$ssl = "/ssl";
		} else {
			$ssl = "";
		}

		$host = $this->settings->info->protocol_path . "/" . $protocol . $ssl;

		$imap = new IMap("{" .$host. "}INBOX", $username, $password);
		$emails = $imap->search(array(
			"subject" => $this->settings->info->job_title . " [ID:",
			"unseen" => 1
			)
		);

		if($emails) {
			$debug .="Count: " . count($emails);
			foreach($emails as $mail) {
				$header = $imap->get_header_info($mail);
				$message = $imap->getmsg($mail);
				if(isset($message['htmlmsg']) && !empty($message['htmlmsg'])) {
					$body = $message['htmlmsg'];
				} elseif(isset($message['plainmsg']) && !empty($message['plainmsg'])) {
					$body = $message['plainmsg'];
				} else {
					$body = "";
				}

				$header->subject = mb_decode_mimeheader($header->subject);

				// Now we need to extract job id.
				$pos = strpos($body, $this->settings->info->imap_job_string);
				if($pos === false) {
					// New job creation
					$debug .="Unable to find job id.";

					// Mark as read
					$imap->mark_as_read($mail);
					continue;
				} else {
					$jobid = $this->get_job_id($body);
				}


				// Strip old text from body
				$body = strstr($body, $this->settings->info->imap_reply_string, true);

				// GMAIL SUPPORT
				$body = $imap->extract_gmail_message($body);
				$body = $imap->extract_outlook_message($body);


				$body = strip_tags($body, "<br><p>");

				// Look up a job in our system
				$job = $this->jobs_model->get_job($jobid);
				if($job->num_rows() == 0) {
					$debug .="NO Job";
					// Mark as read
					$imap->mark_as_read($mail);
					continue;
				}
				$job = $job->row();
				if(isset($job->client_email) && !empty($job->client_email)) {
					$email = $job->client_email;
				} else {
					$email = $job->guest_email;
				}

				if(strcasecmp($email, $header->from) == 0) {
					// Match
					// Post job reply
					// Add
					$replyid = $this->jobs_model->add_job_reply(array(
						"jobid" => $jobid,
						"userid" => $job->userid,
						"body" => $body,
						"timestamp" => time(),
						)
					);

					// Update last reply
					$this->jobs_model->update_job($job->ID, array(
						"last_reply_userid" => $job->userid,
						"last_reply_timestamp" => time(),
						"last_reply_string" => date($this->settings->info->date_format, time())
						)
					);
					$debug .="Message added";
					$imap->mark_as_read($mail);

					$this->jobs_model->add_history(array(
							"userid" => 0,
							"message" => lang("ctn_659"),
							"timestamp" => time(),
							"jobid" => $job->ID
							)
						);

					// Notification
					// Alert assigned user of new reply
					if($job->assignedid > 0) {
						$this->user_model->increment_field($job->assignedid, "noti_count", 1);
						$this->user_model->add_notification(array(
							"userid" => $job->assignedid,
							"url" => "jobs/view/" . $job->ID,
							"timestamp" => time(),
							"message" => lang("ctn_612"),
							"status" => 0,
							"fromid" => $job->userid,
							"username" => $job->username,
							"email" => $job->email,
							"email_notification" => $job->email_notification
							)
						);
					}
				} else {
					$debug .="From email does not match job db.";
					// Mark as read
					$imap->mark_as_read($mail);
					continue;
				}
			}
		}

		if($enable_debug) {
			echo "DEBUG OUTPUT: <br />";
			echo $debug;
		}

		exit();
	}

	private function get_job_id($body) 
	{
		$job = trim(strstr($body, $this->settings->info->imap_job_string));
		$jobid = substr($job, 
			strlen($this->settings->info->imap_job_string),
			strlen($job)
		);
		$jobid = intval(strstr(trim($jobid), " ", true));
		return $jobid;
	}

}