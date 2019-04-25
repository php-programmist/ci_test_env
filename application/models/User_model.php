<?php

class User_model
{
    protected static $id = 1;
    protected static $username = 'tester';
    
    public static function getId(){
        return self::$id;
    }
    public static function getUsername(){
        return self::$username;
    }
}