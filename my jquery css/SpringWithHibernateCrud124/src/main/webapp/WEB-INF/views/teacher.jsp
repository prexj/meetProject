<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
	<!-- <link href="http://code.jquery.com/ui/1.10.4/themes/ui-lightness/jquery-ui.css" rel="stylesheet"> 
	<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
	<script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script> -->
	<link href="<c:url value="/resources/demo/css/jquery-ui.css" />" rel="stylesheet"> 
	<script src="<c:url value="/resources/demo/js/jquery-1.10.js" />"></script>
	<script src="<c:url value="/resources/demo/js/jquery-ui.js" />"></script>
	<!-- CSS -->
	<style>
	Table.GridOne 
		{
		 padding: 3px;
		 margin: 0;
		 background: lightyellow;
		 border-collapse: collapse; 
		 width:35%;
		}
	Table.GridOne Td 
		{ 
		 padding:2px;
		 border: 1px solid #ff9900;
		 border-collapse: collapse;
		}
	Table.GridOne Tr Th 
		{ 
		 padding:2px;
		 border: 1px solid #ff9900;
		 border-collapse: collapse;
		}
	</style>
	<script type="text/javascript">
	
	jQuery(document).ready(function() {
		$('#insertBut').hide();
		$('#updateBut').hide();
		title ="";
		showAll();
		var id = $("#id").val();
		if(id == '' ){
			title = "Add Re-Supply Reqest Data";
		}else{
			title = "Edit Ip Re-Supply Reqest Data";
		}
	    jQuery("#confirmationDialog").dialog({
	        autoOpen: false,
	        modal: true,
	        title:title,
	        width:600,
	        height:600,
	        open: function() {
	        	var id = $("#id").val();
	        	if(id == '' ){
	        		$('#insertBut').show();
	        		$('#updateBut').hide();
	        	}else{
	        		$('#insertBut').hide();
	        		$('#updateBut').show();
	        	}
	        },
	        close :function() {
	        	$("#id").val('');
    	    	$("#fname").val('');
    	    	$("#lname").val('');
    	    	$("#gen").val('');
    	    	$("#address").val('');
    	    	
	        	showAll();
	        } 
	    });
	});
	
	function insert(){
		$("#confirmationDialog").dialog("open");
	}
	
	function showAll(){
	      $.ajax({
	              type:"GET",
	              url:"showAllTeacher",
	              dataType: "json",
	              success:function(data)
	              { 
	            	  var rows = '';
	                  $.each( data , function( index, item ) {
	                	rows += '<tr><td>' + item.id + '</td>';
	          	  	  	rows += '<td>' + item.firstname + '</td>';
	          	  	  	rows += '<td>' + item.lastname + '</td>';
	          	  	  	rows += '<td>' + item.gender + '</td>';
	          	  		//rows += '<td>' + item.address + '</td>';
	          	  		rows += '<td onclick="editAjaxData('+item.id+');" >edit</td>';
	          	  		rows += '<td onclick="deleteAjaxData('+item.id+');" >Delete</td></tr>';
	          	  	  	
	          	  	  });
	          	  	  $('#tblProducts').html(rows);
	              },
	              error:function(xmlHttpRequest, textStatus, errorThrown)
	              {
	                     alert("error");
	              }
	      });
	}
	
	function insertAjaxData(){
    	var fn = $("#fname").val();
  		var ln = $("#lname").val();
  		var gn = $("#gen").val();
  		var add = $("#address").val();
  		console.log('fn ::'+fn+' ln ::'+ln+' gn :: '+gn+' add ::: '+add);
    	$.ajax({
	    	   type: "post",
	    	   url: "insertInfoTeacher",
	    	   dataType: "json",  
	    	   data:{fname: fn , lname: ln , gen: gn},
	    	   success: function(response){
	    	    if(response == 1){
	    	    	
	    	    	alert('inserted');
	    	    	$('#confirmationDialog').dialog('close');
	    	    	showAll();
	    	    }
	    	   },
	    	   error: function(){      
	    	    alert('Error while request..');
	    	   }
	    });
    }
	function updateAjaxData(){
		var id = $("#id").val();
    	var fn = $("#fname").val();
  		var ln = $("#lname").val();
  		var gn = $("#gen").val();
  		var add = $("#address").val();
    	$.ajax({
	    	   type: "post",
	    	   url: "updateInfoTeacher",
	    	   dataType: "json",  
	    	   data:{id: id, fname: fn , lname: ln , gen: gn , address: add},
	    	   success: function(response){
	    	    if(response == 1){
	    	    	alert('updated');
	    	    	$('#confirmationDialog').dialog('close');
	    	    	showAll();
	    	    }
	    	   },
	    	   error: function(){      
	    	    alert('Error while request..');
	    	   }
	    });
    }
	
	function editAjaxData(id){
		alert('editAjaxData()'+id);
		
  	  $.ajax({
  	   type: "get",
  	   url: "editDataTeacher",
  	   dataType: "json",  
  	   data:{id: id },
  	   success: function(response){
  		    alert(response);
  		    $("#id").val(response.id);
    		$("#fname").val(response.firstname);
    		$("#lname").val(response.lastname);
    		$("#gen").val(response.gender);
    		$("#address").val(response.address);
  	    	$("#confirmationDialog").dialog("open");
  	   },
  	   error: function(){      
  	    alert('Error while request..');
  	   }
  	  });
  	}
	
	function deleteAjaxData(id){
  	  $.ajax({
  	   type: "post",
  	   url: "deleteDataTeacher",
  	   dataType: "json",  
  	   data:{id: id },
  	   success: function(response){
	  	   if(response == 1){
	  		   alert('data dleted');
	  		   showAll();
	  	   }
  	   },
  	   error: function(){      
  	   		alert('Error while request..');
  	   }
  	  });
  	 }
	
	function searchName(){
		var firstname = $("#search").val();
	      $.ajax({
	              type:"GET",
	              url:"searchName",
	              dataType: "json",
	              data:{firstname: firstname },
	              success:function(data)
	              { 
	            	  var rows = '';
	                  $.each( data , function( index, item ) {
	                	rows += '<tr><td>' + item.id + '</td>';
	          	  	  	rows += '<td>' + item.firstname + '</td>';
	          	  	  	rows += '<td>' + item.lastname + '</td>';
	          	  	  	rows += '<td>' + item.gender + '</td>';
	          	  		rows += '<td>' + item.address + '</td>';
	          	  		rows += '<td onclick="editAjaxData('+item.id+');" >edit</td>';
	          	  		rows += '<td onclick="deleteAjaxData('+item.id+');" >Delete</td></tr>';
	          	  	  	
	          	  	  });
	          	  	  $('#tblProducts').html(rows);
	              },
	              error:function(xmlHttpRequest, textStatus, errorThrown)
	              {
	                     alert("error");
	              }
	      });
	}
	</script>
