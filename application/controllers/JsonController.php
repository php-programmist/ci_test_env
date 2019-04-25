<?php

class JsonController extends MY_Controller
{
    protected $response_data;
    protected $user_id;
    
    public function __construct()
    {
        parent::__construct();
        
        $this->CI =& get_instance();
        $this->load->model('user_model');
        $this->user_id = User_model::getId();
        $this->load->library('form_validation');
        
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
    
    /**
     * @param string $status
     * @param string $message
     *
     * @return bool
     */
    protected function sendResponse($status, $message='')
    {
        $this->response_data->status = $status;
        $this->response_data->error_message = $message;
        return $this->response($this->response_data);
    }
}