
<%@page import="br.edu.ifsul.modelo.Autor"%>
<%@page import="br.ifsul.edu.dao.AutorDAO"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="autorDao" scope="session"
             type="AutorDAO"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Listagem de autors</title>
    </head>
    <body>
        <a href="../index.html">Início</a>
        <h2>Autors</h2>
        <h2><%=autorDao.getMensagem()%></h2>
        <a href="ServletAutor?acao=incluir">Incluir</a>
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Bibliografia</th>
                    <th>Alterar</th>
                    <th>Excluir</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    for(Autor i : autorDao.getLista()){  // inicio do laço de repetição                  
                %>
                <tr>
                    <td><%=i.getId()%></td>
                    <td><%=i.getNome()%></td>
                    <td><%=i.getBibliografia()%></td>
                    <td><a href="ServletAutor?acao=alterar&id=<%=i.getId()%>">Alterar</a></td>
                    <td><a href="ServletAutor?acao=excluir&id=<%=i.getId()%>">Excluir</a></td>
                </tr>
                <%
                    } // fim do laço de repetição
                %>
            </tbody>
        </table>
    </body>
</html>
