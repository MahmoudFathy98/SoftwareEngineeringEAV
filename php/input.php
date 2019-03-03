<?php
  function runMyFunction() {
$db = mysqli_connect("localhost", "root","", "software");
      $sql = "insert into usertypeoptions(usertypeID,optionID) values('1','14')";
      mysqli_query($db,$sql);
  }

  if (isset($_GET['hello'])) {
    runMyFunction();
      header("location:../html/index2.html");
  }
?>