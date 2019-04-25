<?php


class Comments_model extends MY_Model
{
    const TABLE = 'comments';
    
    protected $id;
    protected $user_id;
    protected $news_id;
    protected $text;
    protected $created_at;
    
    
    
    function __construct($id = false)
    {
        parent::__construct();
        $this->class_table = self::TABLE;
        $this->set_id($id);
    }
    
    /**
     * @param array $data
     *
     * @return bool|Comments_model
     */
    public static function create(array $data)
    {
        $CI  =& get_instance();
        $res = $CI->s->from(self::TABLE)->insert($data)->execute();
        if ( ! $res) {
            return false;
        }
        
        return new self($CI->s->insert_id);
    }
    
    
    /**
     * @param int $id
     *
     * @return mixed
     */
    public static function remove(int $id)
    {
        $CI  =& get_instance();
        return $CI->s->from(self::TABLE)->where('id', $id)->delete()->execute();
    }
    
    /**
     * @param array $data
     *
     * @return bool
     */
    public static function isUsersComment(array $data):bool
    {
        $CI =& get_instance();
        $id = $CI->s->from(self::TABLE)
                    ->where('id', $data['id'])
                    ->where('user_id', $data['user_id'])
                    ->value('id');
    
        return (boolean)$id;
    }
    
}
