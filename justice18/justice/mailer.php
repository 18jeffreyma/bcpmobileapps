<?php

	set_time_limit(600); //Set script execution time limit to 10 minutes

	//PHPMailer using local PHP SMTP server
	require 'PHPMailer/PHPMailerAutoload.php';

	//MYSQL connection
	$servername = "localhost";
	$username = "justice16dB";
	$password = "XpXYe9qY67FuVyjn";
	$dbname = "justice16dB";
	$con = mysqli_connect($servername, $username, $password, $dbname);
	if (mysqli_connect_errno()) { exit('Failed to connect to MySQL database: ' . mysqli_connect_error()); }
	
	$sql ="SELECT * from `users`";
	$results = mysqli_query($con, $sql);
	$users = array();
	while ($result = mysqli_fetch_assoc($results)) {
		$users[] = $result;
	}

	foreach ($users as $user) {

		$mail = new PHPMailer;
		$mail->isSMTP();
		$mail->Host = 'localhost';
		$mail->Port = 25;

		$studentfirst = $user["firstname"];
		$studentlast = $user["lastname"];
		$studentid = $user["id"];
		$studentemail = $user["email"];

		$sessions = json_decode(file_get_contents("http://times.bcp.org/justice/userSessions.php?studentid=$studentid"),true);

		$mail->From = "Chanan.Walia16@bcp.org";
		$mail->FromName = "Walia, Chanan '16";
		$mail->AddBCC('chanan.walia16@bcp.org');
		$mail->Subject = "Reminder: Justice Summit Breakouts for $studentfirst $studentlast ($studentid)";

		$body = file_get_contents("http://times.bcp.org/justice/email_template.html");
		$body = str_replace("{{studentid}}",$studentid,$body);
		$body = str_replace("{{studentemail}}",$studentemail,$body);
		$body = str_replace("{{studentfirst}}",$studentfirst,$body);

		for ($block = 1; $block <= 4; $block++) {
			$sessiontitle = $sessions[$block]["title"];
			$sessionlocation = $sessions[$block]["location"];
			$body = str_replace("{{block$block-title}}",$sessiontitle,$body);
			$body = str_replace("{{block$block-location}}",$sessionlocation,$body);		
		}

		$mail->Body = $body;
		$mail->isHTML(true);
		$mail->AddAddress($studentemail);
		//$mail->AddAddress("chananwalia@gmail.com");

		if(!$mail->send()) {
			echo "Message could not be sent to $studentemail<br>";
			echo 'Mailer Error: ' . $mail->ErrorInfo . '<br>';
		} else {
			echo "Message has been sent to $studentemail<br>";
		}
		
		$mail->ClearAllRecipients();
	}

?>