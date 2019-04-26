<?php
require_once 'JsonController.php';

class News extends JsonController
{
    protected $response_data;
    
    public function __construct()
    {
        parent::__construct();
        $this->load->model('news_model');
        $this->load->model('comments_model');
    }
    
    public function index()
    {
        $this->response_data->data->news        = News_model::getLatest('short_info');
        $this->response_data->data->patch_notes = '';
        $this->response($this->response_data);
    }
    
    public function view(int $id)
    {
        $data['article'] = News_model::getItemById($id, $this->user_id);
        if (empty($data['article'])) {
            show_404();
        }
        $data['article']['views']++;
        News_model::setViews($id, $data['article']['views']);
        $data['title']    = $data['article']['header'];
        $data['comments'] = Comments_model::getCommentsByNewsId($id, $this->user_id);
        $data['popular']  = News_model::getPopular();
        
        $this->load->view('base/header', $data);
        $this->load->view('news/view', $data);
        $this->load->view('base/footer');
    }
}
