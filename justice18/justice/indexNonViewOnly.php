<?php

  if (!isset($_COOKIE["justicesummit_studentfirst"])) {
    header("Location: login.php");
  }

?>

<!DOCTYPE html>

<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="favicon.ico">

    <title>BCP Justice Summit</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/style.css" rel="stylesheet">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    
    <script>

      var successShown = false;
      var viewOnly = false; //set this to false to enable registration; it is true now because sessions have been assigned and should not be changed: view only

      function readCookie(name) {
        var nameEQ = name + "=";
        var ca = document.cookie.split(';');
        for(var i=0;i < ca.length;i++) {
          var c = ca[i];
          while (c.charAt(0)==' ') c = c.substring(1,c.length);
          if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
        }
        return null;
      }

      function setView(studentid) {

        $.get(("userSessions.php?studentid=" + studentid), function(data) {
            var response = JSON.parse(data);

            var percentComplete = 0;
            var sessionList = new Array();
            
            for (var block = 1; block <= 4; block++) {
              if (response[block] != null) {

                percentComplete++;

                var sessionid = response[block]["id"] + "-" + block;
                var sessiontitle = response[block]["title"];
                var sessionlocation = response[block]["location"];

                sessionList.push(sessionid);

                $("#block" + block).find(".session-select").text("Select This Session Instead");
                $("#block" + block).find(".session-select").attr("disabled",false);
                $("#block" + block).find(".full").attr("disabled",true);
                $("#block" + block).find(".full").text("Session is Full");
                $("#" + sessionid).text("Session Selected");
                $("#" + sessionid).attr("disabled","disabled");
                //$("#" + sessionid).removeClass("btn-primary").addClass("btn-success");
                //$("#heading" + sessionid).css("background-color", "#95D195");
                $("#block" + block).find(".panel-heading").css("background-color", "#f5f5f5");
                $("#block" + block).find(".panel-heading").css("color", "#333");
                $("#heading" + sessionid).css("background-color", "#428bca");
                $("#heading" + sessionid).css("color", "#fff");
                $("#block" + block + "-icon").removeClass("glyphicon glyphicon-remove-circle").addClass("glyphicon glyphicon-ok-circle");
                $("#block" + block + "-link").html("" + sessiontitle);
                $("#block" + block + "-location").html("" + sessionlocation);

              }
            }

            // for (var session in sessionList) {
            //   $("#" + sessionList[session]).text("Session Selected");
            // }

          percentComplete = (percentComplete / 4) * 100;
          $(".progress-bar").prop("aria-valuenow",percentComplete);
          $(".progress-bar").css("width", (percentComplete + "%"));
          $(".progress-bar").html(percentComplete + "% Complete");
          $(".progress-bar").removeClass("active");

          if (percentComplete == 100) {
            if (successShown == false) {
              $("#completeModal").modal();  
              successShown = true;
            }
            $("#registration-complete-alert").show();
          }

          if (percentComplete == 0) {
            $("#introModal").modal();
          }

        });

        // $("#" + sessionid).html("Session Selected");
        // $("#" + sessionid).attr("disabled","disabled");
        // $("#" + sessionid).removeClass("btn-primary");
        // $("#" + sessionid).addClass("btn-success");
        // $("#heading" + sessionid).css("background-color", "#95D195");

      }


      $(document).ready(function(){

        $("#registration-complete-alert").hide();

        var studentid = readCookie('justicesummit_studentid');

        setView(studentid);

        if (viewOnly) {
          $(".session-select").attr("disabled", true);
          $(".session-present").attr("disabled", true);
        }

        $(".session-select").click(function() {

          if (viewOnly) {
            return;
          }

          var sessionid = this.id;
          $("#" + sessionid).text("Loading...");
          $("#" + sessionid).attr("disabled","disabled");

          $.get(("register.php?studentid=" + studentid + "&sessionid=" + this.id), function(data) {
            var response = JSON.parse(data);
            if (response[0] == "success") {
              $('#alerts').prepend(
                '<div class="alert alert-success alert-dismissable" role="alert">' +
                  '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                  '&times;</button>' + response[1] + 
                '</div>');
              $("#alerts").find(".alert:last").fadeTo(5000, 500).slideUp(500, function(){
                $("#alerts").find(".alert:last").alert('close');
              });
              setView(studentid);
              //$('html, body').animate({scrollTop:0}, 1000);       
            } else if (response[0] == "full") {
              if(alert('Unfortunately this sesssion has just reached full capacity. Click OK and the page will reload, graying out sessions that have been filled.')){
                window.location.reload();
              } else {
                window.location.reload();   
              }
            } else {
              if(confirm('The server has encountered an error. Please click OK to reload. If the problem persists, use the Help menu bar tab to let us know.')){
                window.location.reload();
              }
            }
          });

        });

        //This button is enabled for presenters to select their sessions, even if they are full
        $(".session-presenter-select").click(function() {

          if (viewOnly) {
            return;
          }

          var buttonid = this.id;
          var split = buttonid.split("_");
          var sessionid = split[0];

          $("#" + sessionid).text("Loading...");
          $("#" + sessionid).attr("disabled","disabled");

          $.get(("register.php?studentid=" + studentid + "&sessionid=" + sessionid + "&forceRegistration=1"), function(data) {
            var response = JSON.parse(data);
            if (response[0] == "success") {
              $('#alerts').prepend(
                '<div class="alert alert-success alert-dismissable" role="alert">' +
                  '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                  '&times;</button>' + response[1] + 
                '</div>');
              $("#alerts").find(".alert:last").fadeTo(5000, 500).slideUp(500, function(){
                $("#alerts").find(".alert:last").alert('close');
              });
              setView(studentid);
              //$('html, body').animate({scrollTop:0}, 1000);       
            } else if (response[0] == "full") {
              if(alert('Unfortunately this sesssion has just reached full capacity. Click OK and the page will reload, graying out sessions that have been filled.')){ 
                window.location.reload();
              } else {
                window.location.reload();   
              }
            } else {
              if(confirm('The server has encountered an error. Please click OK to reload. If the problem persists, use the Help menu bar tab to let us know.')){
                window.location.reload();
              }
            }
          });

        });

        $(".block-link").click(function(e) {

          e.preventDefault();
          var block = $(this).prop("href").match(/\d+/)[0];
          $('a[href="#block' + block + '"]').tab('show');
          window.scrollTo(0, 0);

        });

        $("#help-link").click(function(e) {

          e.preventDefault();
          $("#introModal").modal();

        });


        //$('#myModal').modal();
        //JQuery

    });
    </script>

    <style>

      .panel-title a {
        display: block;
        padding: 10px 15px;
        margin: -10px -15px;
      }

    </style>

    <?php
      
      $servername = "localhost";
      $username = "justice16dB";
      $password = "XpXYe9qY67FuVyjn";
      $dbname = "justice16dB";

      $con = mysqli_connect($servername, $username, $password, $dbname);

      $studentid = $_COOKIE["justicesummit_studentid"];
      $studentemail = $_COOKIE["justicesummit_studentemail"];
      $studentfirst = $_COOKIE["justicesummit_studentfirst"];
      $studentlast = $_COOKIE["justicesummit_studentlast"];
      $studentgrade = $_COOKIE["justicesummit_studentgrade"];

      
      if ($studentid == '216397') {
        header("Location: login.php");
        die();
      }


      function getSessionsByBlock($block) {

        global $con;

        $sql = "SELECT * FROM `sessions` WHERE `block` = '$block'";
        $result = mysqli_query($con, $sql);

        $sessions = array();
        while($row = mysqli_fetch_assoc($result)) {
          $sessions[] = $row;
        }

        usort($sessions, function($x,$y){return strcmp($x["title"], $y["title"]);});

        return $sessions;

      }

    ?>


  </head>

  <body>

     <div class="modal fade" tabindex="-1" role="dialog" id="introModal">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title">Breakout Session Registration</h4>
          </div>
          <div class="modal-body">
            <p>This website lets you register for breakout sessions for the <strong>2016 Justice Summit on Poverty</strong> at Bellarmine. Breakout sessions are built into the Bellarmine schedule for the week of April 11. Sessions in Blocks 1 and 2 (held on Monday) will be presented by Bellarmine faculty and students, and sessions in Blocks 3 and 4 (held on Wednenday) will be presented by guests to our campus.<br /><br />Use the tabs at the top to switch between blocks. Click/tap on sessions to see details and register. All changes are saved automatically.<br /><br />If you are <strong>presenting one or two sessions</strong>, please select your own session(s). If you have or will have a <strong>planned absence</strong> for Monday, select the "Planned Absence" session for Blocks 1 and 2; do the same for Blocks 3 and 4 if you are missing Wednesday.<br /><br />If you have any questions or need help, please contact me by <a href="mailto:Chanan.Walia16@bcp.org?subject=Justice+Summit+App">clicking here</a>. If you need to reach this popup again, select the "Help" tab at the top of the page.</p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>

    <div class="modal fade" tabindex="-1" role="dialog" id="completeModal">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title">Your Registration is Complete!</h4>
          </div>
          <div class="modal-body">
            <p>You have been successfully registered for all four breakout session blocks. You may freely close this website at any time and your session schedule with room numbers will be emailed to you next week. You may also make changes to any parts of your schedule as you'd like, through the end of this week.</p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>

    <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="index.php">Bellarmine Justice Summit</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li class="active"><a href="information.php">Session Registration</a></li>
            <li><a href="#" id="help-link">Help</a></li>
          </ul>
          <p class="navbar-text navbar-right">Signed in as <?php echo($studentfirst." ".$studentlast);?> / <a href="logout.php" class="navbar-link">Sign Out</a></p>

        </div><!--/.nav-collapse -->
      </div>
    </nav>

    <div class="container" id="top">

      <div class="row">

        <div class="col-sm-4"> <!-- Left 1/3 of page, chosen sessions/cart, stick to top -->

          <h3> </h3>

          <div class="panel panel-default">
            <div class="panel-heading">
              <h3 class="panel-title">Sessions for <?php echo("$studentfirst $studentlast");?></h3>
            </div>
            <div class="panel-body">
              
              <div class="progress">
                <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
                  <span class="sr-only"></span>
                </div>
              </div>

              <table class="table table-bordered table-striped">
                <tr>
                  <th>Block</th>
                  <th>Session Name</th>
                  <th>Location</th>
                </tr>

                <?php

                  $blocktimes = array(
                    "1" => "4/11, 10:20-11:10am",
                    "2" => "4/11, 11:20-12:10pm",
                    "3" => "4/13, 11:30-12:20pm",
                    "4" => "4/13, 1:00-1:50pm",
                  );

                  for ($block = 1; $block <= 4; $block++) {
                    echo('<tr><td>'.$block." (".$blocktimes[$block].')</td><td id="block'.$block.'-link"><a href="#block'.$block.'" class="block-link">Choose a Session</a></td><td id="block'.$block.'-location"></td></tr>');
                  }

                ?>
                <!-- <tr>
                  <td>1</td>
                  <td>The Environmental Impact of Poverty</td>
                </tr>
                <tr>
                  <td>2</td>
                  <td>Tattoos on the Soul: Racism and Discrimination in the Modern World</td>
                </tr>
                <tr>
                  <td>3</td>
                  <td><a href="">Choose a Session</a></td>
                </tr>
                <tr>
                  <td>4</td>
                  <td><a href="">Choose a Session</a></td>
                </tr> -->
              </table>

              <!--<div class="alert alert-info" role="alert">Note: Your session schedule with room numbers will be emailed to you next week.</div>-->
            </div>
          </div>

          <div id="alerts"></div>

        </div>        

        <div class="col-sm-8"> <!-- Right 2/3 of page, session list -->

          <h2>2016 Breakout Session Selection</h2>

          <div id="registration-complete-alert" class="alert alert-success alert-dismissable" role="alert">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">&times;</button>
            <strong>Success!</strong> You are registered for all four breakout sessions. You may freely close this website and your session schedule with room numbers will be emailed to you next week.
          </div>

          <div>

              <ul id="block-tabs" class="nav nav-tabs" role="tablist">
                <?php

                  for ($block = 1; $block <= 4; $block++) { //Number of blocks
                    echo('<li role="presentation"');
                    if ($block == 1) echo ('class="active"');
                    echo('><a href="#block'.$block.'" aria-controls="block'.$block.'" role="tab" data-toggle="tab">Block '.$block.'  <span id="block'.$block.'-icon" class="glyphicon glyphicon-remove-circle" aria-hidden="true"></span></a></li>');
                  }

                ?>
              </ul>

              <div class="tab-content">
                <?php

                  for ($block = 1; $block <= 4; $block++) { //Number of blocks
                    echo('<div role="tabpanel" class="tab-pane');
                    if ($block == 1) echo (' active');
                    echo('" id="block'.$block.'">
                      <div class="panel-group" id="accordion'.$block.'" role="tablist" aria-multiselectable="true">');

                    $sessions = getSessionsByBlock($block);

                    foreach ($sessions as $session) {

                      $uid = $session["id"].'-'.$session["block"];

                      if ($session["seatstaken"] < $session["capacity"]) {
                        $full = false;
                      } else {
                        $full = true;
                      }

                      //$full = $session["seatstaken"] >= $session["capacity"];

                      echo('<div class="panel panel-default">
                              <div class="panel-heading" role="tab" id="heading'.$uid.'" style="opacity: '. (($full) ? ".5" : "1") .';"">
                                <h4 class="panel-title">
                                  <a role="button" data-toggle="collapse" data-parent="#accordion'.$block.'" href="#panel'.$uid.'" aria-expanded="false" aria-controls="panel'.$uid.'">
                                   '.$session["title"].'
                                  </a>
                                </h4>
                              </div>
                              <div id="panel'.$uid.'" class="panel-collapse collapse" role="tabpanel" aria-labelledby="panel'.$uid.'">
                                <div class="panel-body">
                                  <strong>Presented by '.$session["presenternames"].'</strong>
                                  <p>'.$session["description"].'</p>
                                  <button id="'.$uid.'" class="btn btn-primary btn-md session-select'. (($full) ? " full\" disabled=\"disabled\">Session is Full" : "\">Select this Session") .'</button>
                                  <button id="'.$uid.'_presenter" class="btn btn-primary btn-md session-presenter-select">Presenting During this Session</button>
                                </div>
                              </div>
                            </div>
                      ');


                    }

                    echo('</div> </div>'); //Close out of accordion and tab pane
                  }

                ?>

              </div>

          </div>
        </div>

      </div>

    </div><!-- /.container -->

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="js/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>