<?php

class Likeable extends MY_Controller
{
    protected $response_data;

    public function __construct()
    {
        parent::__construct();

        $this->CI =& get_instance();
        $this->load->model('likes_model');

        $this->response_data = new stdClass();
        $this->response_data->status = 'success';
        $this->response_data->error_message = '';
        $this->response_data->data = new stdClass();

        if (ENVIRONMENT === 'production')
        {
            die('Access denied!');
        }
    }
    
    public function index()
    {
        $this->response($this->response_data);
    }
    
    public function like(int $entity_id)
    {
        $entity_type = lcfirst(get_class($this));
        try{
            $this->response_data->data->counter = Likes_model::changeCounter($entity_id,$entity_type,1);
        } catch (Exception $e){
            $this->response_data->status = 'error';
            $this->response_data->error_message = $e->getMessage();
        }
        $this->response($this->response_data);
    }
    
    public function unlike(int $entity_id)
    {
        $entity_type = lcfirst(get_class($this));
        try{
            $this->response_data->data->counter = Likes_model::changeCounter($entity_id,$entity_type,-1);
        } catch (Exception $e){
            $this->response_data->status = 'error';
            $this->response_data->error_message = $e->getMessage();
        }
        $this->response($this->response_data);
    }

    
}
