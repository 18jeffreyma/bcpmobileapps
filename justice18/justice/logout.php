<?php 

	setcookie("justicesummit_studentid", "", time()-3600);
	setcookie("justicesummit_studentemail", "", time()-3600);
	setcookie("justicesummit_studentfirst", "", time()-3600);
	setcookie("justicesummit_studentlast", "", time()-3600);
	setcookie("justicesummit_studentgrade", "", time()-3600);

	header("Location: login.php?state=3") ;

?>