<?php

	$data = "217190,217283,217009,216442,216416,217203,216133,218104,219395,216019,216135,216026,219189,217347,217023,218113,216109,218073,219305,219102,218083,219425,219204,217166,218087,217018,218436,217999,217215,218084,216033,218152,216251,219167,218267,217073,217076,219104,219138,216004,219057,218426,216343,218356,219267,217152,217365,219044,219221,217436,218079,217266,217195,218127,216230,216164,219308,218308,218050,217198,217341,217053,218140,216262,219100,219339,216084,217339,216239,217177,218363,219144,218030,218169,217426,219092,217052,218143,219021,218431,218136,217191,216105,219359,219224,218254,217288,219080,216373,219082,217128,216291,218150,218435,216273,219087,217439,216401,219291,218338,216249,217211,217443,219206,216228,218017,219148,219028,216234,218317,219193,217196,217172,218002,217384,216317,219282,216120,217147,216037,217003,217237,219289,217025,216147,219120,217011,217220,216123,216252,217263,218122,217194,218375,219421,217318,219068,218037,218153,218019,218346,219088,218306,216429,218184,217444,219072,218999,218301,218387,219270,219059,217226,216112,216080,218052,218429,216214,219099,217116,218305,218012,219365,219063,217134,218214,218324,216024,218406,218360,218433,218177,219292,217066,217302,219074,219430,219179,219157,219307,217410,219313,219418,219075,217020,219212,218257,218117,217255,217417,219180,219151,217109,219004,217363,219210,217252,216018,219360,219026,217373,219335,216310,216233";

	$affected_students = explode(",", $data);

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
?>