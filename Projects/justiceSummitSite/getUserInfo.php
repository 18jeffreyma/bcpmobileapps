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
		$response['firstName'] = $db->getFirstName($email,$studentID);
        $response['lastName']= $db->getLastName($email,$studentID);
        $response['grade']= $db->getGrade($email,$studentID);
		$response['message']='Obtained user information';
    }else{
		$response['success'] = true;
        $response['firstName'] = null;
        $response['lastName']= null;
        $response['grade']= null;
        $response['message']='Incorrect email-ID combination';
    }

}else{
    $response['success']=false;
	$response['loggedIn'] = false;
    $response['message']='You are not authorized';
}
echo json_encode($response);

?>
