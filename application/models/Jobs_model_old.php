<?php

class Jobs_Model extends CI_Model
{

	public function get_categories()
	{
		return $this->db->get("job_categories");
	}

	public function get_user_categories($userid)
	{
		return $this->db->select("job_categories.name, job_categories.ID")
			->join("job_category_groups", "job_category_groups.catid = job_categories.ID", "left outer")
			->join("user_groups", "user_groups.ID = job_category_groups.groupid", "LEFT OUTER")
			->join("user_group_users", "user_group_users.groupid = user_groups.ID", "LEFT OUTER")
			->where("user_group_users.userid", $userid)
			->group_by("job_categories.ID")
			->get("job_categories");
	}

	public function get_category($id)
	{
		return $this->db->where("ID", $id)
			->order_by("job_categories.cat_parent")->get("job_categories");
	}

	public function add_category($data)
	{
		$this->db->insert("job_categories", $data);
		return $this->db->insert_id();
	}

	public function delete_category($id)
	{
		$this->db->where("ID", $id)->delete("job_categories");
	}

	public function update_category($id, $data)
	{
		$this->db->where("ID", $id)->update("job_categories", $data);
	}

	public function get_categories_total()
	{
		$s = $this->db->select("COUNT(*) as num")->get("job_categories");
		$r = $s->row();
		if(isset($r->num)) return $r->num;
		return 0;
	}

