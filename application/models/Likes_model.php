<?php

class Likes_model extends MY_Model
{
    const TABLE = 'likes';
    
    protected $id;
    protected $entity_id;
    protected $entity_type;
    protected $counter;
    
    function __construct($id = false)
    {
        parent::__construct();
        $this->class_table = self::TABLE;
        $this->set_id($id);
    }
    
    /**
     * @param int $entity_id
     * @param     $entity_type
     * @param int $change
     *
     * @return int
     * @throws Exception
     */
    public static function changeCounter(int $entity_id, $entity_type, int $change)
    {
        self::validate(compact('entity_id', 'entity_type', 'change'));
        
        $id      = self::getId($entity_id, $entity_type);
        $counter = self::getCounterById($id) + $change;
        $CI      =& get_instance();
        $CI->s->from(self::TABLE)
              ->where('id', $id)
              ->update(['counter' => $counter])
              ->execute();
        
        return $counter;
    }
    
    /**
     * @param $params
     *
     * @return bool
     * @throws Exception
     */
    protected static function validate($params)
    {
        if ($params['entity_id'] < 1) {
            throw new Exception('Wrong entity_id');
        }
        if (empty($params['entity_type']) || ! in_array($params['entity_type'], ['news', 'comments'])) {
            throw new Exception('Wrong entity_type');
        }
        if (empty($params['change']) || ! in_array($params['change'], ['1', '-1'])) {
            throw new Exception('Wrong change');
        }
        
        return true;
    }
    
    /**
     * @param $entity_id
     * @param $entity_type
     *
     * @return bool|integer
     * @throws Exception
     */
    protected static function getId($entity_id, $entity_type)
    {
        $CI =& get_instance();
        $id = $CI->s->from(self::TABLE)
                    ->where('entity_id', $entity_id)
                    ->where('entity_type', $entity_type)
                    ->value('id');
        if ( ! $id) {
            $id = self::create(compact('entity_id', 'entity_type'));
        }
        if ( ! $id) {
            throw new Exception('Error save like record');
        }
        
        return $id;
    }
    
    /**
     * @param $id
     *
     * @return int
     */
    protected static function getCounterById($id)
    {
        $CI      =& get_instance();
        $counter = $CI->s->from(self::TABLE)
                         ->where('id', $id)
                         ->value('counter');
        
        return (int)$counter;
    }
    
    /**
     * @param $data
     *
     * @return bool
     */
    protected static function create($data)
    {
        $CI  =& get_instance();
        $res = $CI->s->from(self::TABLE)->insert($data)->execute();
        if ( ! $res) {
            return false;
        }
        
        return $CI->s->insert_id;
    }
    
    /**
     * @param $entity_id
     * @param $entity_type
     *
     * @return mixed
     */
    public static function remove($entity_id, $entity_type)
    {
        $CI =& get_instance();
        
        return $CI->s->from(self::TABLE)
                     ->where('entity_id', $entity_id)
                     ->where('entity_type', $entity_type)
                     ->delete()
                     ->execute();
    }
    
}
