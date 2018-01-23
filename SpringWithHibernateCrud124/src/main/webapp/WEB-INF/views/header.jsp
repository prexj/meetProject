<h1 id="display">
	 
</h1>

<table> 
	<tr>
		<td><span><a href="home" id="Drug">Drugs </a>&nbsp;&nbsp;&nbsp;<a href="manu1" id="ReleaseAndReceipt">Ip Release And Receipt</a>&nbsp;&nbsp;&nbsp;<a href="manu2" id="IpReSupply">Ip Re-Supply Reqest</a>&nbsp;&nbsp;&nbsp;<!-- <a href="javascript:void(0)" onclick="">manu3</a> --></span></td>
	</tr>
</table>
<script type="text/javascript">
window.onload = function() {
	//Your JavaScript Here
	var showPage = $('#showPage').val();
	console.log('showPage '+showPage);
	if(showPage == 1 || showPage == '1'){
		$('#display').html('Drugs List');
		$('#Drug').css('color','#d40909');
	}else if(showPage == 2 || showPage == '2'){
		$('#display').html('Ip Release And Receipt Form');
		$('#ReleaseAndReceipt').css('color','#d40909');
	}else if(showPage == 3 || showPage == '3'){
		$('#display').html('Ip Re-Supply Reqest Form');
		$('#IpReSupply').css('color','#d40909');
	}
}

</script>

