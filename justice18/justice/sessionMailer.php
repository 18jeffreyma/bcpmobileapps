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
	
	$sql ="SELECT * from `sessions` WHERE `block` = '3' OR `block` = '4'";
	$results = mysqli_query($con, $sql);
	$sessions = array();
	while ($result = mysqli_fetch_assoc($results)) {
		$sessions[$result["id"]] = $result;
	}

	foreach ($sessions as $session) {

		$mail = new PHPMailer;
		$mail->isSMTP();
		$mail->Host = 'localhost';
		$mail->Port = 25;

		$presenternames = $session["presenternames"];
		$title = $session["title"];
		$id = $session["id"];
		$presenteremail = $session["presenteremail"];

		$mail->From = "Chanan.Walia16@bcp.org";
		$mail->FromName = "Walia, Chanan '16";
		$mail->AddBCC("Chanan.Walia16@bcp.org");
		$mail->Subject = "Email List for your Bellarmine Breakout Session";

		$body = file_get_contents("http://times.bcp.org/justice/session_email_template.html");
		$body = str_replace("{{presenternames}}",$presenternames,$body);
		$body = str_replace("{{title}}",$title,$body);
		$body = str_replace("{{id}}",$id,$body);

		$sql = "SELECT `users`.`email`
				FROM `users`
				JOIN (SELECT * 
					  FROM `registrations`
					  WHERE `sessionid` = '$id') regs
					  ON regs.`studentid` = `users`.`id`
					  ORDER BY `users`.`lastname`, `users`.`firstname`, `users`.`id`";

		$result = mysqli_query($con, $sql) or die(mysqli_error($con));	
		$students = array();

		while ($row = mysqli_fetch_assoc($result)) {
			$students[] = $row["email"];
		}

		$students = array_unique($students);

		$emaillist = "";
		foreach ($students as $student) {
			$emaillist = $emaillist . $student . '<br>';
		}

		$body = str_replace("{{emaillist}}",$emaillist,$body);

		$mail->Body = $body;
		$mail->isHTML(true);
		$mail->AddAddress($presenteremail);

		if(!$mail->send()) {
			echo "Message could not be sent to $presenteremail<br>";
			echo 'Mailer Error: ' . $mail->ErrorInfo . '<br>';
		} else {
			echo "Message has been sent to $presenteremail<br>";
		}
		
		$mail->ClearAllRecipients();
	}

?>