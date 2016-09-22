
<%@page import="br.edu.ifsul.modelo.Idioma"%>
<%@page import="br.ifsul.edu.dao.IdiomaDAO"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="idiomaDao" scope="session"
             type="IdiomaDAO"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Listagem de idiomas</title>
    </head>
    <body>
        <a href="../index.html">Início</a>
        <h2>Idiomas</h2>
        <h2><%=idiomaDao.getMensagem()%></h2>
        <a href="ServletIdioma?acao=incluir">Incluir</a>
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>UF</th>
                    <th>Alterar</th>
                    <th>Excluir</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    for(Idioma i : idiomaDao.getLista()){  // inicio do laço de repetição                  
                %>
                <tr>
                    <td><%=i.getId()%></td>
                    <td><%=i.getNome()%></td>
                    <td><%=i.getSigla()%></td>
                    <td><a href="ServletIdioma?acao=alterar&id=<%=i.getId()%>">Alterar</a></td>
                    <td><a href="ServletIdioma?acao=excluir&id=<%=i.getId()%>">Excluir</a></td>
                </tr>
                <%
                    } // fim do laço de repetição
                %>
            </tbody>
        </table>
    </body>
</html>
