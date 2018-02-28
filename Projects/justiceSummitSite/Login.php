<?php
	class DbOperation
{
    private $conn;
 
    //Constructor
    function __construct()
    {
        require_once dirname(__FILE__) . '/Config.php';
        require_once dirname(__FILE__) . '/DbConnect.php';
        // opening db connection
        $db = new DbConnect();
        $this->conn = $db->connect();
    }
 
    //Function to check a user
    public function checkUser($email, $studentID)
    {
        $sql = $this->conn->prepare("SELECT DISTINCT COUNT(*) FROM users WHERE id = ? AND email = ?");
        $sql->bind_param("is", $studentID, $email);
        $result = $sql->execute();
		
		// get mysql result
		
		$value = MySQLi_Result($result)
			
		
        $stmt->close();
        if ($result) {
            return true;
        } else {
            return false;
        }
    }
 
}
?>