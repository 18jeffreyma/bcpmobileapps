<?php

//creating response array
$response = array();

if($_SERVER['REQUEST_METHOD']=='POST'){

    //getting values
    $studentID = $_POST['studentID'];
    $email = $_POST['email'];

    //including the db operation file
    require_once 'DbOperations.php';

    $db = new DbOperations();

    //inserting values 
    if($db->checkUser($email, $studentID)){
		$response['success'] = true;
        $response['loggedIn']=true;
        $response['message']='Logged in successfully';
    }else{
		$response['success'] = true;
        $response['loggedIn'] = false;
        $response['message']='Incorrect email-ID combination';
    }

}else{
    $response['success']=false;
	$response['loggedIn'] = false;
    $response['message']='You are not authorized';
}
echo json_encode($response);

?>
