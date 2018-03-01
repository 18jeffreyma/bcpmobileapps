<?php

//creating response array
$response = array();

if($_SERVER['REQUEST_METHOD']=='POST'){

    //getting values
    $blockNumber = $_POST['blockNumber'];
    

    //including the db operation file
    require_once 'DbOperations.php';

    $db = new DbOperations();

    //inserting values 
	$jSessions = $db->getSessions();
	
    if(!is_null($jSessions)) {
		$response['success'] = true;
		$response['sessions'] = $jSessions;
	} else {
		$response['success'] = true;
		$response['sessions'] = null;
	}

}else{
    $response['success']=false;
    $response['message']='You are not authorized';
}
echo json_encode($response);
?>