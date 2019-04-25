<?php
require_once 'JsonController.php';

class News extends JsonController
{
    protected $response_data;

    public function __construct()
    {
        parent::__construct();
        $this->load->model('news_model');
    }
    
    public function index()
    {
        $this->response_data->data->news = News_model::getLatest('short_info');
        $this->response_data->data->patch_notes = '';
        $this->response($this->response_data);
    }
}
