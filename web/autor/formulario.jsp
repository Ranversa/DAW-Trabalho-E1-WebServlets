
<%@page import="br.ifsul.edu.dao.AutorDAO"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="autorDao" scope="session"
             type="AutorDAO"/>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Edição de Autors</title>
        <script>
            function doSalvar(){
                document.getElementById("acao").value = 'salvar';
                document.getElementById("form").submit();
            }
            function doCancelar(){
                document.getElementById("acao").value = 'cancelar';
                document.getElementById("form").submit();
            }            
        </script>                        
    </head>
    <body>
        <h1>Edição de Autores</h1>
        <h2><%=autorDao.getMensagem()%></h2>
        <form name="form" id="form" action="ServletAutor" method="POST">
            Código: <input type="text" name="id"
                           value="<%= autorDao.getObjetoSelecionado().getId() == null
                                   ? "" : autorDao.getObjetoSelecionado().getId() %>" size="6"
                                   readonly />
            <br/>Nome: <input type="text" name="nome"
                           value="<%= autorDao.getObjetoSelecionado().getNome() == null
                                   ? "" : autorDao.getObjetoSelecionado().getNome() %>" size="40"/> 
            <br/>Bibliografia: <input type="text" name="bibliografia"
                           value="<%= autorDao.getObjetoSelecionado().getBibliografia()== null
                                   ? "" : autorDao.getObjetoSelecionado().getBibliografia()%>" size="450"/>             
            <br/>
            <input type="button" value="Salvar" name="btnSalvar" onclick="doSalvar()"/>
            <input type="button" value="Cancelar" name="btnCancelar" onclick="doCancelar()"/>
            <input type="hidden" name="acao" id="acao" value=""/>
        </form>
    </body>
</html>
