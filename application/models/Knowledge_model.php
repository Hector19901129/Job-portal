<?php

class Knowledge_Model extends CI_Model 
{

	public function get_categories() 
	{
		return $this->db->get("knowledge_categories");
	}

	public function get_categories_no_parents() 
	{
		return $this->db->where("parent_category", 0)->get("knowledge_categories");
	}

	public function get_subcats($catid) 
	{
		return $this->db->where("parent_category", $catid)->get("knowledge_categories");
	}

	public function get_category($id) 
	{
		return $this->db->where("ID", $id)->get("knowledge_categories");
	}

	public function add_category($data) 
	{
		$this->db->insert("knowledge_categories", $data);
		return $this->db->insert_id();
	}

	public function delete_category($id) 
	{
		$this->db->where("ID", $id)->delete("knowledge_categories");
	}

	public function update_category($id, $data) 
	{
		$this->db->where("ID", $id)->update("knowledge_categories", $data);
	}

	public function get_categories_total() 
	{
		$s = $this->db->select("COUNT(*) as num")->get("knowledge_categories");
		$r = $s->row();
		if(isset($r->num)) return $r->num;
		return 0;
	}

	public function get_categories_dt($datatable) 
	{
		$datatable->db_order();

		$datatable->db_search(array(
			"knowledge_categories.name"
			)
		);

		return $this->db
			->limit($datatable->length, $datatable->start)
			->get("knowledge_categories");

	}

	public function add_article($data) 
	{
		$this->db->insert("knowledge_articles", $data);
	}

	public function get_article($id) 
	{
		return $this->db->where("ID", $id)->get("knowledge_articles");
	}

	public function delete_article($id) 
	{
		$this->db->where("ID", $id)->delete("knowledge_articles");
	}

	public function update_article($id, $data) 
	{
		$this->db->where("ID", $id)->update("knowledge_articles", $data);
	}

	public function get_articles_total() 
	{
		$s = $this->db->select("COUNT(*) as num")->get("knowledge_articles");
		$r = $s->row();
		if(isset($r->num)) return $r->num;
		return 0;
	}

	public function get_articles($datatable) 
	{
		$datatable->db_order();

		$datatable->db_search(array(
			"knowledge_articles.title"
			)
		);

		return $this->db->select("knowledge_articles.ID, knowledge_articles.title,
			knowledge_articles.last_updated_timestamp,
			users.ID as userid, users.username, users.avatar, users.online_timestamp,
			knowledge_categories.name as catname")
			->join("knowledge_categories", "knowledge_categories.ID = knowledge_articles.catid")
			->join("users", "users.ID = knowledge_articles.userid")
			->limit($datatable->length, $datatable->start)
			->get("knowledge_articles");
	}

	public function get_recent_articles($limit) 
	{
		return $this->db->select("knowledge_articles.ID, knowledge_articles.title,
			knowledge_articles.last_updated_timestamp, knowledge_articles.body,
			users.ID as userid, users.username, users.avatar, users.online_timestamp,
			knowledge_categories.name as catname, knowledge_categories.image")
			->join("knowledge_categories", "knowledge_categories.ID = knowledge_articles.catid")
			->join("users", "users.ID = knowledge_articles.userid")
			->order_by("knowledge_articles.ID", "DESC")
			->limit($limit)
			->get("knowledge_articles");

	}

	public function get_articles_title($title) 
	{	
		$this->db->like("knowledge_articles.title", $title);
		return $this->db->select("knowledge_articles.ID, knowledge_articles.title,
			knowledge_articles.last_updated_timestamp, knowledge_articles.body,
			users.ID as userid, users.username, users.avatar, users.online_timestamp,
			knowledge_categories.name as catname, knowledge_categories.image")
			->join("knowledge_categories", "knowledge_categories.ID = knowledge_articles.catid")
			->join("users", "users.ID = knowledge_articles.userid")
			->order_by("knowledge_articles.ID", "DESC")
			->limit(5)
			->get("knowledge_articles");
	}

	public function get_articles_cat_total($catid) 
	{
		$s = $this->db->where("catid", $catid)
			->select("COUNT(*) as num")->get("knowledge_articles");
		$r = $s->row();
		if(isset($r->num)) return $r->num;
		return 0;
	}

	public function get_articles_cat($catid, $datatable) 
	{
		$datatable->db_order();

		$datatable->db_search(array(
			"knowledge_articles.title"
			)
		);

		return $this->db
			->where("knowledge_articles.catid", $catid)
			->select("knowledge_articles.ID, knowledge_articles.title,
				knowledge_articles.body,
			knowledge_articles.last_updated_timestamp,
			users.ID as userid, users.username, users.avatar, users.online_timestamp,
			knowledge_categories.name as catname")
			->join("knowledge_categories", "knowledge_categories.ID = knowledge_articles.catid")
			->join("users", "users.ID = knowledge_articles.userid")
			->limit($datatable->length, $datatable->start)
			->get("knowledge_articles");
	}

	public function get_articles_search($search) 
	{
		$this->db->like("knowledge_articles.title", $search);
		$this->db->or_like("knowledge_articles.body", $search);
		return $this->db
			->select("knowledge_articles.ID, knowledge_articles.title,
				knowledge_articles.body,
			knowledge_articles.last_updated_timestamp,
			users.ID as userid, users.username, users.avatar, users.online_timestamp,
			knowledge_categories.name as catname")
			->join("knowledge_categories", "knowledge_categories.ID = knowledge_articles.catid")
			->join("users", "users.ID = knowledge_articles.userid")
			->limit(20)
			->get("knowledge_articles");
	}

}

?>