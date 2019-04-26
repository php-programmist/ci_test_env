<?php

/**
 * Created by PhpStorm.
 * User: mr.incognito
 * Date: 10.11.2018
 * Time: 10:10
 */
class News_model extends MY_Model
{
    const NEWS_TABLE = APPLICATION_NEWS;
    const PAGE_LIMIT = 5;
    const LATEST_LIMIT = 3;
    const POPULAR_LIMIT = 3;
    const DESC_LIMIT = 300;
    
    protected $id;
    protected $header;
    protected $short_description;
    protected $text;
    protected $img;
    protected $tags;
    protected $time_created;
    protected $time_updated;
    
    protected $views;
    
    protected $comments;
    protected $likes;
    
    function __construct($id = false)
    {
        parent::__construct();
        $this->class_table = self::NEWS_TABLE;
        $this->set_id($id);
    }
    
    /**
     * @return string
     */
    public function get_header()
    {
        return $this->header;
    }
    
    /**
     * @param mixed $header
     */
    public function set_header($header)
    {
        $this->header = $header;
        
        return $this->_save('header', $header);
    }
    
    /**
     * @return string
     */
    public function get_short_description()
    {
        if (!self::DESC_LIMIT) {
            return $this->short_description;
        }
        $ci = get_instance();
        $ci->load->helper('text');
        return character_limiter($this->short_description,self::DESC_LIMIT);
    }
    
    /**
     * @param mixed $description
     */
    public function set_short_description($description)
    {
        $this->short_description = $description;
        
        return $this->_save('short_description', $description);
    }
    
    /**
     * @return string
     */
    public function get_full_text()
    {
        return $this->text;
    }
    
    /**
     * @return mixed
     */
    public function get_image()
    {
        return $this->img;
    }
    
    /**
     * @param mixed $image
     */
    public function set_image($image)
    {
        $this->img = $image;
        
        return $this->_save('image', $image);
    }
    
    /**
     * @return string
     */
    public function get_tags()
    {
        return $this->tags;
    }
    
    /**
     * @param mixed $tags
     */
    public function set_tags($tags)
    {
        $this->tags = $tags;
        
        return $this->_save('tags', $tags);
    }
    
    /**
     * @return mixed
     */
    public function get_time_created()
    {
        return $this->time_created;
    }
    
    /**
     * @param mixed $time_created
     */
    public function set_time_created($time_created)
    {
        $this->time_created = $time_created;
        
        return $this->_save('time_created', $time_created);
    }
    
    /**
     * @return int
     */
    public function get_time_updated()
    {
        return strtotime($this->time_updated);
    }
    
    /**
     * @param mixed $time_updated
     */
    public function set_time_updated($time_updated)
    {
        $this->time_updated = $time_updated;
        
        return $this->_save('time_updated', $time_updated);
    }
    
    /**
     * @return News_like_model
     */
    public function get_likes()
    {
        return $this->likes;
    }
    
    /**
     * @return News_comments_model[]
     */
    public function get_comments()
    {
        return $this->comments;
    }
    
    /**
     * @param int         $page
     * @param bool|string $preparation
     *
     * @return array
     */
    public static function get_all($preparation = false)
    {
        
        $CI =& get_instance();
        
        $_data = $CI->s->from(self::NEWS_TABLE)->many();
        
        $news_list = [];
        foreach ($_data as $_item) {
            $news_list[] = (new self())->load_data($_item);
        }
        
        if ($preparation === false) {
            return $news_list;
        }
        
        return self::preparation($news_list, $preparation);
    }
    
    public static function getLatest($preparation = false)
    {
        $CI =& get_instance();
        
        $_data = $CI->s->from(self::NEWS_TABLE)
                       ->sortDesc('id')
                       ->limit(self::LATEST_LIMIT)
                       ->select([
                           'id',
                           'header',
                           'short_description',
                           'img',
                           'time_updated',
                       ])->many();
        $news_list = [];
        foreach ($_data as $_item) {
            $news_list[] = (new self())->load_data($_item);
        }
        if ($preparation === false) {
            return $news_list;
        }
        return self::preparation($news_list, $preparation);
    }
    
    public static function preparation($data, $preparation)
    {
        
        switch ($preparation) {
            case 'short_info':
                return self::_preparation_short_info($data);
            default:
                throw new Exception('undefined preparation type');
        }
    }
    
    /**
     * @param News_model[] $data
     *
     * @return array
     */
    private static function _preparation_short_info($data)
    {
        $res = [];
        foreach ($data as $item) {
            $_info              = new stdClass();
            $_info->id          = (int)$item->get_id();
            $_info->header      = $item->get_header();
            $_info->description = $item->get_short_description();
            $_info->img         = $item->get_image();
            $_info->time        = $item->get_time_updated();
            $res[]              = $_info;
        }
        
        return $res;
    }
    
    public static function create($data)
    {
        
        $CI  =& get_instance();
        $res = $CI->s->from(self::NEWS_TABLE)->insert($data)->execute();
        if ( ! $res) {
            return false;
        }
        
        return new self($CI->s->insert_id);
    }
    
    /**
     * @param int $id
     * @param int $user_id
     *
     * @return mixed
     */
    public static function getItemById(int $id,int $user_id)
    {
        $CI =& get_instance();
    
        $item = $CI->s->from(self::NEWS_TABLE.' as n')
                       ->leftJoin('likes as l', ['l.entity_id' => 'n.id','l.entity_type'=>'"news"'])
                       ->leftJoin('likes as l2', ['l2.entity_id' => 'n.id','l2.entity_type'=>'"news"','l2.user_id'=>$user_id])
                       ->where('n.id',$id)
                       ->groupBy('n.id')
                       ->select([
                           'n.id',
                           'header',
                           'text',
                           'views',
                           'img',
                           'n.time_updated',
                           'COUNT(l.id) as likes',
                           'COUNT(l2.id) as liked',
                       ])->one();
        
        return $item;
    }
    
    /**
     * @return mixed
     */
    public static function getPopular()
    {
        $CI =& get_instance();
    
        $items= $CI->s->from(self::NEWS_TABLE.' as n')
                      ->leftJoin('likes as l', ['l.entity_id' => 'n.id','l.entity_type'=>'"news"'])
                      ->groupBy('n.id')
                      ->sortDesc(['likes','views'])
                      ->limit(self::POPULAR_LIMIT)
                      ->select([
                          'n.id',
                          'header',
                          'views',
                          'COUNT(l.id) as likes',
                      ])->many();
        return $items;
    }
    
    /**
     * @param int $id
     * @param int $views
     *
     * @return mixed
     */
    public static function setViews(int $id,int $views)
    {
        $CI =& get_instance();
        return $CI->s->from(self::NEWS_TABLE)
            ->where(['id'=>$id])
            ->update(['views'=>$views])
            ->execute();
    }
    
}
