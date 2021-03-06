<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.13.1/underscore-min.js"></script>
</head>

<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://unpkg.com/babel-standalone@6.15.0/babel.min.js"></script>

<style>
* {
	margin: 0px;
	padding: 0px;
	text-decoration: none;
}

#div001 {
	position: fixed;
	z-index: 5;
	width: 100%;
}

#div001_in01_in01>a {
	color: white;
}

#div001_in01_in01>a:hover {
	color: red;
}

#div001 {
	background-color: black;
	box-shadow: 0px 0px 10px;
}

#div001_in01 {
	margin: auto;
	width: 1082px;
	height: 60px;
	line-height: 60px;
}

#div001_in01_in01 {
	float: left;
}

#div001_in01_in02 {
	float: right;
}

#div001_in01_in02_in01 {
	text-align: right;
	width: 230px;
	height: 40px;
	background-color: black;
	border-bottom: 2px solid white;
}

#div001_in01_in02_in01>img {
	width: 20px;
}

#div001_in01_in02_in01:hover {
	cursor: pointer;
	border-bottom-color: red;
}

#div001_in01_in02_in02 {
	width: 230px;
	background-color: white;
	box-shadow: 0px 0px 5px;
	display: none;
	position: absolute;
	z-index: 2;
}

#div001_in01_in02_in02>div {
	height: 40px;
	line-height: 40px;
}

.div001_in01_in02_in02_in01 {
	border-bottom: 3px solid gray;
	width: 210px;
	font-weight: bold;
	margin: 10px;
}

#div001_in01_in02_in02>div>input {
	border: none;
	height: 35px;
	width: 160px;
	background-color: #f2f2f2;
	text-align: center;
}

#div001_in01_in02_in02>div>select {
	border: none;
	height: 35px;
	width: 210px;
	background-color: #f2f2f2;
	text-align-last: center;
}

#hearderInput001 {
	margin: 10px;
	border: none;
	color: white;
}

#hearderInput001:hover {
	cursor: pointer;
	color: red;
}
</style>

