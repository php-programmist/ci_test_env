<?php

class Likes_model extends MY_Model
{
    const TABLE = 'likes';
    
    protected $id;
    protected $user_id;
    protected $entity_id;
    protected $entity_type;
    
    function __construct($id = false)
    {
        parent::__construct();
        $this->class_table = self::TABLE;
        $this->set_id($id);
    }
    
    /**
     * @param array $data
     *
     * @return int
     */
    public static function countLikes(array $data): int
    {
        $CI =& get_instance();
        $count = $CI->s->from(self::TABLE)
                    ->where('entity_id', $data['entity_id'])
                    ->where('entity_type', $data['entity_type'])
                    ->count();
        return (int)$count;
    }
    
    /**
     * @param array $data
     *
     * @return int
     */
    public static function findId(array $data): int
    {
        $CI =& get_instance();
        $id = $CI->s->from(self::TABLE)
                    ->where('user_id', $data['user_id'])
                    ->where('entity_id', $data['entity_id'])
                    ->where('entity_type', $data['entity_type'])
                    ->value('id');
                
        return (int)$id;
    }
    
    /**
     * @param array $data
     *
     * @return bool|Likes_model
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
        return $CI->s->from(self::TABLE)
                     ->where('id', $id)
                     ->delete()
                     ->execute();
    }
    
}
