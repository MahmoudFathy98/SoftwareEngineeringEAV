<?php

include_once("connection.php");

class users{
    
static function get_usertypeID($name){
    
    $sql = "Select ID from usertype where Name='$name'";
    $result = mysqli_query($GLOBALS["con"],$sql);

    while($row = mysqli_fetch_array($result)){
        echo $row[0];
    }
    
}
    
static function insert($usertypeid,$values){
    
    $sql = "insert into user(usertypeID,isdeleted) values('$usertypeid','0')";
    mysqli_query($GLOBALS["db"],$sql);
    $userID=mysqli_insert_id($GLOBALS["con"]);
    
    $sql2 = "select ID from usertypeoptions where usertypeID='$usertypeid'";
    $result = mysqli_query($GLOBALS["con"],$sql2); // array
    
    $i = 0;
    
    while($row = mysqli_fetch_array($result)){
        
         $sql3="insert into  uservalues (value,userID,usertypeoptionsID, isdeleted) values('$values[$i]','$userID','$row[0]', '0')";
        mysqli_query($GLOBALS["con"],$sql3);
        $i++;

    }
    
    
}

static function delete($userID){

    $sql="update uservalues,user set uservalues.isdeleted='1', user.isdeleted ='1' where uservalues.userID = '$userID' and user.ID='$userID'";
    mysqli_query($GLOBALS["con"],$sql);

}
    
static function showall ($usertypeid){
    
    $sql1 ="select ID from user where usertypeID='$usertypeid' and isdeleted != '1'";
    $result1 = mysqli_query($GLOBALS["db"], $sql1);
    
    $Users = array(); // array of all users
    
    while($rowID = mysqli_fetch_array($result1)){
        
        $sql2 = "select ID from usertypeoptions where usertypeID='$usertypeid'";
        $result2 = mysqli_query($GLOBALS["db"], $sql2);
        
        $user_values = array(); // array fro each user values
        while($rowUTOID = mysqli_fetch_array($result2)){
            
            $sql3 = "select value from uservalues where userID='$rowID[0]' and usertypeoptionsID='$rowUTOID[0]' and isdeleted != '1'";
            $result3 = mysqli_query($GLOBALS["db"], $sql3);
            $rowVal = mysqli_fetch_array($result3);
            
            array_push($user_values, $rowVal[0]);
        }
        
        $Users[$rowID[0]] = $user_values;
        
    }
    
    echo json_encode($Users);

    
    
}
    
static function labels($usertypeid){

    $headers_rows = array();

    $sql ="SELECT optionID FROM usertypeoptions where usertypeID='$usertypeid'"; 
    $result = mysqli_query($GLOBALS["con"], $sql);

    while($row = mysqli_fetch_array($result)){

      $sql2 = "SELECT name, type FROM useroptions WHERE id='$row[0]'";
      $result2 = mysqli_query($GLOBALS["con"], $sql2);

      while($row = mysqli_fetch_array($result2)){
        # $array[$key] = $value;
        $headers_rows[$row[0]] = $row[1]; //name 0 , type 1 
      }
      
    }
    echo json_encode($headers_rows);  # array contains the resulted names of headers and types of fileds
  
  }

static function update($userid, $values, $usertypeid){
      
    
    $sql1 ="SELECT ID FROM usertypeoptions where usertypeID='$usertypeid'"; 
    $result = mysqli_query($GLOBALS["con"], $sql1);
    
    $i = 0;
    while($row = mysqli_fetch_array($result)){          
        $sql2 = "UPDATE uservalues SET value='$values[$i]' WHERE userID='$userid' and usertypeoptionsID='$row[0]'";
        mysqli_query($GLOBALS["con"],$sql2);
        $i++;
          
      }
  }
}

if(isset($_POST['callfun']) && !empty($_POST['callfun'])) {
  
  $functioncall = $_POST['callfun'];
  
  $user = new users;

  switch($functioncall) {
    case 'get_usertypeID' : 
        $name = $_POST['name'];  
        $user::get_usertypeID($name);
        break;
    case 'labels' : 
        $usertypeid = $_POST['usertypeid'];  
        $user::labels($usertypeid);
        break;
    case 'insert' : 
        $usertypeid = $_POST['usertypeid']; 
        $values = json_decode($_POST['values']); //decode for array
        $user::insert($usertypeid, $values);
        break;
    case 'showall' : 
        $usertypeid = $_POST['usertypeid']; 
        $user::showall($usertypeid);
        break;
    case 'delete' : 
        $userID = $_POST['userid']; 
        $user::delete($userID);
        break;
    case 'update' : 
        $id = $_POST['id'];
        $usertypeid = $_POST['usertypeid']; 
        $values = json_decode($_POST['values']); //decode for array
        $user::update($id, $values, $usertypeid);
        break;
  }
}
echo "SURPRISE!!!!!";

?>