<body>
	<script>

	var searchTemp = `

		{{ for(var i=0; i<searchList.length; i++){  var search=searchList[i]; }}
         <figure>
            <div onclick="searchImgModalClick()" onmouseover="searchImgModalOver()" onmouseout="searchImgModalOut()" class="searchImgModal">???</div>
            <img onmouseover="searchImg01Over()" onmouseout="searchImg01Out()" class="searchImg01" src="{{=search['pd_image'] }} " onclick="location.href='http://localhost:9999/trip/board/detail.do?pd_seq={{=search['pd_seq'] }} ' ">
            <div onmouseover="searchImgModal2Over()" onmouseout="searchImgModal2Out()" class="searchImgModal2">????????????</div>
             <figcaption>
				<p>{{=search['pd_name'] }}</p>
	            <p>{{=search['pd_startDate'] }} ~ {{=search['pd_endDate'] }}</p>
	            <p># {{=search['pd_theme'] }} # {{=search['pd_theme'] }} # {{=search['pd_theme'] }}</p>
             </figcaption>
         </figure>     
		 {{ } }}
	
	`

		$(document).ready(function() {
			$("#div001_in01_in02_in01").click(function() {
				$("#div001_in01_in02_in02").slideToggle("fast");
			})
		});

		function search() {
			var nation = $('.nation').val();
			var location = $('.location').val();
			var land = $('.land').val();
			var startDate = $('.startDate').val();
			var endDate = $('.endDate').val();

			$.ajax({
				type : 'POST',
				/* data : JSON.stringify(param), */
				data : {
					nation : $('.nation').val(),
					location : $('.location').val(),
					keyword : $('.land').val(),
					startDate : $('.startDate').val(),
					endDate : $('.endDate').val(),
				},
				
				url : "http://localhost:8088/trip/board/search.do",
				
				success : function(data) {
					//alert("????????????");
					
					var searchList = JSON.parse(data).searchList;

					if(searchList===""){
						alert('?????? ????????? ??????????????? ??????????????????!')
						
					}else if(searchList==="contentMiss"){
						alert('????????? ????????? ????????????!')

					}else{
					var compiled = _.template(searchTemp,null, {
					   interpolate :  /\{\{\=(.+?)\}\}/g,
					   evaluate: /\{\{(.+?)\}\}/g
					});
					//console.log(searchList);
					var html = compiled({"searchList": searchList});
					//html.trigger("create")
					$('#searchDiv001').html(html);
				}
				}
			
				
				

			});
		}
		
		//user logout
		$("#btnLogout").on("click", function(){
			if(confirm("?????? ???????????? ???????????????????")){
			location.href = "<%=request.getContextPath()%>/user/logout.do";
			alert("???????????????????????????");
			}
		});

		
	</script>



	<div id="div001">
		<div id="div001_in01">
			<div id="div001_in01_in01">
				<a href="<%=request.getContextPath()%>/board/mainPage.do">&nbsp;
					??? &nbsp;</a> 
					<%
		            String u_id = (String) session.getAttribute("u_id");
		            // ???????????? ???,
		            if(u_id == null){%>
		            <a href="<%=request.getContextPath() %>/user/login.do">????????? &nbsp;</a>
		            <a href="<%=request.getContextPath() %>/user/myPage.do?u_id=${member.u_id}">???????????? &nbsp;</a>
					<a href="<%=request.getContextPath()%>/user/cs.do">????????????&nbsp;</a> 
					<a href="<%=request.getContextPath()%>/user/wishlist.do">???&nbsp;</a> 
					<a href="<%=request.getContextPath()%>/user/reserveCheck.do">????????????&nbsp;</a> 
					<a href="<%=request.getContextPath()%>/board/search.do">????????? &nbsp;</a>
		            <%}
		            // ????????? ?????? ???,
		            else{%> 
		              <a id="btnLogout">&nbsp;???????????? &nbsp;</a>
		            <a href="<%=request.getContextPath() %>/user/myPage.do?u_id=${member.u_id}">???????????? &nbsp;</a>
					<a href="<%=request.getContextPath()%>/user/cs.do">????????????&nbsp;</a> 
					<a href="<%=request.getContextPath()%>/user/wishlist.do">???&nbsp;</a> 
					<a href="<%=request.getContextPath()%>/user/reserveCheck.do">????????????&nbsp;</a> 
					<a href="<%=request.getContextPath()%>/board/search.do">????????? &nbsp;</a>
           		    <a style="color: green;"> " ${member.u_id} ??? ???????????????. "</a>
         	   <%}%>
					
					
			</div>
			<div id="div001_in01_in02">
				<div id="div001_in01_in02_in01">
					<img src="http://jjcom0214.cafe24.com/web/OneTrillion/search3.png"
						alt="">
				</div>
				<div id="div001_in01_in02_in02">
					<div style="height: 10px;"></div>
					<div class="div001_in01_in02_in02_in01">&nbsp;?????????</div>
					<div>
						<select name="" class="nation"
							style="margin: 10px; margin-top: 0;">
							<option value="korea">??????</option>
							<option value="abroad">??????</option>
						</select>
					</div>
					<div>
						<select name="" class="location"
							style="margin: 10px; margin-top: 0;">
							<option value="seoul">??????</option>
							<option value="daejeon">??????</option>
							<option value="daegu">??????</option>
							<option value="pusan">??????</option>
							<option value="jeonju">??????</option>
							<option value="jeju">??????</option>
						</select>
					</div>
					<div>
						<select name="" class="land" style="margin: 10px; margin-top: 0;">
							<option value="hanok">??????????????????</option>
							<option value="karosu">????????????</option>
							<option value="sungsan">???????????????</option>
						</select>
					</div>
					<div style="height: 10px;"></div>
					<div class="div001_in01_in02_in02_in01">&nbsp;?????? ?????????</div>
					<div style="margin: 10px; height: 30px;">
						?????? : <input class="startDate" type="date">
					</div>
					<div style="margin: 10px; height: 30px;">
						?????? : <input class="endDate" type="date">
					</div>
					<div style="height: 10px;"></div>
					<div class="div001_in01_in02_in02_in01">&nbsp;??????</div>
					<div style="margin: 10px; height: 30px;">
						???&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;??? : <select
							style="width: 127px; float: right;" name="" id="">
							<option value="">1</option>
							<option value="">2</option>
							<option value="">3</option>
							<option value="">4</option>
						</select>
					</div>
					<div style="margin: 10px; height: 30px;">
						18????????? : <select style="width: 127px; float: right;" name="" id="">
							<option value="">0</option>
							<option value="">1</option>
							<option value="">2</option>
							<option value="">3</option>
							<option value="">4</option>
						</select>
					</div>
					<div style="margin: 10px; height: 30px;">
						???????????? : <select style="width: 127px; float: right;" name="" id="">
							<option value="">0</option>
							<option value="">1</option>
							<option value="">2</option>
							<option value="">3</option>
							<option value="">4</option>
						</select>
					</div>
					<div style="height: 10px;"></div>
					<div class="div001_in01_in02_in02_in01">&nbsp;??????</div>
					<div style="margin: 10px; height: 30px;">
						?????? : <input type="text" value="10000">
					</div>
					<div style="margin: 10px; height: 30px;">
						?????? : <input type="text" value="1000000">
					</div>
					<div style="height: 10px;"></div>
					<div style="height: 60px;">
						<input id="hearderInput001" type="button" value="??????"
							onclick="search()"
							style="width: 210px; margin: 10px; border: none; background-color: black;">
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>