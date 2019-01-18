<?php
if ( ! defined('BASEPATH')) exit('No direct script access allowed'); 

class Settings 
{

	var $info=array();

	var $version = "2.2";

	public function __construct() 
	{
		$CI =& get_instance();
		$site = $CI->db->select("site_name,site_desc,site_email,
			upload_path_relative, upload_path, site_logo, register,
			 disable_captcha, date_format, avatar_upload, file_types,
			 twitter_consumer_key, twitter_consumer_secret, disable_social_login
			 , facebook_app_id, facebook_app_secret, google_client_id,
			 google_client_secret, file_size, paypal_email, paypal_currency,
			 payment_enabled, payment_symbol, global_premium, install,
			 login_protect, activate_account, default_user_role,
			 secure_login, stripe_secret_key, stripe_publish_key,
			 enable_job_guests, enable_job_uploads, 
			 enable_job_edit, require_login, protocol,
			 protocol_path, protocol_email, protocol_password, protocol_ssl,
			 job_title, job_rating, notes, google_recaptcha, 
			 google_recaptcha_secret, google_recaptcha_key, logo_option,
			 avatar_height, avatar_width, default_category, checkout2_accountno,
			 checkout2_secret, layout, imap_job_string, imap_reply_string,
			 captcha_job, envato_personal_token, cache_time, field_order")
		->where("ID", 1)
		->get("site_settings");
		
		if($site->num_rows() == 0) {
			$CI->template->error(
				"You are missing the site settings database row."
			);
		} else {
			$this->info = $site->row();
		}
	}

}

?>