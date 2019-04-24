<?php


class Comments_model extends MY_Model
{
    const TABLE = 'comments';
    
    protected $id;
    protected $news_id;
    protected $name;
    protected $text;
    protected $created_at;
    
    
    
    function __construct($id = false)
    {
        parent::__construct();
        $this->class_table = self::TABLE;
        $this->set_id($id);
    }
    
    public static function add($data)
    {
        $CI =& get_instance();
        $res = $CI->s->from(self::TABLE)->insert($data)->execute();
        if ( ! $res) {
            throw new Exception('Error during comment saving');
        }
    
        return $CI->s->insert_id;
    }
    
    /**
     * @param $params
     *
     * @return bool
     * @throws Exception
     */
    public static function validate($params)
    {
        if ( $params['news_id'] < 1) {
            throw new Exception('Wrong news_id');
        }
        if ( empty($params['name'])) {
            throw new Exception('Empty name');
        }
        if ( empty($params['text'])) {
            throw new Exception('Empty text');
        }
        return true;
    }
    
    /**
     * @param $id
     *
     * @return mixed
     */
    public static function remove($id)
    {
        $CI  =& get_instance();
        return $CI->s->from(self::TABLE)->where('id', $id)->delete()->execute();
    }
    
}
