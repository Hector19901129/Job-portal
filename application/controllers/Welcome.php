<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Welcome extends CI_Controller 
{

	public function __construct() 
	{
		parent::__construct();
		if (defined('REQUEST') && REQUEST == "external") {
	        return;
	    }
		/*$this->template->loadData("activeLink", 
			array("home" => array("general" => 1)));
		$this->load->model("user_model");
		$this->load->model("home_model");
		$this->load->model("jobs_model");
		if(!$this->user->loggedin) {
			redirect(site_url("login"));
		}*/
	}

	public function index()
	{
		echo 'welcome';
		/*$this->load->library('email');

		$config['protocol']    = 'smtp';

		$config['smtp_host']    = 'ssl://smtp.gmail.com';

		$config['smtp_port']    = '465';

		$config['smtp_timeout'] = '7';

		$config['smtp_user']    = 'kapilgulati19@gmail.com';

		$config['smtp_pass']    = 'MeenaGarv161616';

		$config['charset']    = 'utf-8';

		$config['newline']    = "\r\n";

		$config['mailtype'] = 'text'; // or html

		$config['validation'] = TRUE; // bool whether to validate email or not      

		$this->email->initialize($config);


		$this->email->from('kapilgulati19@gmail.com', 'Kapil Gulati');
		$this->email->to('kapilgulati19@gmail.com'); 


		$this->email->subject('Email Test');

		$this->email->message('Testing the email class.');  

		$this->email->send();

		echo $this->email->print_debugger();*/
		/*ini_set( 'display_errors', 1 );

	    error_reporting( E_ALL );

	    $from = "info@hotelpineview.com";

	    $to = "testmailhostingserver@gmail.com";

	    $to = "kapilgulati19@gmail.com";

	    $subject = "PHP Mail Test script";

	    $message = "This is a test to check the PHP Mail functionality";

	    $headers = "From:" . $from;

	    mail($to,$subject,$message, $headers);

	    echo "Test email sent";*/

	    //$from_email = "your@example.com";
	    $from_email = "info@hotelpineview.com";
         $to_email = "par.caresu@gmail.com"; 
   
         //Load email library 
         $this->load->library('email'); 
   
         $this->email->from($from_email, 'Your Name'); 
         $this->email->to($to_email);
         $this->email->subject('Email Test'); 
         $this->email->message('Testing the email class.'); 
   
         //Send mail 
         if($this->email->send()) 
         //$this->session->set_flashdata("email_sent","Email sent successfully."); 
         	echo 'mail sent';
         else 
         	//$this->session->set_flashdata("email_sent","Error in sending Email.");
         	echo 'not sent';
	}

	

}

?>