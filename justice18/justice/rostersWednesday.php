<?php

	$servername = "localhost";
	$username = "justice16dB";
	$password = "XpXYe9qY67FuVyjn";
	$dbname = "justice16dB";

	$con = mysqli_connect($servername, $username, $password, $dbname);

?>

<!DOCTYPE html>

<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="favicon.ico">

    <title>BCP Justice Summit</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/style.css" rel="stylesheet">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

    <style>

    	.dense {
    		padding: 4px !important;
    		font-size: 12px !important;
    	}

    </style>
    
    <body style="padding-top: 0px;">

    	<div class="container">

			<?php

				$sql = "SELECT * 
						FROM `sessions`
						WHERE `block` = '3' OR `block` = '4' ORDER BY `location`, `block`, `id`";
				$result = mysqli_query($con, $sql) or die(mysqli_error($con));	
				$sessions = array();

				while($row = mysqli_fetch_assoc($result)) {
					$sessions[] = $row;
				}

				foreach ($sessions as $session) {
					$sessionid = $session["id"];
					$sessionblock = $session["block"];
					$sessiontitle = $session["title"];

					$sql = "SELECT `users`.`firstname`,`users`.`lastname`,`users`.`id`
							FROM `users`
							JOIN (SELECT * 
							      FROM `registrations`
							  	  WHERE `sessionid` = '$sessionid'
							  	  AND `sessionblock` = '$sessionblock') regs
						    ON regs.`studentid` = `users`.`id`
						    ORDER BY `users`.`lastname`, `users`.`firstname`, `users`.`id`";

					$result = mysqli_query($con, $sql) or die(mysqli_error($con));	
					$students = array();

					while ($row = mysqli_fetch_assoc($result)) {
						$students[] = $row;
					}

					echo("<div style=\"page-break-after: always;\">");
					echo("<h4><strong>Block {$session['block']}: {$session['title']}</strong></h4>");
					echo("<h5><strong>Location: </strong>{$session['location']}, ID: {$session['id']}-{$session['block']}<br /><strong>Presented By:</strong> {$session['presenternames']} ({$session['presenteremail']})</h5>");
					echo("<table class=\"table table-condensed table-striped table-bordered\">");
					echo("<tr><th class=\"dense\">Roster</th><th class=\"dense\">First Name</th><th class=\"dense\">Last Name</th><th class=\"dense\">Student ID</th><th class=\"dense\">Signature/Attendance</th></tr>");

					$count = 1;
					foreach ($students as $student) {
						echo("<tr><td class=\"dense\">{$count}</td><td class=\"dense\">{$student['firstname']}</td><td class=\"dense\">{$student['lastname']}</td><td class=\"dense\">{$student['id']}</td><td class=\"dense\">&nbsp;</td></tr>");
						$count++;
					}

					echo("</table></div>");

				}

				$con->close();
				
			?>

	</body>