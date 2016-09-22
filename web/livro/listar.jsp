<%@page import="br.edu.ifsul.modelo.Autor"%>
<%@page import="javafx.scene.chart.PieChart.Data"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="br.edu.ifsul.modelo.Livro"%>
<%@page import="br.ifsul.edu.dao.LivroDAO"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="livroDao" scope="session"
             type="LivroDAO"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Listagem de livros</title>
    </head>
    <body>
        <a href="../index.html">Início</a>
        <h2>Livros</h2>
        <h2><%=livroDao.getMensagem()%></h2>
        <a href="ServletLivro?acao=incluir">Incluir</a>
        <table border="1">
            <thead>
                <tr>
                    <th>ISBN</th>
                    <th>Titulo</th>
                    <th>Autores</th>
                    <th>Editora</th>
                    <th>N Paginas</th>
                    <th>Idioma</th>
                    <th>Data Publicação</th>
                    <th>Ativo</th>
                    <th>Formato</th>
                    <th>Valor</th>
                    <th>Codigo Barras</th>
                    <th>Catalogo</th>
                    <th>Data Cadastro</th>
                    <th>Resumo</th>
                    <th>Alterar</th>
                    <th>Excluir</th>
                </tr>
            </thead>
            <tbody>
                <%
                    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                    String dataP = "";
                    String autores ="";
                    String dataC = "";
                    for (Livro l : livroDao.getLista()) {  // inicio do laço de repetição   
                        Calendar c = l.getDataPublicacao();
                        dataP = sdf.format(c.getTime());
                        for(Autor a : l.getAutorLivro()){
                            autores += a.getNome()+" ";
                        }
                        Calendar cp = l.getDataCadastro();
                        dataC = sdf.format(cp.getTime());
                %>
                <tr>
                    <td><%=l.getISBN()%></td>
                    <td><%=l.getTitulo()%></td>
                    <td><%=autores%></td>
                    <td><%=l.getEditora()%></td>
                    <td><%=l.getNumeroPaginas()%></td>
                    <td><%=l.getIdioma().getNome()%></td>
                    <td><%=dataP%></td>
                    <td><%=l.getAtivo()%></td>
                    <td><%=l.getFormato().getNome()%></td>
                    <td><%=l.getValor()%></td>
                    <th><%=l.getCodigoBarras()%></th>
                    <th><%=l.getCatalogo().getNome()%></th>
                    <th><%=dataC%></th>
                    <th><%=l.getResumo()%></th>
                    <td><a href="ServletLivro?acao=alterar&id=<%=l.getISBN()%>">Alterar</a></td>
                    <td><a href="ServletLivro?acao=excluir&id=<%=l.getISBN()%>">Excluir</a></td>
                </tr>
                <%
                    } // fim do laço de repetição
%>
            </tbody>
        </table>
    </body>
</html>
