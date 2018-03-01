<?php
class DbOperations
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
 
    //Function to check a user against database
    public function checkUser($email, $studentID)
    {
        $sql = $this->conn->prepare("SELECT DISTINCT COUNT(*) FROM users WHERE id = ? AND email = ?");
        $sql->bind_param("is", $studentID, $email);
        $result = $sql->execute();
		
		
		$value = mysqli_fetch_assoc($result);
			
		if ($value == TRUE) {
			$sql->close();
		
			if ($value["COUNT(*)"] == 1) {
				return TRUE;
			} else {
				return FALSE;
			}
		} else {
			return NULL;
		}
        
    }
	
	
	// Function to return list of justice summit sessions (for table view)
	public function getSessions($blockNumber)
	{
		$sql = $this->conn->prepare("SELECT * FROM sessions WHERE block = ?");
        $sql->bind_param("i", $blockNumber);
        $result = $sql->execute();
		
		$sql->close();
		
		if ($result == TRUE) {
			$sessionArray = array();
		
			while ($value = mysqli_fetch_assoc($result)) {
				$sessionArray[] = $value;
			}
			
			
			return $sessionArray;
		} else {
			return null;
		}
		
	}
	
	
	// get current selected session for a given student in a given block number
	public function getCurrentSelectedSession($blockNumber, $studentID) {
		$sql = $this->conn->prepare("SELECT DISTINCT * FROM registrations WHERE sessionblock = ? AND studentid = ? AND valid = 1");
        $sql->bind_param("ii", $blockNumber, $studentID);
        $result = $sql->execute();
		
		$sql->close();
		
		while($value = mysqli_fetch_assoc($result)) {
			return $value;
		}
		
		return null;
			
	}
	
	public function addToSession($blockNumber, $studentID, $sessionID) {
		if(is_null($currentSession = $this->getCurrentSelectedSession($blockNumber,$studentID))){
			// no previous session
			
			$sql = $this->conn->prepare("INSERT INTO registrations (sessionblock, sessionid, studentid) VALUES (?,?,?)");
			$sql->bind_param("iIi", $blockNumber, $sessionID, $studentID);


			if($sql->execute()) {
				$sql->close();
				return true;
			} else {
				$sql->close();
				return false;
			}
			
		} else {
			// previous session in place
			$this->removeFromSession($blockNumber, $studentID);
			
			// add to session again
			
			$this->addToSession($blockNumber, $studentID, $sessionID);
		}
	}
	
	public function removeFromSession($blockNumber, $studentID) {
		$sql = $this->conn->prepare("UPDATE registrations SET valid = 0 WHERE sessionblock = ? AND studentid = ?");
        $sql->bind_param("ii", $blockNumber, $studentID);
        $result = $sql->execute();
		
		$sql->close();
		
		if($result == TRUE) {
			return true;
		} else {
			return false;
		}
	}
 
}
?>