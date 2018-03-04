<?php

//creating response array
$response = array();

if($_SERVER['REQUEST_METHOD']=='POST'){

    //getting values
    $blockNumber = $_POST['blockNumber'];
    $studentID = $_POST['studentID'];
	$email = $_POST['email'];
	$sessionID = $_POST['sessionID'];

    //including the db operation file
    require_once 'DbOperations.php';

    $db = new DbOperations();

    //inserting values 
    if($db->addToSession($blockNumber,$studentID,$sessionID) && $db->checkUser($email, $studentID)){
        $response['success']=true;
        $response['message']='Session added successfully';
    }else{

        $response['success']=false;
        $response['message']='Could not add to session';
    }

}else{
    $response['success']=false;
    $response['message']='You are not authorized';
}
echo json_encode($response);

?>