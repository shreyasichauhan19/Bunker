<!DOCTYPE html>
<html>
<head>
<title>User Account Information</title>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.*" %>
<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>

<%

// Print Customer information
String sql = "select customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password FROM Customer WHERE userid = ?";

NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);

try 
{	
	out.println("<h3>User Account</h3>");
	
	getConnection();
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, userName);	
	ResultSet rst = pstmt.executeQuery();
	
	if (rst.next())
	{
		out.println("<table class=\"table\" border=\"1\">");
		out.println("<tr><th>Id</th><td>"+rst.getString(1)+"</td></tr>");	
		out.println("<tr><th>First Name</th><td>"+rst.getString(2)+"</td></tr>");
		out.println("<tr><th>Last Name</th><td>"+rst.getString(3)+"</td></tr>");
		out.println("<tr><th>Email</th><td>"+rst.getString(4)+"</td></tr>");
		out.println("<tr><th>Phone</th><td>"+rst.getString(5)+"</td></tr>");
		out.println("<tr><th>Address</th><td>"+rst.getString(6)+"</td></tr>");
		out.println("<tr><th>City</th><td>"+rst.getString(7)+"</td></tr>");
		out.println("<tr><th>State</th><td>"+rst.getString(8)+"</td></tr>");
		out.println("<tr><th>Postal Code</th><td>"+rst.getString(9)+"</td></tr>");
		out.println("<tr><th>Country</th><td>"+rst.getString(10)+"</td></tr>");
		out.println("<tr><th>User id</th><td>"+rst.getString(11)+"</td></tr>");		
		out.println("</table>");
	}
}
catch (SQLException ex) 
{ 	out.println(ex); 
}
finally
{	
	closeConnection();	
}
%>

</body>
</html>

