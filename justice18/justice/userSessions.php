<?php

	$servername = "localhost";
	$username = "justice16dB";
	$password = "XpXYe9qY67FuVyjn";
	$dbname = "justice16dB";

	$con = mysqli_connect($servername, $username, $password, $dbname);

	$student = $_GET["studentid"];

	$sql = "SELECT `sessionid`, `sessionblock` FROM `registrations` WHERE `studentid` = '$student'";
	$result = mysqli_query($con, $sql);

	$sessions = array();

	if ($result) {
		while($row = mysqli_fetch_assoc($result)) {
			$sessionid = $row["sessionid"];
			$sessionblock = $row["sessionblock"];
			$sql2 = "SELECT `title`, `location` FROM `sessions` WHERE `id` = '$sessionid' AND `block` = '$sessionblock'";
			$result2 = mysqli_query($con, $sql2);
			$row2 = mysqli_fetch_array($result2);
			$sessiontitle = $row2[0];
			$sessionlocation = $row2[1];
			$sessions[$sessionblock]["id"] = $sessionid;
			$sessions[$sessionblock]["title"] = $sessiontitle;
			$sessions[$sessionblock]["location"] = $sessionlocation;
		}
	}

	echo json_encode($sessions);

	$con->close();
	
?>