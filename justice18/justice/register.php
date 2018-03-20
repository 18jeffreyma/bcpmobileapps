<?php

	$servername = "localhost";
	$username = "justice16dB";
	$password = "XpXYe9qY67FuVyjn";
	$dbname = "justice16dB";

	$con = mysqli_connect($servername, $username, $password, $dbname);

	function updateCount($sessionid, $sessionblock) {
		global $con;
		$sql = "SELECT COUNT(*) FROM `registrations` WHERE `sessionid` = '$sessionid' AND `sessionblock` = '$sessionblock'";
		$result = mysqli_query($con, $sql);
		$row3 = mysqli_fetch_array($result);
		$count = $row3[0];
		$sql = "UPDATE `sessions` SET `seatstaken` = '$count' WHERE `id` = '$sessionid' AND `block` = '$sessionblock'";
		mysqli_query($con, $sql);
	}

	$student = $_GET["studentid"];
	$session = explode("-", $_GET["sessionid"]);
	$sessionid = $session[0];
	$sessionblock = $session[1];
	$noReassignment = isset($_GET["noReassignment"]);
	$forceRegistration = isset($_GET["forceRegistration"]);

	$sql = "SELECT `capacity`, `seatstaken`, `title` FROM `sessions` WHERE `id` = '$sessionid' AND `block` = '$sessionblock'";

	$result = mysqli_query($con, $sql);
	$row = mysqli_fetch_assoc($result);
	$response = array();

	$changed = false;

	if ( ($row["seatstaken"] >= $row["capacity"]) && ($forceRegistration == false) ) {
		$response[0] = "full";
		$response[1] = "Session ". $row['title']. " in block $sessionblock is already full. Please select another session, and reload the page if the problem persists.";
	} else {

		$sql2 = "SELECT * FROM `registrations` WHERE `studentid` = '$student' AND `sessionblock` = '$sessionblock'";
		$result2 = mysqli_query($con, $sql2);
		
		if (mysqli_num_rows($result2) > 0) {

			$changed = true;

			if ($noReassignment == true) {
				$response[0] = "failure";
				$response[1] = "Did not add registration because user already has a registration in this block.";
				echo json_encode($response);
				exit();
			}

			while($row2 = mysqli_fetch_assoc($result2)) {
				$thissessionid = $row2["sessionid"];
				$sql2 = "DELETE FROM `registrations` WHERE `studentid` = '$student' AND `sessionid` = '$thissessionid' AND `sessionblock` = '$sessionblock'";
				mysqli_query($con, $sql2);
				updateCount($row2["sessionid"], $sessionblock);
			}
		}

		$sql = "INSERT INTO registrations (studentid, sessionid, sessionblock)
				VALUES ($student, $sessionid, $sessionblock)
				ON DUPLICATE KEY UPDATE
					studentid = VALUES(studentid),
					sessionid = VALUES(sessionid),
					sessionblock = VALUES(sessionblock)";

		if (mysqli_query($con, $sql) === TRUE) {
			$response[0] = "success";
			if ($changed == true) {
				$response[1] = "You have successfully changed your registration for Block $sessionblock to: ". $row['title'] . ".";					
			} else {
				$response[1] = "You have successfully registered for the following session for Block $sessionblock: ". $row['title'] . ".";
			}
		} else {
			$response[0] = "failure"; 
			$response[1] = "Failure adding registration. Please use the help tab to report this issue.";
		}

		updateCount($sessionid, $sessionblock);
	}

	echo json_encode($response);

	$con->close();
	
?>