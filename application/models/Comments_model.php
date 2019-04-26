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
        $CI =& get_instance();
        
        return $CI->s->from(self::TABLE)->where('id', $id)->delete()->execute();
    }
    
    /**
     * @param array $data
     *
     * @return bool
     */
    public static function isUsersComment(array $data): bool
    {
        $CI =& get_instance();
        $id = $CI->s->from(self::TABLE)
                    ->where('id', $data['id'])
                    ->where('user_id', $data['user_id'])
                    ->value('id');
        
        return (boolean)$id;
    }
    
    /**
     * @param int $news_id
     * @param int $user_id
     *
     * @return mixed
     */
    public static function getCommentsByNewsId(int $news_id, int $user_id)
    {
        $CI =& get_instance();
        
        return $CI->s->from(self::TABLE . ' as c')
                   ->leftJoin('likes as l', ['l.entity_id' => 'c.id', 'l.entity_type' => '"comments"'])
                   ->leftJoin('likes as l2',
                       ['l2.entity_id' => 'c.id', 'l2.entity_type' => '"comments"', 'l2.user_id' => $user_id])
                   ->where('c.news_id', $news_id)
                   ->groupBy('c.id')
                   ->sortDesc('c.created_at')
                   ->select([
                       'c.*',
                       'COUNT(l.id) as likes',
                       'COUNT(l2.id) as liked',
                   ])
                   ->many();
        
    }
    
}
