<head>
    <link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-default">
    <div class="container-fluid">
      <div class="navbar-header">
        <a class="navbar-brand" href="index.jsp"><b>Bunker</b></a>
      </div>
      <ul class="nav navbar-nav">
        <!-- <li class="active"><a href="index.jsp">Home</a></li> -->
        <li><a href="listprod.jsp">Begin Shopping</a></li>
        <li><a href="listorder.jsp">List All Orders</a></li>
        <li><a href="showcart.jsp">Show Cart</a></li>
        <li><a href="customer.jsp">User Account Info</a></li>
        <li><a href="admin.jsp">Administrator Info</a></li>
        <li><a href="ship.jsp">Shipment Info</a></li>
        <li><a href="login.jsp">Login</a></li>
        <li><a href="logout.jsp">Logout</a></li>
      </ul>
      <%
	String userName = (String) session.getAttribute("authenticatedUser");
	if (userName != null)
		out.println("<h5>Signed in as: "+userName+"</h5>");
%>
    </div>
  </nav>
</body>