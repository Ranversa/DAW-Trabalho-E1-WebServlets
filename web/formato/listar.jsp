
<%@page import="br.edu.ifsul.modelo.Formato"%>
<%@page import="br.ifsul.edu.dao.FormatoDAO"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="formatoDao" scope="session"
             type="FormatoDAO"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Listagem de formatos</title>
    </head>
    <body>
        <a href="../index.html">Início</a>
        <h2>Formatos</h2>
        <h2><%=formatoDao.getMensagem()%></h2>
        <a href="ServletFormato?acao=incluir">Incluir</a>
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Alterar</th>
                    <th>Excluir</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    for(Formato f : formatoDao.getLista()){  // inicio do laço de repetição                  
                %>
                <tr>
                    <td><%=f.getId()%></td>
                    <td><%=f.getNome()%></td>
                    <td><a href="ServletFormato?acao=alterar&id=<%=f.getId()%>">Alterar</a></td>
                    <td><a href="ServletFormato?acao=excluir&id=<%=f.getId()%>">Excluir</a></td>
                </tr>
                <%
                    } // fim do laço de repetição
                %>
            </tbody>
        </table>
    </body>
</html>
