<%@page import="com.sungil.database.DBConnect"%>
<%@page import="java.sql.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%
String sql1 = "select c_no, c_name from tbl_member_202201";
String sql2 = "select teacher_code, class_name from tbl_teacher_202201";

Connection con = DBConnect.getConnection();
PreparedStatement pstmt1 = con.prepareStatement(sql1);
PreparedStatement pstmt2 = con.prepareStatement(sql2);

ResultSet rs1 = pstmt1.executeQuery();
ResultSet rs2 = pstmt2.executeQuery();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/style.css">
<script type="text/javascript">
    function frmchk() {
       var cls = document.classData;

      if(!cls.resist_month.value) {
         alert("수강월이 입력되지 않았습니다.");
         cls.resist_month.focus();
         return false;
      }
      if(!cls.c_name.value=="none") {
         alert("회원명이 선택되지 않았습니다.");
         cls.c_name.focus();
         return false;
      }
      if(!cls.class_area.value) {
         alert("강의장소 입력되지 않았습니다.");
         cls.class_area.focus();
         return false;
      }
      if(!cls.class_name.value) {
         alert("강의명 입력되지 않았습니다.");
         cls.class_name.focus();
         return false;
      }
   }

    function vDisplay(code) {
       alert(code);
      document.classData.c_no.value = code;
      document.classData.class_name.value = "none";
      document.classData.tuition.value = "";
   }
   
   function cal(tcode) {
      var mbr = document.classData.c_no.value;
      
      if(!mbr) {
         alert("회원명을 먼저 선택하세요.");
         document.classData.class_name[0].selected = true;
         document.classData.c_name.focus();
      } else {
         var salesPrice = 0;
         
         switch(tcode) {
         case "100":
            salePrice = 100000;
            break;
         case "200":
            salePrice = 200000;
            break;
         case "300":
            salePrice = 300000;
            break;
         case "400":
            salePrice = 400000;
            break;
         }
         
         if(mbr.charAt(0)=='2') {
            alert("수강료가 50% 할인되었습니다.");
            salePrice = salePrice/2;
         }
         
         document.classData.tuition.value = salePrice;
      }
   }
 
   function re() {
      alert("처음부터 다시씁니다.");
      document.classData.reset();
      document.classData.resist_month.focus();
   }
</script>
</head>
<body>
   <jsp:include page="../include/header.jsp"></jsp:include>
   <jsp:include page="../include/nav.jsp"></jsp:include>

   <section id="section">
      <h2>수강신청</h2>

      <form action="class_reg_p.jsp" method="post" name="classData"
         onsubmit="return frmchk()">
         <table class="inputTbl">
            <tr>
               <th>수강월</th>
               <td><input type="text" name="resist_month"><span>
                     2022년03월 예)202203</span></td>
            </tr>
            <tr>
               <th>회원명</th>
               <td>
               <select name="c_name" onchange="vDisplay(this.value)">
                     <option value="none">회원명</option>
                     <%
                     while (rs1.next()) {
                     %>
                     <option value="<%=rs1.getString("c_no")%>"><%=rs1.getString("c_name")%></option>
                     <%
                     }
                     %>
               </select></td>
            </tr>
            <tr>
               <th>회원번호</th>
               <td><input type="text" name="c_no" readonly><span>
                     예)10001</span></td>
            </tr>
            <tr>
               <th>강의장소</th>
               <td><input type="text" name="class_area"></td>
            </tr>
            <tr>
               <th>강의명</th>
               <td>
                  <select name="class_name" onchange="cal(this.value)">
                  <option value="">강의신청</option>
                  <% while(rs2.next()) { %>
                     <option value="<%= rs2.getString("teacher_code")%>"><%= rs2.getString("class_name")%></option>
                  <% } %>
                  </select>
               </td>
            </tr>
            <tr>
               <th>수강료</th>
               <td><input type="text" name="tuition" readonly><span>
                     원</span></td>
            </tr>
            <tr>
               <th colspan="2">
                  <input type="submit" value="수강신청">
                  <input type="button" value="다시쓰기" onclick="return re()">
               </th>
            </tr>
         </table>
      </form>

   </section>

   <jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>