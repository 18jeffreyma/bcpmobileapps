<?php

	$servername = "localhost";
	$username = "justice16dB";
	$password = "XpXYe9qY67FuVyjn";
	$dbname = "justice16dB";

	$con = mysqli_connect($servername, $username, $password, $dbname);

  	$sql = "SELECT * FROM `sessions`";
	$result = mysqli_query($con, $sql);

    $sessions = array();
    while($row = mysqli_fetch_assoc($result)) {
        $sessions[$row["id"].'-'.$row["block"]] = $row;
    }

    echo json_encode($sessions);

	$con->close();
	
?>