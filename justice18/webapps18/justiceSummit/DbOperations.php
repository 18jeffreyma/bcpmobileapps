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
	
	
	public function getFirstName($email, $studentID)
    {
		$cleanStudentID = $this->conn->real_escape_string($studentID);
		$cleanEmail = $this->conn->real_escape_string($email);
		
        $sql = "SELECT DISTINCT firstname FROM users WHERE id = ".$cleanStudentID." AND email = '" . $cleanEmail . "'";
		
			
		if ($result = $this->conn->query($sql)) {
			
			while ($row = $result->fetch_assoc()) {
		
				return $row["firstname"];
			}
		} else {
			return NULL;
		}
        
    }
	
	public function getLastName($email, $studentID)
    {
		$cleanStudentID = $this->conn->real_escape_string($studentID);
		$cleanEmail = $this->conn->real_escape_string($email);
		
        $sql = "SELECT DISTINCT lastname FROM users WHERE id = ".$cleanStudentID." AND email = '" . $cleanEmail . "'";
		
			
		if ($result = $this->conn->query($sql)) {
			
			while ($row = $result->fetch_assoc()) {
		
				return $row["lastname"];
			}
		} else {
			return NULL;
		}
        
    }
	
	public function getGrade($email, $studentID)
    {
		$cleanStudentID = $this->conn->real_escape_string($studentID);
		$cleanEmail = $this->conn->real_escape_string($email);
		
        $sql = "SELECT DISTINCT grade FROM users WHERE id = ".$cleanStudentID." AND email = '" . $cleanEmail . "'";
		
			
		if ($result = $this->conn->query($sql)) {
			
			while ($row = $result->fetch_assoc()) {
		
				return $row["grade"];
			}
		} else {
			return NULL;
		}
        
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
	
	// Function to return list of justice summit sessions (for table view)
	public function getSessionIDs($blockNumber)
	{
		$cleanBlockNumber = $this->conn->real_escape_string($blockNumber);
		$sql = "SELECT * FROM sessions WHERE block = " . $cleanBlockNumber;
       
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
	
	public function getSelectedSession($studentID, $blockNumber)
	{
		$cleanBlockNumber = $this->conn->real_escape_string($blockNumber);
		$cleanStudentID = $this->conn->real_escape_string($studentID);
		
		$sql = "SELECT sessionid FROM registrations WHERE sessionblock = " . $cleanBlockNumber . " AND studentid = " . $cleanStudentID . " AND valid = 1";
       
		if ($result = ($this->conn->query($sql))) {
		
			if ($row = $result->fetch_assoc()) {
				return $row['sessionid'];
			} else {
				return -1;
			}

		} else {
			return null;
		}
	}
	
	public function getSessionInfo($sessionID, $blockNumber, $col) {
		
		if ($sessionID == -1 || is_null($sessionID) ) {
			return "None";
		}
		
		$cleanSessionID = $this->conn->real_escape_string($sessionID);
		
		$sql = "SELECT ".$col." FROM sessions WHERE id = " . $cleanSessionID . " AND block = ". $blockNumber;
		
		if ($result = $this->conn->query($sql)) {
		
			if ($row = $result->fetch_assoc()) {
				return $row[$col];
			} else {
				return "None";
			}

		} else {
			return null;
		}
		
	}
	
	
	
 
}
?>