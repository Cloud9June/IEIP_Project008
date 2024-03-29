<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.sungil.database.DBConnect"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	StringBuffer sb = new StringBuffer();
	sb.append("select teacher_code, teacher_name, class_name,");
	sb.append(" '￦'||to_char(class_price, '999,999') class_price,");
	sb.append(" substr(teach_resist_date,1,4)||'년'||substr(teach_resist_date,5,2)||'월'||substr(teach_resist_date,7,2)||'일' teach_resist_date");
	sb.append(" from tbl_teacher_202201");
	
	String sql = sb.toString();
	
	Connection conn = DBConnect.getConnection();
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/style.css?ver=1">
</head>
<body>
	<jsp:include page="../include/header.jsp"></jsp:include>
	<jsp:include page="../include/nav.jsp"></jsp:include>

	<section id="section">
		<h2>강사조회</h2>
		<table>
			<thead>
				<tr>
					<th>강사코드</th>
					<th>강사명</th>
					<th>강의명</th>
					<th>수강료</th>
					<th>강사자격취득일</th>
				</tr>
			</thead>
			<tbody>
				<%
					while(rs.next()) {
				%>
				<tr>
					<td><%= rs.getString(1) %></td>
					<td><%= rs.getString(2) %></td>
					<td><%= rs.getString(3) %></td>
					<td><%= rs.getString(4) %></td>
					<td><%= rs.getString(5) %></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
	</section>

	<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>
<%
	rs.close();
	pstmt.close();
	conn.close();
%>