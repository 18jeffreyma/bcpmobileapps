
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="favicon.ico">

    <title>Bellarmine Justice Summit</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/signin.css" rel="stylesheet">

    <script src="js/ie-emulation-modes-warning.js"></script>

  </head>

  <body>

    <div class="container">

        <form class="form-signin" action="authenticate.php" method="get">
          <h2 class="form-signin-heading">Student Sign In</h2>
          <?php 
          if (isset($_GET["state"])) {
            if ($_GET["state"] == 2) {
              echo("<div class=\"alert alert-danger\" role=\"alert\">Failed to authenticate. Please enter a valid student ID or email address.</div>");
            }
            if ($_GET["state"] == 3) {
              echo("<div class=\"alert alert-info\" role=\"alert\">Successfully logged out.</div>");
            }
          }
          echo("<div class=\"alert alert-info\" role=\"alert\">This system is currently in view-only mode. You may login with either email or student ID.</div>");
          //echo("<div class=\"alert alert-info\" role=\"alert\">This system is currently offline. Your session schedule will be emailed to you Sunday night. You may check back here later if you do not receive an email.</div>");
          ?>
          <label for="studentid" class="sr-only">Student ID</label>
          <input type="text" name="studentid" id="studentid" class="form-control" placeholder="Student ID" autofocus>
          <label for="studentemail" class="sr-only">BCP Email</label>
          <input type="text" style="margin-top: 10px;" name="studentemail" id="studentemail" class="form-control" placeholder="BCP Email">

          <button style="margin-top: 20px;"class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
        </form>

      </div>

    </div>

    <script src="js/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>
