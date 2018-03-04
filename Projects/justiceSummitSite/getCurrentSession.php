<?php

//creating response array
$response = array();

if($_SERVER['REQUEST_METHOD']=='POST'){

    //getting values
    $blockNumber = $_POST['blockNumber'];
	$studentID = $_POST['studentID'];
	$email = $_POST['email'];
    

    //including the db operation file
    require_once 'DbOperations.php';

    $db = new DbOperations();

    //inserting values 
	$jSessions = $db->getCurrentSelectedSession($blockNumber, $studentID);
	
    if(!is_null($jSessions) && $db->checkUser($email,$studentID)) {
		$response['success'] = true;
		$response['sessionID'] = $jSessions["sessionid"];
	} else {
		$response['success'] = true;
		$response['sessionID'] = $jSessions["sessionid"];
	}

}else{
    $response['success']=false;
    $response['message']='You are not authorized';
}
echo json_encode($response);
?>