	public function get_categories_dt($datatable)
	{
		$datatable->db_order();

		$datatable->db_search(array(
			"job_categories.name",
			"t_c.name",
			)
		);

		return $this->db
			->select("job_categories.ID, job_categories.name,
				job_categories.image, job_categories.description,
				job_categories.cat_parent,
				t_c.name as name2")
			->join("job_categories as t_c", "t_c.ID = job_categories.cat_parent", "left outer")
			->limit($datatable->length, $datatable->start)
			->get("job_categories");

	}

	public function add_custom_field($data)
	{
		$this->db->insert("job_custom_fields", $data);
		return $this->db->insert_id();
	}

	public function update_custom_field($id, $data)
	{
		$this->db->where("ID", $id)->update("job_custom_fields", $data);
	}

	public function add_field_cats($data)
	{
		$this->db->insert("job_custom_field_cats", $data);
	}

	public function get_custom_fields_total()
	{
		$s = $this->db->select("COUNT(*) as num")->get("job_custom_fields");
		$r = $s->row();
		if(isset($r->num)) return $r->num;
		return 0;
	}

	public function get_custom_fields($datatable)
	{
		$datatable->db_order();

		$datatable->db_search(array(
			"job_custom_fields.name"
			)
		);

		return $this->db
			->limit($datatable->length, $datatable->start)
			->get("job_custom_fields");
	}

	public function get_custom_field($id)
	{
		return $this->db->where("ID", $id)->get("job_custom_fields");
	}

	public function delete_custom_field($id)
	{
		$this->db->where("ID", $id)->delete("job_custom_fields");
	}

	public function get_field_cats($fieldid)
	{
		return $this->db
			->select("job_categories.ID, job_categories.name, job_custom_field_cats.ID as cid")
			->join("job_custom_field_cats", "job_custom_field_cats.catid = job_categories.ID AND job_custom_field_cats.fieldid = " . $fieldid, "left outer")
			->get("job_categories");
	}

	public function delete_custom_fields_cats($id)
	{
		$this->db->where("fieldid", $id)->delete("job_custom_field_cats");
	}

	public function get_category_no_parent()
	{
		return $this->db->where("cat_parent", 0)->get("job_categories");
	}

	public function get_sub_cats($parentid)
	{
		return $this->db->where("cat_parent", $parentid)->get("job_categories");
	}

	public function get_custom_fields_all_cats()
	{
		return $this->db->where("all_cats", 1)->get("job_custom_fields");
	}

	public function get_custom_fields_for_cat($catid)
	{
		return $this->db
			->select("job_custom_fields.ID, job_custom_fields.name,
				job_custom_fields.type, job_custom_fields.options,
				job_custom_fields.help_text, job_custom_fields.required,
				job_custom_fields.all_cats, job_custom_fields.hide_clientside")
			->where("job_custom_field_cats.catid", $catid)
			->join("job_custom_fields", "job_custom_fields.ID = job_custom_field_cats.fieldid")
			->get("job_custom_field_cats");
	}

	public function add_job($data)
	{
		$this->db->insert("jobs", $data);
		return $this->db->insert_id();
	}

	public function add_custom_field_data($data)
	{
		$this->db->insert("job_user_custom_fields", $data);
	}

	public function add_attached_files($data)
	{
		$this->db->insert("job_files", $data);
	}

	public function get_jobs_rating_total()
	{


		$s = $this->db
				->where("rating >", 0)
				->select("COUNT(*) as num")
				->get("jobs");
		$r = $s->row();
		if(isset($r->num)) return $r->num;
		return 0;
	}

	public function get_rating_jobs( $datatable)
	{

		$datatable->db_order();

		$datatable->db_search(array(
			"jobs.title",
			"users.username",
			"u2.username",
			"jobs.guest_email",
			"jobs.last_reply_string"
			)
		);

		return $this->db
			->where("jobs.rating >", 0)
			->select("jobs.ID, jobs.rating, jobs.title, jobs.userid,
				 jobs.assignedid,
				jobs.timestamp, jobs.categoryid, jobs.status,
				jobs.priority, jobs.last_reply_timestamp,
				jobs.last_reply_userid, jobs.message_id_hash,
				jobs.guest_email,
				users.username as client_username, users.avatar as client_avatar,
				users.online_timestamp as client_online_timestamp,
				u2.username, u2.avatar, u2.online_timestamp,
				job_categories.name as cat_name")
			->join("users", "users.ID = jobs.userid", "left outer")
			->join("users as u2", "u2.ID = jobs.assignedid", "left outer")
			->join("job_categories", "job_categories.ID = jobs.categoryid")
			->limit($datatable->length, $datatable->start)
			->get("jobs");
	}

	public function get_user_ratings_total()
	{
		$s = $this->db
			->where("jobs.rating >", 0)
			->select("COUNT(*) as num")
			->join("jobs", "jobs.assignedid = users.ID")
			->group_by("users.ID")
			->get("users");
		$r = $s->row();
		if(isset($r->num)) return $r->num;
		return 0;
	}

	public function get_user_ratings( $datatable)
	{

		$datatable->db_order();

		$datatable->db_search(array(
			"users.username"

			)
		);

		return $this->db
			->where("jobs.rating >", 0)
			->select("users.username, users.avatar, users.online_timestamp,
			 AVG(jobs.rating) as avgrating, COUNT(jobs.ID) as total")
			->join("jobs", "jobs.assignedid = users.ID")
			->limit($datatable->length, $datatable->start)
			->group_by("users.ID")
			->get("users");
	}

	public function get_jobs_total($catid, $view, $datatable)
	{
		$datatable->db_search(array(
			"jobs.title",
			"users.username",
			"u2.username",
			"jobs.guest_email",
			"jobs.last_reply_string",
			"jobs.ID"
			)
		);

		if($view->num_rows() > 0) {
			$view = $view->row();
			$catid = $view->categoryid;

			if($view->status != -1) {
				$this->db->where("jobs.status", $view->status);
			}
		}
		if($catid > 0) {
			$this->db->where("jobs.categoryid", $catid);
		}

		$s = $this->db
				->select("COUNT(*) as num")
				->join("users", "users.ID = jobs.userid", "left outer")
			->join("users as u2", "u2.ID = jobs.assignedid", "left outer")
			->join("users as u3", "u3.ID = jobs.last_reply_userid", "left outer")
			->join("job_categories", "job_categories.ID = jobs.categoryid")
				->get("jobs");
		$r = $s->row();
		if(isset($r->num)) return $r->num;
		return 0;
	}

	public function get_jobs_total_no_view($catid)
	{
		if($catid > 0) {
			$this->db->where("jobs.categoryid", $catid);
		}

		$s = $this->db
				->select("COUNT(*) as num")
				->get("jobs");
		$r = $s->row();
		if(isset($r->num)) return $r->num;
		return 0;
	}

	public function get_jobs($catid, $datatable, $view)
	{

		if($view->num_rows() > 0) {
			$view = $view->row();
			$catid = $view->categoryid;

			if($view->status != -1) {
				$this->db->where("jobs.status", $view->status);
			}
		}

		if($catid > 0) {
			$this->db->where("jobs.categoryid", $catid);
		}

		$datatable->db_order();

		$datatable->db_search(array(
			"jobs.title",
			"users.username",
			"u2.username",
			"jobs.guest_email",
			"jobs.last_reply_string",
			"jobs.ID"
			)
		);

		return $this->db
			->select("jobs.ID, jobs.title, jobs.userid, jobs.assignedid,
				jobs.timestamp, jobs.categoryid, jobs.status,
				jobs.priority, jobs.last_reply_timestamp,
				jobs.last_reply_userid, jobs.message_id_hash,
				jobs.guest_email,
				users.username as client_username, users.avatar as client_avatar,
				users.online_timestamp as client_online_timestamp,
				users.first_name as client_first_name,
				users.last_name as client_last_name,
				u2.username, u2.avatar, u2.online_timestamp, users.first_name,
				users.last_name,
				u3.username as lr_username, u3.avatar as lr_avatar,
				u3.online_timestamp as lr_online_timestamp,
				job_categories.name as cat_name")
			->join("users", "users.ID = jobs.userid", "left outer")
			->join("users as u2", "u2.ID = jobs.assignedid", "left outer")
			->join("users as u3", "u3.ID = jobs.last_reply_userid", "left outer")
			->join("job_categories", "job_categories.ID = jobs.categoryid")
			->limit($datatable->length, $datatable->start)
			->get("jobs");
	}

	public function get_jobs_assigned_total($userid, $catid, $view, $datatable)
	{
		$datatable->db_search(array(
			"jobs.title",
			"users.username",
			"u2.username",
			"jobs.guest_email",
			"jobs.last_reply_string",
			"jobs.ID"
			)
		);

		if($view->num_rows() > 0) {
			$view = $view->row();
			$catid = $view->categoryid;

			if($view->status != -1) {
				$this->db->where("jobs.status", $view->status);
			}
		}
		if($catid > 0) {
			$this->db->where("jobs.categoryid", $catid);
		}

		$s = $this->db
				->where("jobs.assignedid", $userid)
				->select("COUNT(*) as num")
				->join("users", "users.ID = jobs.userid", "left outer")
				->join("users as u2", "u2.ID = jobs.assignedid", "left outer")
				->join("users as u3", "u3.ID = jobs.last_reply_userid", "left outer")
				->join("job_categories", "job_categories.ID = jobs.categoryid")
				->get("jobs");
		$r = $s->row();
		if(isset($r->num)) return $r->num;
		return 0;
	}

	public function get_jobs_assigned_total_no_view($userid, $catid)
	{
		if($catid > 0) {
			$this->db->where("jobs.categoryid", $catid);
		}

		$s = $this->db
				->where("assignedid", $userid)
				->select("COUNT(*) as num")
				->get("jobs");
		$r = $s->row();
		if(isset($r->num)) return $r->num;
		return 0;
	}

	public function get_jobs_assigned($userid, $catid, $datatable, $view)
	{
		if($view->num_rows() > 0) {
			$view = $view->row();
			$catid = $view->categoryid;

			if($view->status != -1) {
				$this->db->where("jobs.status", $view->status);
			}
		}

		if($catid > 0) {
			$this->db->where("jobs.categoryid", $catid);
		}

		$datatable->db_order();

		$datatable->db_search(array(
			"jobs.title",
			"users.username",
			"u2.username",
			"jobs.guest_email",
			"jobs.last_reply_string",
			"jobs.ID"
			)
		);

		return $this->db
			->where("jobs.assignedid", $userid)
			->select("jobs.ID, jobs.title, jobs.userid, jobs.assignedid,
				jobs.timestamp, jobs.categoryid, jobs.status,
				jobs.priority, jobs.last_reply_timestamp,
				jobs.last_reply_userid, jobs.message_id_hash,
				jobs.guest_email,
				users.username as client_username, users.avatar as client_avatar,
				users.online_timestamp as client_online_timestamp,
				u2.username, u2.avatar, u2.online_timestamp,
				u3.username as lr_username, u3.avatar as lr_avatar,
				u3.online_timestamp as lr_online_timestamp,
				job_categories.name as cat_name")
			->join("users", "users.ID = jobs.userid", "left outer")
			->join("users as u2", "u2.ID = jobs.assignedid", "left outer")
			->join("users as u3", "u3.ID = jobs.last_reply_userid", "left outer")
			->join("job_categories", "job_categories.ID = jobs.categoryid")
			->limit($datatable->length, $datatable->start)
			->get("jobs");
	}

	public function get_client_jobs_total($userid)
	{
		$s = $this->db
				->where("userid", $userid)
				->select("COUNT(*) as num")
				->get("jobs");
		$r = $s->row();
		if(isset($r->num)) return $r->num;
		return 0;
	}

	public function get_client_jobs($userid, $datatable)
	{
		$datatable->db_order();

		$datatable->db_search(array(
			"jobs.title"
			)
		);

		return $this->db
			->where("jobs.userid", $userid)
			->select("jobs.ID, jobs.title, jobs.userid, jobs.assignedid,
				jobs.timestamp, jobs.categoryid, jobs.status,
				jobs.priority, jobs.last_reply_timestamp,
				jobs.last_reply_userid, jobs.message_id_hash,
				jobs.guest_email,
				users.username as client_username, users.avatar as client_avatar,
				users.online_timestamp as client_online_timestamp,
				u2.username, u2.avatar, u2.online_timestamp,
				u3.username as lr_username, u3.avatar as lr_avatar,
				u3.online_timestamp as lr_online_timestamp,
				job_categories.name as cat_name")
			->join("users", "users.ID = jobs.userid", "left outer")
			->join("users as u2", "u2.ID = jobs.assignedid", "left outer")
			->join("users as u3", "u3.ID = jobs.last_reply_userid", "left outer")
			->join("job_categories", "job_categories.ID = jobs.categoryid")
			->limit($datatable->length, $datatable->start)
			->get("jobs");
	}

	public function get_jobs_your_total($userid, $catid, $view, $datatable)
	{
		$datatable->db_search(array(
			"jobs.title",
			"users.username",
			"u2.username",
			"jobs.guest_email",
			"jobs.last_reply_string",
			"jobs.ID"
			)
		);

		if($view->num_rows() > 0) {
			$view = $view->row();
			$catid = $view->categoryid;

			if($view->status != -1) {
				$this->db->where("jobs.status", $view->status);
			}
		}
		if($catid > 0) {
			$this->db->where("jobs.categoryid", $catid);
		}
		$s = $this->db
			->select("COUNT(*) as num")
			->join("users", "users.ID = jobs.userid", "left outer")
			->join("users as u2", "u2.ID = jobs.assignedid", "left outer")
			->join("job_categories", "job_categories.ID = jobs.categoryid")
			->join("job_category_groups", "job_category_groups.catid = job_categories.ID", "left outer")
			->join("user_groups", "user_groups.ID = job_category_groups.groupid", "LEFT OUTER")
			->join("user_group_users", "user_group_users.groupid = user_groups.ID", "LEFT OUTER")
			->where("user_group_users.userid", $userid)
			->group_by("jobs.ID")
			->get("jobs");
		$r = $s->row();
		if(isset($r->num)) return $r->num;
		return 0;
	}

	public function get_jobs_your($userid, $catid, $datatable, $view)
	{
		if($view->num_rows() > 0) {
			$view = $view->row();
			$catid = $view->categoryid;

			if($view->status != -1) {
				$this->db->where("jobs.status", $view->status);
			}
		}

		if($catid > 0) {
			$this->db->where("jobs.categoryid", $catid);
		}

		$datatable->db_order();

		$datatable->db_search(array(
			"jobs.title",
			"users.username",
			"u2.username",
			"jobs.guest_email",
			"jobs.last_reply_string",
			"jobs.ID"
			)
		);

		return $this->db
			->select("jobs.ID, jobs.title, jobs.userid, jobs.assignedid,
				jobs.timestamp, jobs.categoryid, jobs.status,
				jobs.priority, jobs.last_reply_timestamp,
				jobs.last_reply_userid, jobs.message_id_hash,
				jobs.guest_email,
				users.username as client_username, users.avatar as client_avatar,
				users.online_timestamp as client_online_timestamp,
				u2.username, u2.avatar, u2.online_timestamp,
				u3.username as lr_username, u3.avatar as lr_avatar,
				u3.online_timestamp as lr_online_timestamp,
				job_categories.name as cat_name")
			->join("users", "users.ID = jobs.userid", "left outer")
			->join("users as u2", "u2.ID = jobs.assignedid", "left outer")
			->join("users as u3", "u3.ID = jobs.last_reply_userid", "left outer")
			->join("job_categories", "job_categories.ID = jobs.categoryid")
			->join("job_category_groups", "job_category_groups.catid = job_categories.ID", "left outer")
			->join("user_groups", "user_groups.ID = job_category_groups.groupid", "LEFT OUTER")
			->join("user_group_users", "user_group_users.groupid = user_groups.ID", "LEFT OUTER")
			->where("user_group_users.userid", $userid)
			->group_by("jobs.ID")
			->limit($datatable->length, $datatable->start)
			->get("jobs");
	}

	public function get_jobs_your_limit($userid, $catid, $limit)
	{
		if($catid > 0) {
			$this->db->where("jobs.categoryid", $catid);
		}


		return $this->db
			->select("jobs.ID, jobs.title, jobs.userid, jobs.assignedid,
				jobs.timestamp, jobs.categoryid, jobs.status,
				jobs.priority, jobs.last_reply_timestamp,
				jobs.last_reply_userid, jobs.message_id_hash,
				jobs.guest_email,
				users.username as client_username, users.avatar as client_avatar,
				users.online_timestamp as client_online_timestamp,
				u2.username, u2.avatar, u2.online_timestamp,
				job_categories.name as cat_name")
			->join("users", "users.ID = jobs.userid", "left outer")
			->join("users as u2", "u2.ID = jobs.assignedid", "left outer")
			->join("job_categories", "job_categories.ID = jobs.categoryid")
			->join("job_category_groups", "job_category_groups.catid = job_categories.ID", "left outer")
			->join("user_groups", "user_groups.ID = job_category_groups.groupid", "LEFT OUTER")
			->join("user_group_users", "user_group_users.groupid = user_groups.ID", "LEFT OUTER")
			->where("user_group_users.userid", $userid)
			->group_by("jobs.ID")
			->limit($limit)
			->get("jobs");
	}

	public function get_jobs_assigned_limit($userid, $catid, $limit)
	{
		if($catid > 0) {
			$this->db->where("jobs.categoryid", $catid);
		}


		return $this->db
			->where("jobs.assignedid", $userid)
			->select("jobs.ID, jobs.title, jobs.userid, jobs.assignedid,
				jobs.timestamp, jobs.categoryid, jobs.status,
				jobs.priority, jobs.last_reply_timestamp,
				jobs.last_reply_userid, jobs.message_id_hash,
				jobs.guest_email,
				users.username as client_username, users.avatar as client_avatar,
				users.online_timestamp as client_online_timestamp,
				u2.username, u2.avatar, u2.online_timestamp,
				job_categories.name as cat_name")
			->join("users", "users.ID = jobs.userid", "left outer")
			->join("users as u2", "u2.ID = jobs.assignedid", "left outer")
			->join("job_categories", "job_categories.ID = jobs.categoryid")
			->limit($limit)
			->get("jobs");
	}

	public function get_job($id)
	{
		return $this->db
			->where("jobs.ID", $id)
			->select("jobs.ID, jobs.title, jobs.userid, jobs.assignedid,
				jobs.timestamp, jobs.categoryid, jobs.status,
				jobs.priority, jobs.last_reply_timestamp,
				jobs.last_reply_userid, jobs.message_id_hash,
				jobs.guest_email, jobs.guest_password,
				jobs.notes, jobs.body, jobs.rating,
				users.username as client_username, users.avatar as client_avatar,
				users.online_timestamp as client_online_timestamp, users.email as
				client_email, users.email_notification as client_email_notification,
				users.first_name, users.last_name,
				u2.username, u2.avatar, u2.online_timestamp, u2.email,
				u2.email_notification,
				job_categories.name as cat_name, job_categories.cat_parent")
			->join("users", "users.ID = jobs.userid", "left outer")
			->join("users as u2", "u2.ID = jobs.assignedid", "left outer")
			->join("job_categories", "job_categories.ID = jobs.categoryid")
			->get("jobs");
	}

	public function get_guest_job($email, $pass)
	{
		return $this->db
			->where("jobs.guest_email", $email)
			->where("jobs.guest_password", $pass)
			->select("jobs.ID, jobs.title, jobs.userid, jobs.assignedid,
				jobs.timestamp, jobs.categoryid, jobs.status,
				jobs.priority, jobs.last_reply_timestamp,
				jobs.last_reply_userid, jobs.message_id_hash,
				jobs.guest_email, jobs.notes, jobs.body,
				users.username as client_username, users.avatar as client_avatar,
				users.online_timestamp as client_online_timestamp, users.email as
				client_email, users.first_name, users.last_name,
				u2.username, u2.avatar, u2.online_timestamp,
				job_categories.name as cat_name, job_categories.cat_parent")
			->join("users", "users.ID = jobs.userid", "left outer")
			->join("users as u2", "u2.ID = jobs.assignedid", "left outer")
			->join("job_categories", "job_categories.ID = jobs.categoryid")
			->get("jobs");
	}

	public function delete_job($id)
	{
		$this->db->where("ID", $id)->delete("jobs");
	}

	public function update_job($id, $data)
	{
		$this->db->where("ID", $id)->update("jobs", $data);
	}

	public function get_custom_fields_for_cat_job($jobid, $catid)
	{
		return $this->db
			->select("job_custom_fields.ID, job_custom_fields.name,
				job_custom_fields.type, job_custom_fields.options,
				job_custom_fields.help_text, job_custom_fields.required,
				job_custom_fields.all_cats,
				job_custom_fields.hide_clientside,
				job_user_custom_fields.value,
				job_user_custom_fields.itemname,
				job_user_custom_fields.support,
				job_user_custom_fields.error")
			->where("job_custom_field_cats.catid", $catid)
			->join("job_custom_fields", "job_custom_fields.ID = job_custom_field_cats.fieldid")
			->join("job_user_custom_fields", "job_user_custom_fields.fieldid = job_custom_fields.ID AND job_user_custom_fields.jobid = " . $jobid, "left outer")
			->get("job_custom_field_cats");
	}

	public function get_custom_fields_all_cats_job($jobid)
	{
		return $this->db
			->select("job_custom_fields.ID, job_custom_fields.name,
				job_custom_fields.type, job_custom_fields.options,
				job_custom_fields.help_text, job_custom_fields.required,
				job_custom_fields.all_cats,
				job_custom_fields.hide_clientside,
				job_user_custom_fields.value,
				job_user_custom_fields.itemname,
				job_user_custom_fields.support,
				job_user_custom_fields.error")
			->where("job_custom_fields.all_cats", 1)
			->join("job_user_custom_fields", "job_user_custom_fields.fieldid = job_custom_fields.ID AND job_user_custom_fields.jobid = " . $jobid, "left outer")
			->get("job_custom_fields");
	}

	public function get_job_files($jobid)
	{
		return $this->db->where("jobid", $jobid)->get("job_files");
	}

	public function get_job_file($id)
	{
		return $this->db->where("ID", $id)->get("job_files");
	}

	public function delete_job_file($id)
	{
		$this->db->where("ID", $id)->delete("job_files");
	}

	public function delete_custom_field_data($id)
	{
		$this->db->where("jobid", $id)->delete("job_user_custom_fields");
	}

	public function add_job_reply($data)
	{
		$this->db->insert("job_replies", $data);
		return $this->db->insert_id();
	}

	public function get_job_replies($id)
	{
		return $this->db
			->where("job_replies.jobid", $id)
			->select("job_replies.ID, job_replies.body,
				job_replies.timestamp, job_replies.files,
				users.ID as userid, users.username, users.avatar,
				users.online_timestamp")
			->join("users", "users.ID = job_replies.userid", "left outer")
			->order_by("job_replies.ID")
			->get("job_replies");
	}

	public function get_job_reply($id)
	{
		return $this->db->where("ID", $id)->get("job_replies");
	}

	public function update_job_reply($id, $data)
	{
		$this->db->where("ID", $id)->update("job_replies", $data);
	}

	public function delete_job_reply($id)
	{
		$this->db->where("ID", $id)->delete("job_replies");
	}

	public function get_custom_fields_for_job($jobid)
	{
		return $this->db
			->select("job_custom_fields.ID, job_custom_fields.name,
				job_custom_fields.type, job_custom_fields.options,
				job_custom_fields.help_text, job_custom_fields.required,
				job_custom_fields.all_cats,
				job_custom_fields.hide_clientside,
				job_user_custom_fields.value,
				job_user_custom_fields.itemname,
				job_user_custom_fields.support,
				job_user_custom_fields.error")
			->join("job_user_custom_fields", "job_user_custom_fields.fieldid = job_custom_fields.ID AND job_user_custom_fields.jobid = " . $jobid)
			->get("job_custom_fields");
	}

	public function add_category_group($data)
	{
		$this->db->insert("job_category_groups", $data);
	}

	public function get_category_groups($catid)
	{
		return $this->db->where("catid", $catid)->get("job_category_groups");
	}

	public function delete_category_groups($catid)
	{
		$this->db->where("catid", $catid)->delete("job_category_groups");
	}

	public function get_cat_groups($catid)
	{
		return $this->db
			->select("user_groups.ID, user_groups.name, job_category_groups.ID as cid")
			->join("job_category_groups", "job_category_groups.groupid = user_groups.ID AND job_category_groups.catid = " . $catid, "left outer")
			->get("user_groups");
	}

	public function get_user_groups($groupids, $userid)
	{
		$this->db->group_start();
		foreach($groupids as $groupid)
		{
			$this->db->or_where("groupid", $groupid);
		}
		$this->db->group_end();
		return $this->db->where("userid", $userid)->get("user_group_users");
	}

	public function add_canned_response($data)
	{
		$this->db->insert("canned_responses", $data);
	}

	public function update_canned_response($id, $data)
	{
		$this->db->where("ID", $id)->update("canned_responses", $data);
	}

	public function delete_canned_response($id)
	{
		$this->db->where("ID", $id)->delete("canned_responses");
	}

	public function get_canned_response($id)
	{
		return $this->db->where("ID", $id)->get("canned_responses");
	}

	public function get_canned_total()
	{
		$s = $this->db->select("COUNT(*) as num")->get("canned_responses");
		$r = $s->row();
		if(isset($r->num)) return $r->num;
		return 0;
	}

	public function get_canned_responses($datatable)
	{
		$datatable->db_order();

		$datatable->db_search(array(
			"canned_responses.title",
			)
		);

		return $this->db
			->limit($datatable->length, $datatable->start)
			->get("canned_responses");
	}

	public function get_all_canned_responses()
	{
		return $this->db->get("canned_responses");
	}

	public function get_reply_files($replyid)
	{
		return $this->db->where("replyid", $replyid)->get("job_files");
	}

	public function get_users_from_groups($categoryid)
	{
		return $this->db
			->select("users.ID, users.username, users.avatar, users.online_timestamp,
				users.email, users.email_notification,
				user_groups.name")
			->join("users", "users.ID = user_group_users.userid")
			->join("user_groups", "user_groups.ID = user_group_users.groupid")
			->join("job_category_groups", "job_category_groups.groupid = user_groups.ID AND job_category_groups.catid = " . $categoryid)
			->group_by("users.ID")
			->get("user_group_users");
	}

	public function get_jobs_today($date)
	{
		$s = $this->db->select("COUNT(*) as num")->where("job_date", $date)
			->get("jobs");
		$r = $s->row();
		if(isset($r->num)) return $r->num;
		return 0;
	}

	public function get_jobs_for_month($month, $year)
	{
		$string = "-" . $month . "-" . $year;

		$s = $this->db->select("COUNT(*) as num")->like("job_date", $string)
			->get("jobs");
		$r = $s->row();
		if(isset($r->num)) return $r->num;
		return 0;
	}

	public function get_jobs_for_day($date)
	{

		$s = $this->db->select("COUNT(*) as num")->where("job_date", $date)
			->get("jobs");
		$r = $s->row();
		if(isset($r->num)) return $r->num;
		return 0;
	}

	public function get_jobs_for_day_closed($date)
	{

		$s = $this->db->select("COUNT(*) as num")->where("close_job_date", $date)
			->get("jobs");
		$r = $s->row();
		if(isset($r->num)) return $r->num;
		return 0;
	}

	public function get_jobs_for_month_closed($month, $year)
	{
		$string = "-" . $month . "-" . $year;

		$s = $this->db->select("COUNT(*) as num")->like("close_job_date", $string)
			->get("jobs");
		$r = $s->row();
		if(isset($r->num)) return $r->num;
		return 0;
	}

	public function add_history($data)
	{
		$this->db->insert("job_history", $data);
	}

	public function get_job_history_limit($jobid, $limit)
	{
		return $this->db
			->where("job_history.jobid", $jobid)
			->select("job_history.ID, job_history.message,
				job_history.userid, job_history.jobid,
				job_history.timestamp,
				users.avatar, users.username, users.online_timestamp")
			->join("users", "users.ID = job_history.userid", "left outer")
			->limit($limit)
			->order_by("job_history.ID", "DESC")
			->get("job_history");
	}

	public function get_job_history_count($jobid)
	{
		$s = $this->db->select("COUNT(*) as num")
			->where("job_history.jobid", $jobid)
			->get("job_history");
		$r = $s->row();
		if(isset($r->num)) return $r->num;
		return 0;
	}

	public function get_job_history($jobid, $datatable)
	{
		$datatable->db_order();

		$datatable->db_search(array(
			"users.username",
			"job_history.message"
			)
		);

		return $this->db
			->where("job_history.jobid", $jobid)
			->select("job_history.ID, job_history.message,
				job_history.userid, job_history.jobid,
				job_history.timestamp,
				users.avatar, users.username, users.online_timestamp")
			->join("users", "users.ID = job_history.userid", "left outer")
			->limit($datatable->length, $datatable->start)
			->order_by("job_history.ID", "DESC")
			->get("job_history");
	}

	public function get_custom_views($userid)
	{
		return $this->db->where("userid", $userid)->get("custom_views");
	}

	public function get_custom_view($id, $userid)
	{
		return $this->db->where("ID", $id)->where("userid", $userid)->get("custom_views");
	}

	public function add_custom_view($data)
	{
		$this->db->insert("custom_views", $data);
	}

	public function delete_custom_view($id)
	{
		$this->db->where("ID", $id)->delete("custom_views");
	}

	public function update_custom_view($id, $data)
	{
		$this->db->where("ID", $id)->update("custom_views", $data);
	}

	public function get_custom_views_total($userid)
	{
		$s = $this->db->where("userid", $userid)
			->select("COUNT(*) as num")->get("custom_views");
		$r = $s->row();
		if(isset($r->num)) return $r->num;
		return 0;
	}

	public function get_custom_views_dt($userid, $datatable)
	{
		$datatable->db_order();

		$datatable->db_search(array(
			"custom_views.name",
			)
		);

		return $this->db
			->where("custom_views.userid", $userid)
			->select("custom_views.ID, custom_views.name, custom_views.status,
				custom_views.categoryid, custom_views.order_by,
				custom_views.order_by_type,
				job_categories.name as cat_name")
			->join("job_categories", "job_categories.ID = custom_views.categoryid", "left outer")
			->limit($datatable->length, $datatable->start)
			->get("custom_views");
	}

	public function get_recent_jobs($limit)
	{
		return $this->db
			->limit($limit)
			->order_by("ID", "DESC")
			->get("jobs");
	}

	public function get_jobs_id($id)
	{
		return $this->db->where("ID", $id)->get("jobs");
	}

	public function update_all_job_replies($jobid, $data)
	{
		$this->db->where("jobid", $jobid)->update("job_replies", $data);
	}

	public function update_all_job_history($jobid, $data)
	{
		$this->db->where("jobid", $jobid)->update("job_history", $data);
	}

	public function update_all_job_files($jobid, $data)
	{
		$this->db->where("jobid", $jobid)->update("job_files", $data);
	}

	public function update_all_job_cf($jobid, $data)
	{
		$this->db->where("jobid", $jobid)
			->update("job_user_custom_fields", $data);
	}


}

?>
