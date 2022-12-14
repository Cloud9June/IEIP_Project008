<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.sungil.database.DBConnect"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	StringBuffer sb = new StringBuffer();
	sb.append("select t.teacher_code, t.class_name, t.teacher_name, '￦'||to_char(sum(c.tuition), '999,999') tuition");
	sb.append(" from tbl_teacher_202201 t, tbl_class_202201 c");
	sb.append(" where t.teacher_code = c.teacher_code");
	sb.append(" group by t.teacher_code, t.class_name, t.teacher_name");
	sb.append(" order by t.teacher_code");
	
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
<link rel="stylesheet" href="../css/style.css?ver=5">
</head>
<body>
	<jsp:include page="../include/header.jsp"></jsp:include>
	<jsp:include page="../include/nav.jsp"></jsp:include>

	<section id="section">
		<h2>강사매출현황</h2>
		<table> 
			<thead>
				<tr>
					<th>강사코드</th>
					<th>강의명</th>
					<th>강사명</th>
					<th>총매출</th>
				</tr>
			</thead>
			<tbody>
				<%
					while(rs.next()) {
				%>
				<tr>
					<td><%= rs.getString(1) %></td>
					<td><%= rs.getString(2) %></td>
					<td class="right"><%= rs.getString(3) %></td>
					<td class="right"><%= rs.getString(4) %></td>
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