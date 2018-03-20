<?php

	$servername = "localhost";
	$username = "justice16dB";
	$password = "XpXYe9qY67FuVyjn";
	$dbname = "justice16dB";

	$con = mysqli_connect($servername, $username, $password, $dbname);

	function sort_by_percentage($a, $b) {
		$result = 0;
		$a_percent = ($a['seatstaken'] / $a['capacity']);
		$b_percent = ($b['seatstaken'] / $b['capacity']);
		if ($a_percent > $b_percent) {
			$result = 1;
		} else {
			$result = -1;
		}
		return $result;
	}

	for ($block = 1; $block <= 4; $block++) {
		$sql = "SELECT `id`
				FROM `users`
				LEFT JOIN (SELECT * FROM `registrations` WHERE `registrations`.`sessionblock` = '$block') registrations
				ON `users`.`id` = `registrations`.`studentid`
				WHERE `registrations`.`studentid` IS NULL";

		$users = array();
		$result = mysqli_query($con, $sql);

		while ($row = mysqli_fetch_array($result)) {
			$users[] = $row[0];
		}

		shuffle($users); //Shuffle order of elements in users so that all seniors, for example, don't get assigned to the same block

		$sql = "SELECT `id`,`capacity`,`seatstaken`
				FROM `sessions`
				WHERE `block` = '$block' AND `id` <> '2016000' AND `seatstaken`<`capacity`"; //that is the ID of the planned absence block

		$sessions = array();
		$result = mysqli_query($con, $sql);

		while ($row = mysqli_fetch_array($result)) {
			$sessions[$row["id"]]["id"] = $row["id"]; //stored twice; one for unique element number in assoc. array, one to keep after usort operation
			$sessions[$row["id"]]["capacity"] = $row["capacity"];
			$sessions[$row["id"]]["seatstaken"] = $row["seatstaken"];
		}

		foreach ($users as $user) {
			usort($sessions, 'sort_by_percentage');
			$sessionid = $sessions[0]["id"];
			$session = $sessionid . '-' . $block;
			$attempt = file_get_contents("http://times.bcp.org/justice/register.php?studentid=$user&sessionid=$session&noReassignment=1");
			$response = json_decode($attempt);
			if ($response[0] = "success") {
				echo("User $user successfully registered for $session: " . $response[1]) . "<br />";
				$sessions[0]["seatstaken"] = $sessions[0]["seatstaken"] + 1;
				if ($sessions[0]["seatstaken"] >= $sessions[0]["capacity"]) {
					unset($sessions[0]);
				}
			} else {
				die("Error. Tried user $user. Response was: " . $response[0] . " - " . $response[1]);
			}
		}
	}

	$con->close();
	
?>