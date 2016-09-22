
<%@page import="br.ifsul.edu.dao.IdiomaDAO"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="idiomaDao" scope="session"
             type="IdiomaDAO"/>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Edição de Idiomas</title>
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
        <h1>Edição de Idiomas</h1>
        <h2><%=idiomaDao.getMensagem()%></h2>
        <form name="form" id="form" action="ServletIdioma" method="POST">
            Código: <input type="text" name="id"
                           value="<%= idiomaDao.getObjetoSelecionado().getId() == null
                                   ? "" : idiomaDao.getObjetoSelecionado().getId() %>" size="6"
                                   readonly />
            <br/>Nome: <input type="text" name="nome"
                           value="<%= idiomaDao.getObjetoSelecionado().getNome() == null
                                   ? "" : idiomaDao.getObjetoSelecionado().getNome() %>" size="40"/> 
            <br/>Sigla: <input type="text" name="sigla"
                           value="<%= idiomaDao.getObjetoSelecionado().getSigla()== null
                                   ? "" : idiomaDao.getObjetoSelecionado().getSigla()%>" size="2"/>             
            <br/>
            <input type="button" value="Salvar" name="btnSalvar" onclick="doSalvar()"/>
            <input type="button" value="Cancelar" name="btnCancelar" onclick="doCancelar()"/>
            <input type="hidden" name="acao" id="acao" value=""/>
        </form>
    </body>
</html>
