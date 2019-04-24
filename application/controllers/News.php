<?php
require_once 'Likeable.php';
class News extends Likeable
{
    protected $response_data;

    public function __construct()
    {
        parent::__construct();

        $this->CI =& get_instance();
        $this->load->model('news_model');
    }
    
    public function index()
    {
        $this->response_data->data->news = News_model::getLatest('short_info');
        $this->response_data->data->patch_notes = '';
        $this->response($this->response_data);
    }
}
