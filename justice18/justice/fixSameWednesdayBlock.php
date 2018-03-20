<?php

	$servername = "localhost";
	$username = "justice16dB";
	$password = "XpXYe9qY67FuVyjn";
	$dbname = "justice16dB";

	$con = mysqli_connect($servername, $username, $password, $dbname);

	$sql = "SELECT * FROM `users`";
	$results = mysqli_query($con, $sql);
	$users = array();
	while ($result = mysqli_fetch_assoc($results)) {
		$users[] = $result;
	}

	foreach ($users as $user) {
		$id = $user["id"];
		$schedule = json_decode(file_get_contents("http://times.bcp.org/justice/userSessions.php?studentid=$id"), true);
		$session3 = $schedule[3]["id"];
		$session4 = $schedule[4]["id"];

		if (($session3 == $session4) && ($session4 != "2016000")) {
			echo($id . "<br />");
			echo("3: $session3" . "<br />");
			echo("4: $session4" . "<br />");
			echo("<br />");
		}

	}

	/*

	$twentyeight = 1;
	$thirtyone = 1;
	$sixtyfour = 3;
	$fiftytwo = 3;

	$x28 = array();
	$x31 = array();
	$x64 = array();
	$x52 = array();
	//$xspecial = array();

	for ($x = 0; $x < 100; $x++) {
		$x28[] = "2016031-1";
		$x28[] = "2016031-2";
	}

	for ($x = 0; $x < 100; $x++) {
		$x31[] = "2016028-1";
		$x31[] = "2016028-2";
	}

	for ($x = 0; $x < 100; $x++) {
		$x64[] = "2016052-3";
		$x64[] = "2016052-4";
	}

	for ($x = 0; $x < 100; $x++) {
		$x52[] = "2016064-3";
		$x52[] = "2016064-4";
	}	

	// for ($x = 0; $x < 23; $x++) {
	// 	$xspecial[] = "2016088-3";
	// 	$xspecial[] = "2016088-4";
	// }		

	foreach ($affected_students as $user) {

		$schedule = json_decode(file_get_contents("http://times.bcp.org/justice/userSessions.php?studentid=$user"), true);

		$session1 = $schedule[1]["id"];
		$session2 = $schedule[2]["id"];
		$session3 = $schedule[3]["id"];
		$session4 = $schedule[4]["id"];

		echo($session1 . "<br />");
		echo($session2 . "<br />");
		echo($session3 . "<br />");
		echo($session4 . "<br />");

		if (($session1 == $session2) && ($session2 == "2016028")) {
			$session = array_pop($x28);
			echo($session . "<br /><br />");
			$attempt = file_get_contents("http://times.bcp.org/justice/register.php?studentid=$user&sessionid=$session");
			$response = json_decode($attempt);
			if ($response[0] = "success") {
				echo("User $user successfully registered for $session: " . $response[1]) . "<br />";
			} else {
				die("Error. Tried user $user. Response was: " . $response[0] . " - " . $response[1]);
			}		
		} else if (($session1 == $session2) && ($session2 == "2016031")) {
			$session = array_pop($x31);
			echo($session . "<br /><br />");
			$attempt = file_get_contents("http://times.bcp.org/justice/register.php?studentid=$user&sessionid=$session");
			$response = json_decode($attempt);
			if ($response[0] = "success") {
				echo("User $user successfully registered for $session: " . $response[1]) . "<br />";
			} else {
				die("Error. Tried user $user. Response was: " . $response[0] . " - " . $response[1]);
			}		
		}


		if (($session3 == $session4) && ($session4 == "2016064")) {
			// if (empty($xspecial)) {
				$session = array_pop($x64);
			// } else {
				// $session = array_pop($xspecial);
			// }
			echo($session . "<br /><br />");
			$attempt = file_get_contents("http://times.bcp.org/justice/register.php?studentid=$user&sessionid=$session");
			$response = json_decode($attempt);
			if ($response[0] = "success") {
				echo("User $user successfully registered for $session: " . $response[1]) . "<br />";
			} else {
				die("Error. Tried user $user. Response was: " . $response[0] . " - " . $response[1]);
			}		
		} else if (($session3 == $session4) && ($session4 == "2016052")) {
			// if (empty($xspecial)) {
				$session = array_pop($x52);
			// } else {
				// $session = array_pop($xspecial);
			// }
			echo($session . "<br /><br />");
			$attempt = file_get_contents("http://times.bcp.org/justice/register.php?studentid=$user&sessionid=$session");
			$response = json_decode($attempt);
			if ($response[0] = "success") {
				echo("User $user successfully registered for $session: " . $response[1]) . "<br />";
			} else {
				die("Error. Tried user $user. Response was: " . $response[0] . " - " . $response[1]);
			}	
		}

		echo("<br /><br />");

	}

	*/
?>