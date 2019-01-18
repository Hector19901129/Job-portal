<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Members extends CI_Controller 
{

	public function __construct() 
	{
		parent::__construct();
		$this->load->model("user_model");
		$this->load->model("jobs_model");
		if(!$this->user->loggedin) $this->template->error(lang("error_1"));
		
		$this->template->loadData("activeLink", 
			array("members" => array("general" => 1)));

		// If the user does not have premium. 

		if(!$this->common->has_permissions(array("admin", "job_manager", 
			"job_worker", "knowledge_manager"), $this->user)) {
			$this->template->error("You do not have access to this page!");
		}
	}

	public function index() 
	{
		
		$this->template->loadContent("members/index.php", array(
			)
		);
	}
	//newly inserted
	public function members_page() 
	{
		$this->load->library("datatables");

		$this->datatables->set_default_order("users.joined", "desc");

		// Set page ordering options that can be used
		$this->datatables->ordering(
			array(
				 0 => array(
				 	"users.username" => 0
				 ),
				 1 => array(
				 	"users.first_name" => 0
				 ),
				 2 => array(
				 	"users.last_name" => 0
				 ),
				 3 => array(
				 	"user_roles.name" => 0
				 ),
				 4 => array(
				 	"users.joined" => 0
				 ),
				 5 => array(
				 	"users.oauth_provider" => 0
				 ),
				 6 => array(
					"users.fields" => 0
				)
			)
		);

		$this->datatables->set_total_rows(
			$this->user_model
				->get_total_members_count()
		);
		$members = $this->user_model->get_members($this->datatables);

		foreach($members->result() as $r) {
			if($r->oauth_provider == "google") {
				$provider = "Google";
			} elseif($r->oauth_provider == "twitter") {
				$provider = "Twitter";
			} elseif($r->oauth_provider == "facebook") {
				$provider = "Facebook";
			} else {
				$provider =  lang("ctn_196");
			}
			// $btn = '<a href="'.site_url("members/edit_custom_field/" . $r->ID).'" class="btn btn-info btn-xs" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Select Fields">Select Fields</a>';
			$btn = '<a href="'.site_url("members/custom_fields/" . $r->ID).'" class="btn btn-info btn-xs" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Select Fields">Select Fields</a>';
			$this->datatables->data[] = array(
				$this->common->get_user_display(array("username" => $r->username, "avatar" => $r->avatar, "online_timestamp" => $r->online_timestamp, "user" => false)),
				$r->first_name,
				$r->last_name,
				$this->common->get_user_role($r),
				date($this->settings->info->date_format, $r->joined),
				$provider,
				$btn
			);
		}
		echo json_encode($this->datatables->process());
	}

	public function search() 
	{
		
		$search = $this->common->nohtml($this->input->post("search"));

		if(empty($search)) $this->template->error(lang("error_49"));

		$members = $this->user_model->get_members_by_search($search);
		if($members->num_rows() == 0) $this->template->error(lang("error_50"));

		$this->template->loadContent("members/search.php", array(
			"members" => $members,
			"search" => $search
			)
		);
	}
	//newly added
	public function custom_fields($id)
	{
		
		if(!$this->common->has_permissions(array(
			"admin", "job_manager"), $this->user)) {
			$this->template->error(lang("error_85"));
		}
		// $this->template->loadData("activeLink",
		// 	array("job" => array("custom" => 1)));


		$this->template->loadContent("members/custom_fields.php", array("id" => $id, "hash" => $this->security->get_csrf_hash()
			)
		);
	}
	//newly added
	public function field_page($id)
	{
		$user_id = intval($id);
		$fields = $this->user_model->get_member_by_id($id);
		$field = $fields->row()->custom_fields;
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
			$str = in_array($r->ID, explode(",", $field)) == true ? "checked": "";
			$nm = $r->ID;
			$this->datatables->data[] = array(
				$r->name,
				$type,
				'<input type="checkbox" name="require" value="'. $r->ID .'"'. $str .' id="'. $nm .'">',
			);
		}
		
		echo json_encode($this->datatables->process());
	}
	//newly added
	public function update_user_fields(){
		//data['token'] = $this->security->get_csrf_hash();

		$str = $this->input->post("str");
		$arr = explode("//", $str);
		$user_id = $arr[1];
		$field_str = $arr[0];
		if($field_str == ""){
			$field_str = ",";
		}
		$this->user_model->update_user_field($user_id, $field_str);
	}
}

?>