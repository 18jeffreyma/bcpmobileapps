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
	
	$jSessions = $db->getSessionTitle($sessionID);
	
    if(! is_null($jSessions)) {
		$response['success'] = true;
		$response['message'] = "returned title";
		$response['title'] = $jSessions;
	} else {
		$response['success'] = true;
		$response['message'] = "error sessions returned is null";
		$response['title'] = null;
	}

}else{
    $response['success']=false;
    $response['message']='You are not authorized';
}

echo json_encode($response);
?>