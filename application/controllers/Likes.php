<?php
require_once 'JsonController.php';

class Likes extends JsonController
{
    protected $response_data;
    
    public function __construct()
    {
        parent::__construct();
        $this->load->model('likes_model');
    }
    
    public function like(int $entity_id = 0,string $entity_type='news')
    {
        if (is_cli()) {
            //php index.php likes like 1 news
            $data = compact('entity_id','entity_type');
        }
        else{
            $data = $this->input->post();
        }
        
        if (empty($data)) {
            return $this->sendResponse('error', 'NO_POST_DATA_ERROR');
        }
        $this->form_validation->set_data($data);
        $this->form_validation->set_rules('entity_id', 'Entity ID', 'trim|required|numeric');
        $this->form_validation->set_rules('entity_type', 'Entity Type', 'trim|required|in_list[news,comments]');
        
        if ($this->form_validation->run() === false) {
            return $this->sendResponse('error', implode(', ', $this->form_validation->error_array()));
        }
        
        if ( ! $this->user_id) {
            return $this->sendResponse('error', 'NO_AUTH_ERROR');
        }
        $data['user_id'] = $this->user_id;
        if (Likes_model::findId($data)) {
            return $this->sendResponse('error', 'DUPLICATE_LIKE_ERROR');
        }
        $like_data = [
            'user_id' => $this->user_id,
            'entity_id' => trim($data['entity_id']),
            'entity_type' => trim($data['entity_type']),
        ];
        if ( ! (Likes_model::create($like_data))) {
            return $this->sendResponse('error', 'DIDNT_SAVE_LIKE_ERROR');
        }
        $this->response_data->data->likes = Likes_model::countLikes($data);
        return $this->sendResponse('success');
    }
    
    public function unlike(int $entity_id = 0,string $entity_type='news')
    {
        if (is_cli()) {
            //php index.php likes unlike 1 news
            $data = compact('entity_id','entity_type');
        }
        else{
            $data = $this->input->post();
        }
        $this->form_validation->set_data($data);
        $this->form_validation->set_rules('entity_id', 'Entity ID', 'trim|required|numeric');
        $this->form_validation->set_rules('entity_type', 'Entity Type', 'trim|required|in_list[news,comments]');
    
        if ($this->form_validation->run() === false) {
            return $this->sendResponse('error', $this->form_validation->error_string());
        }
        if ( ! $this->user_id) {
            return $this->sendResponse('error', 'NO_AUTH_ERROR');
        }
        $data['user_id'] = $this->user_id;
        if (!($like_id = Likes_model::findId($data))) {
            return $this->sendResponse('error', 'LIKE_NOT_EXISTS_ERROR');
        }
        if (!Likes_model::remove($like_id)) {
            return $this->sendResponse('error', 'DIDNT_REMOVE_LIKE_ERROR');
        }
        
        $this->response_data->data->likes = Likes_model::countLikes($data);
        return $this->sendResponse('success');
    }
    
}
