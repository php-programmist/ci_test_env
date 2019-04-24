<?php
require_once 'Likeable.php';
class Comments extends Likeable
{
    protected $response_data;

    public function __construct()
    {
        parent::__construct();
        $this->load->model('comments_model');
    }
    
    /**
     * @param int $news_id - ID of commented news
     */
    public function add(int $news_id)
    {
        $name = trim(strip_tags($this->input->post_get('name')));
        $text = trim(strip_tags($this->input->post_get('text')));
        $data = compact('news_id','name','text');
        try{
            Comments_model::validate($data);
            $this->response_data->data->id = Comments_model::add($data);
        } catch (Exception $e){
            $this->response_data->status = 'error';
            $this->response_data->error_message = $e->getMessage();
        }
        $this->response($this->response_data);
    }
    
    /**
     * @param int $id - ID of comment
     */
    public function remove(int $id)
    {
        try{
            Comments_model::remove($id);
            Likes_model::remove($id,get_class($this));
        } catch (Exception $e){
            $this->response_data->status = 'error';
            $this->response_data->error_message = $e->getMessage();
        }
        $this->response($this->response_data);
    }
    
}
