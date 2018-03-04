<?php

//creating response array
$response = array();

if($_SERVER['REQUEST_METHOD']=='POST'){

    //getting values
    $sessionID = $_POST['sessionID'];
    

    //including the db operation file
    require_once 'DbOperations.php';

    $db = new DbOperations();

    //inserting values 
	
	$jSessions = $db->getSessionFullInfo($sessionID);
	
    if(! is_null($jSessions)) {
		$response['success'] = true;
		$response['message'] = "returned title";
		$response['title'] = $jSessions['title'];
		$response['description'] = $jSessions['description'];
		$response['presenterEmail'] = $jSessions['presenterEmail'];
		$response['capacity'] = $jSessions['capacity'];
		$response['seatstaken'] = $jSessions['seatsTaken'];
		$response['location'] = $jSessions['location'];
		
	} else {
		$response['success'] = true;
		$response['message'] = "error sessions returned is null";
		$response['title'] = null;
		$response['description'] = null;
		$response['presenterEmail'] = null;
		$response['capacity'] = null;
		$response['seatstaken'] = null;
		$response['location'] = null;
	}
}else{
    $response['success']=false;
    $response['message']='You are not authorized';
}

echo json_encode($response);
?>