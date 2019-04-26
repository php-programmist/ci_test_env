<?php
require_once 'JsonController.php';

class Comments extends JsonController
{
    protected $response_data;

    public function __construct()
    {
        parent::__construct();
        $this->load->model('comments_model');
    }
    
    
    public function create(int $news_id=0,string $text='')
    {
        if (is_cli()) {
            //php index.php comments create 1 "test text"
            $data = compact('news_id','text');
        }
        else{
            $data = $this->input->post();
        }
        if (empty($data)) {
            return $this->sendResponse('error', 'NO_POST_DATA_ERROR');
        }
        $this->form_validation->set_data($data);
        $this->form_validation->set_rules('news_id', 'News ID', 'trim|required|numeric');
        $this->form_validation->set_rules('text', 'Text', 'trim|required');
    
        if ($this->form_validation->run() === false) {
            return $this->sendResponse('error', implode(', ', $this->form_validation->error_array()));
        }
    
        if ( ! $this->user_id) {
            return $this->sendResponse('error', 'NO_AUTH_ERROR');
        }
        
        $comment_data = [
            'user_id' => $this->user_id,
            'news_id' => trim($data['news_id']),
            'text' => trim(strip_tags($data['text'])),
        ];
        
        if ( ! ($comment_model = Comments_model::create($comment_data))) {
            return $this->sendResponse('error', 'DIDNT_SAVE_COMMENT_ERROR');
        }
        $comment_data['id'] = $comment_model->get_id();
        $comment_data['likes'] = 0;
        $comment_data['liked'] = 0;
        $this->response_data->data = $comment_data;
        return $this->sendResponse('success');
    }
    
    public function remove(int $id=0)
    {
        if (is_cli()) {
            //php index.php comments remove 1
            $data = compact('id');
        }
        else{
            $data = $this->input->post();
        }
        if (empty($data)) {
            return $this->sendResponse('error', 'NO_POST_DATA_ERROR');
        }
        $this->form_validation->set_data($data);
        $this->form_validation->set_rules('id', 'Comment ID', 'trim|required|numeric');
        
    
        if ($this->form_validation->run() === false) {
            return $this->sendResponse('error', implode(', ', $this->form_validation->error_array()));
        }
    
        if ( ! $this->user_id) {
            return $this->sendResponse('error', 'NO_AUTH_ERROR');
        }
        $data['user_id'] = $this->user_id;
        if ( ! Comments_model::isUsersComment($data)) {
            return $this->sendResponse('error', 'NOT_AUTHOR_ERROR');
        }
    
        if ( !Comments_model::remove($data['id'])) {
            return $this->sendResponse('error', 'DIDNT_REMOVE_COMMENT_ERROR');
        }
        
        return $this->sendResponse('success');
    }
    
}
