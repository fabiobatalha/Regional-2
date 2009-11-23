<?php
/**
 * Database Connection Class
 *
 * @package     Plataforma de Serviços da BVS
 * @author      Fabio Batalha C. Santos (fabio.santos@bireme.org)
 * @author      Gustavo Fonseca (gustavo.fonseca@bireme.org)
 * @copyright   BIREME
 *
 */

/*
 * Edit this file in UTF-8 - Test String "áéíóú"
 */

/**
 * Custom exception Database Connection Class
 */
class DBClassException extends Exception{}

/**
 * Database Connection Class
 *
 * Handle the main activities to interact with the database.
 */
class DBClass{
    private $_conn = null;
    private $_host = DB_HOST;
    private $_user = DB_USERNAME;
    private $_password = DB_PASSWORD;
    private $_db = DB_DBNAME;

    /**
     * Create the connection with the database.
     */
    public function DBClass(){
        $this->_conn = mysql_connect($this->_host, $this->_user
            , $this->_password);
        if(!$this->_conn){
            throw new DBClassException('Err:connect:'.mysql_error());
        }
        if(!mysql_select_db($this->_db)){
            throw new DBClassException('Err:selectDB:'.mysql_error());
        }

    }

   /**
    * Execute the Insert queries
    *
    * @param  string $query
    * @return int
    */
    public function databaseExecInsert($query){
        /*
         * fixme: need to impove the exceptions returned by the SGBD and return
         * reporter: Fabio Batalha (fabio.santos@bireme.org)
         * date: 20090729
         */
        $result = mysql_query($query);
        if(!$result){
            throw new DBClassException('Err:ExecInsert:'.mysql_error());
        }
        return(mysql_insert_id());
    }

    /**
     * Execute the Update/Delete queries
     *
     * @param string $query
     * @return int
     */
    public function databaseExecUpdate($query){
        /*
         * fixme: need to impove the exceptions returned by the SGBD and return
         * reporter: Fabio Batalha (fabio.santos@bireme.org)
         * date: 20090729
         */
        $result = mysql_query($query);
        if(!$result){
            throw new DBClassException('Err:ExecUpdate:'.mysql_error());
        }
        return(mysql_affected_rows());
    }

    /**
     * Execute the Select queries
     * @param string $query
     * @return int
     */
    public function databaseQuery($query){
        /*
         * fixme: need to impove the exceptions returned by the SGBD and return
         * reporter: Fabio Batalha (fabio.santos@bireme.org)
         * date: 20090729
         */
        $result = mysql_query($query);
        if(!$result){
            throw new DBClassException('Err:databaseQuery:'.mysql_error());
        }
        $recordSet = array();
        while ($row = mysql_fetch_assoc($result)) {
            array_push($recordSet, $row);
        }
        return($recordSet);
    }
}
?>