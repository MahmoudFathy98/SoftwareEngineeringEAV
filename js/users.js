
var labels = new Array();
var users = new Array();
var usertypeID;
var userID;

$( document ).ready(function() {
    
    $.ajax({ // get the user id
        url: '../php/users.php',
        data: {callfun: 'get_usertypeID', name: 'volunteer'},
        type: 'POST',
        dataType: "JSON",
        success: function(data) {
            usertypeID = data;
        },
        error: function(data){
            console.log(data);
        }
    });

    $(document).on('click', '#app1', function(e){
        e.preventDefault;
        e.stopImmediatePropagation;
        
        $("#mainMenu").hide();
        $("signupForm").show();
            
        $.ajax({ 
            url: '../php/users.php',
            data: {callfun: 'labels', usertypeid: usertypeID},
            type: 'POST',
            dataType: "JSON",
            success: function(data) {

                    labels = data;
                    var form = "<form action='#'  onsubmit='insert(); return false;' method='POST'>";
                
                    var i = 0;

                    for(var key in labels){
                        form += "<p>"+ key +":</p>";
                        form += "<input type='" + labels[key] + "' placeholder='" + key + "'id='input-" + (i) + "'><br>";
                        i++;
                    }

    form += " <input type='submit' value='submit' > <input type='button' name='show' id='showBtn' value='اظهر الاستمارات ' > </form>";

                    var formdiv = document.getElementById("signupForm"); 
                    formdiv.innerHTML+= form;

            },
            error: function(data){
                //console.log(data);
            }
        });
          
    })  
    
    $(document).on('click', '#showBtn', function(e){
        e.preventDefault;
        e.stopImmediatePropagation;
        
        $("#mainMenu").hide();
        $("signupForm").hide();
        $("tablehere").show();
        
        showall();

    }) 
    
});

function insert(){
        
        var vals = new Array();
    
        var len = Object.keys(labels).length;
        
        for( var i =0; i < len; i++){
            var name = "input-"+i;
            var aa = document.getElementById(name).value;
            vals.push(aa);
        }
                                                
        $.ajax({ 
            url: '../php/users.php',
            data: {callfun: 'insert', usertypeid: usertypeID, values: JSON.stringify(vals)}, //encode for array
            type: 'POST',
            dataType: "JSON",
            success: function(data) {
                
                console.log("Success");

            },
            error: function(data){
                    console.log(data);
                $("#errormsg").html(data.responseText);
                
            }
        });
    
}

function showall(){
    
    // users -> values

    var table = "<table width='400' border='1' align='Center'> <thead>";
    
    
    for(var key in labels){
        table += "<th>" + key + "</th>";
    }
    
    table += "    <th>تعديل</th> <th>مسح</th></thead> <tbody>";
    
       $.ajax({ 
            url: '../php/users.php',
            data: {callfun: 'showall', usertypeid: usertypeID},
            type: 'POST',
            dataType: "JSON",
            success: function(data) {
                
                users = data;
                
            for(var key in users){
                
                var arr_size = users[key].length; // size of the array that holds the each user info
                var arr = users[key];
            table += "<tr>";
                
                for(var i=0; i < arr_size; i++){
                    table += "<td>" + arr[i] + "</td>";
                }
                
                table += "<td bgcolor='#12C8A7'><a href='#' id='edit-"+ key +"' onclick='updateform(this); return false;'>Edit</a></td>";
                table += "<td bgcolor='#12C8A7'><a href='#' id='del-"+ key +"' onclick='deleteuser(this); return false;'>Delete</a></td>";
                table += "</tr>";   
            }
                table += "</tbody> </table>";
                var tablediv = document.getElementById("tablehere"); 
                tablediv.innerHTML+= table;

            },
            error: function(data){
                console.log(data);
                
            }
        });
}

function deleteuser(e){

    var ida = e.id;
    userID = ida.substr(ida.indexOf('-')+1, ida.indexOf('-'));
    
    $.ajax({ 
        url: '../php/users.php',
        data: {callfun: 'delete', userid: userID},
        type: 'POST',
        dataType: "JSON",
        success: function(data) {

            // notifiy done sucessfully 

        },
        error: function(data){
            console.log(data);
            $("#errormsg").html(data.responseText);
        }
    });

}

function updateform(e){
    
    $("#mainMenu").hide();
    $("signupForm").hide();
    $("updateForm").show();
    
    var ida = e.id;
    userID = ida.substr(ida.indexOf('-')+1, ida.indexOf('-'));
    
    var uservalue = users[userID];
    
    var form = "<form action='#'  onsubmit='updateuser(); return false;' method='POST'>";
                
    var i = 0;
    for(var key in labels){
        form += "<p>"+ key +":</p>";
        form += "<input type='" + labels[key] + "' id='update-" + (i) + "' value='"+ uservalue[i] +"'><br>";
        i++;
    }

        form += " <input type='submit' value='update'> </form>";

        var formdiv = document.getElementById("updateForm"); 
        formdiv.innerHTML+= form;

}

function updateuser(){
    
    var vals = new Array();
    
    var len = Object.keys(labels).length;
        
    for( var i =0; i < len; i++){
         var name = "update-"+i;
        var aa = document.getElementById(name).value;
        vals.push(aa);
    }
    
    $.ajax({ 
            url: '../php/users.php',
            data: {callfun: 'update', id: userID, usertypeid: usertypeID, values: JSON.stringify(vals)}, //encode for array
            type: 'POST',
            dataType: "JSON",
            success: function(data) {
                
                console.log("Success");

            },
            error: function(data){
                    console.log(data);
                $("#errormsg").html(data.responseText);
                
            }
        });
    
    
    
}



