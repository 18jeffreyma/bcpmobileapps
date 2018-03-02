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
    //Function to check a user against database
    public function checkUser($email, $studentID)
    {
		$cleanStudentID = $this->conn->real_escape_string($studentID);
		$cleanEmail = $this->conn->real_escape_string($email);
		
        $sql = "SELECT DISTINCT COUNT(*) FROM users WHERE id = ".$cleanStudentID." AND email = '" . $cleanEmail . "'";
		
			
		if ($result = $this->conn->query($sql)) {
			
			while ($row = $result->fetch_assoc()) {
		
				if ($row["COUNT(*)"] == 1) {
					return TRUE;
				} else {
					return FALSE;
				}
			}
		} else {
			return NULL;
		}
        
    }
	
	
	// Function to return list of justice summit sessions (for table view)
	public function getSessionIDs($blockNumber)
	{
		$cleanBlockNumber = $this->conn->real_escape_string($blockNumber);
		$sql = "SELECT * FROM sessions WHERE block = " . $blockNumber;
       
		if ($result = $this->conn->query($sql)) {
			$sessionArray = array();
		
			while ($row = $result->fetch_assoc()) {
				$sessionArray[] = $row['id'];
			}

			return $sessionArray;
		} else {
			return null;
		}
	}
	
	
	// get current selected session for a given student in a given block number
	public function getCurrentSelectedSession($blockNumber, $studentID) {
		$cleanBlockNumber = $this->conn->real_escape_string($blockNumber);
		$cleanStudentID = $this->conn->real_escape_string($studentID);
		
		$sql = "SELECT DISTINCT * FROM registrations WHERE sessionblock = " .$cleanBlockNumber. " AND studentid = " .$cleanStudentID. " AND valid = 1";
		
 
        
		
		
 		if ($result = $this->conn->query($sql)) {
			while ($row = $result->fetch_assoc()) {
				return $row;
			}
			
		}
		
		return null;
			
	}
	
	public function addToSession($blockNumber, $studentID, $sessionID) {
		if(is_null($currentSession = $this->getCurrentSelectedSession($blockNumber,$studentID))){
			// no previous session
			
			$cleanBlockNumber = $this->conn->real_escape_string($blockNumber);
			$cleanStudentID = $this->conn->real_escape_string($studentID);
			$cleanSessionID = $this->conn->real_escape_string($sessionID);
			
			$sql = "INSERT INTO registrations (sessionblock, sessionid, studentid) VALUES (".$cleanBlockNumber.", ".$cleanSessionID.", ".$cleanStudentID.")";
			

			if($result = $this->conn->query($sql)) {
				return true;
			} else {
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
		
		$cleanBlockNumber = $this->conn->real_escape_string($blockNumber);
		$cleanStudentID = $this->conn->real_escape_string($studentID);
		
		$sql = "UPDATE registrations SET valid = 0 WHERE sessionblock = ".$cleanBlockNumber." AND studentid = ".$cleanStudentID;
        
		if($this->conn->query($sql)) {
			return true;
		} else {
			return false;
		}
	}
 
}
?>