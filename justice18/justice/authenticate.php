<?php

	$servername = "localhost";
	$username = "justice16dB";
	$password = "";
	$dbname = "justice16dB";

	$con = mysqli_connect($servername, $username, $password, $dbname);

	$studentid = $_GET['studentid'];
	$studentemail = $_GET['studentemail'];

	if ($studentid == "216397") {
		header("Location: login.php"); 			
		die();
	}
	
	$studentid = mysqli_real_escape_string($con, $studentid);
	$studentemail = mysqli_real_escape_string($con, $studentemail);

  	$sql = "SELECT * FROM `users` WHERE `id` = '$studentid' OR `email` = '$studentemail'";
	$result = mysqli_query($con, $sql);

	if (mysqli_num_rows($result) > 0) {
        $row = mysqli_fetch_assoc($result);
        setCookie("justicesummit_studentid", $row["id"], time() + 86400);
        setCookie("justicesummit_studentemail", $row["email"], time() + 86400);
        setCookie("justicesummit_studentfirst", $row["firstname"], time() + 86400);
        setCookie("justicesummit_studentlast", $row["lastname"], time() + 86400);
        setCookie("justicesummit_studentgrade", $row["grade"], time() + 86400);
        header("Location: index.php");
        die();
    } else {
        header("Location: login.php?state=2");  
        die(); 
    }     

	$con->close();
	
?>
