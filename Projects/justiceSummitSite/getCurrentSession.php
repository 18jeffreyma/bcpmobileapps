<?php

//creating response array
$response = array();

if($_SERVER['REQUEST_METHOD']=='POST'){

    //getting values
    $studentID = $_POST['studentID'];
    $email = $_POST['email'];
	$blockNumber = $_POST['blockNumber'];

    //including the db operation file
    require_once 'DbOperations.php';

    $db = new DbOperations();
	
	$sessionID = $db->getSelectedSession($studentID, $blockNumber);
	$sessionTitle = $db->getSessionInfo($sessionID, $blockNumber, "title");
	$sessionDescription = $db->getSessionInfo($sessionID, $blockNumber, "description");
	
	$sessionPresenterNames = $db->getSessionInfo($sessionID, $blockNumber, "presenternames");	
	$sessionPresenterEmail = $db->getSessionInfo($sessionID, $blockNumber, "presenteremail");	
	
	$sessionCapacity = $db->getSessionInfo($sessionID, $blockNumber, "capacity");
	$sessionSeatsTaken = $db->getSessionInfo($sessionID, $blockNumber, "seatstaken");
	
	$sessionLocation = $db->getSessionInfo($sessionID, $blockNumber, "location");
	

    //inserting values 
    if($db->checkUser($email, $studentID) && (!is_null($sessionID) && !is_null($sessionTitle))){
		$response['success'] = true;
        $response['id']=$sessionID;
        $response['title']=$sessionTitle;
		$response['description'] = $sessionDescription;
		$response['presenternames'] =$sessionPresenterNames;
		$response['presenteremail'] =$sessionPresenterEmail;
		$response['capcity'] = $sessionCapacity;
		$response['seatstaken'] = $sessionSeatsTaken;
		$response['location'] = $sessionLocation;
    }else{
		$response['success'] = true;
        $response['id']=null;
        $response['title']=null;
		$response['description'] = null;
		$response['presenternames'] =null;
		$response['presenteremail'] =null;
		$response['capcity'] = null;
		$response['seatstaken'] = null;
		$response['location'] = null;
    }

}else{
    $response['success'] = false;
    $response['sessionID']=null;
    $response['sessionTitle']=null;
}
echo json_encode($response);

?>