</head>
<body>
	<%@ include file ="header.jsp" %>
	<button id="click" onclick="insert();"> Add New</button>
	
	<input id="showPage" type="hidden" name="showPage"  value="${showPage}"/>
				
	<table class="GridOne">
	  <thead>
	  	<tr>
		 <th> Id </th>
		  <th> Sponsor </th>
		  <th> Investigator </th>
		  <th> Site no </th>
		  <th colspan="2">Action</th>
		</tr>
	  </thead>
	  <tbody id="tblProducts">
	  
	  </tbody>
	</table>
	<div id="confirmationDialog">
        <table class="GridOne">
	        <tr>
				<td>
					<input id="id" type="hidden" name="id"  value=""/>
					<label>Sponsor</label>
				</td> 
				<td>
					<input id="fname" type="text" name="fname"  value=""/>
				</td>         
			</tr>
			 <tr>
				<td>
					<label>Investigator</label>
				</td> 
				<td>
					<input id="lname" type="text" name="lname"  value=""/>
				</td>         
			</tr>
			 <tr>
				<td>
					<label>Site no</label>
				</td> 
				<td>
					<input id="gen" type="text" name="gen"  value=""/>
				</td>         
			</tr>
			<tr>
				<td>
					<input type="button" id="insertBut" name="submit" onclick="insertAjaxData();" value="submit">
					<input type="button" id="updateBut" name="submit" onclick="updateAjaxData();"  value="update">
				</td>         
			</tr>
			
        </table>
</div>

</body>
</html>