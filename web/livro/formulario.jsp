<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.List"%>
<%@page import="br.edu.ifsul.modelo.Autor"%>
<%@page import="br.ifsul.edu.dao.AutorDAO"%>
<%@page import="br.ifsul.edu.dao.CatalogoDAO"%>
<%@page import="br.edu.ifsul.modelo.Catalogo"%>
<%@page import="br.edu.ifsul.modelo.Formato"%>
<%@page import="br.edu.ifsul.modelo.Idioma"%>
<%@page import="br.ifsul.edu.dao.FormatoDAO"%>
<%@page import="br.ifsul.edu.dao.IdiomaDAO"%>
<%@page import="br.ifsul.edu.dao.LivroDAO"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="livroDao" scope="session" type="LivroDAO" class="br.ifsul.edu.dao.LivroDAO"></jsp:useBean>
<jsp:useBean id="idiomaDao" scope="session" type="IdiomaDAO" class="br.ifsul.edu.dao.IdiomaDAO"></jsp:useBean>
<jsp:useBean id="formatoDao" scope="session" type="FormatoDAO" class="br.ifsul.edu.dao.FormatoDAO"></jsp:useBean>
<jsp:useBean id="autorDao" scope="session" type="AutorDAO" class="br.ifsul.edu.dao.AutorDAO"></jsp:useBean>
<jsp:useBean id="catalogoDao" scope="session" type="CatalogoDAO" class="br.ifsul.edu.dao.CatalogoDAO"></jsp:useBean>

    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
            <title>Edição de Livros</title>
            <script>
                function doSalvar() {
                    document.getElementById("acao").value = 'salvar';
                    document.getElementById("form").submit();
                }
                function doCancelar() {
                    document.getElementById("acao").value = 'cancelar';
                    document.getElementById("form").submit();
                }
            </script>                        
        </head>
        <body>
            <h1>Edição de Livros</h1>
            <h2><%=livroDao.getMensagem()%></h2>
        <form name="form" id="form" action="ServletLivro" method="POST">
            ISBN: <input type="text" name="isbn"
                         value="<%= livroDao.getObjetoSelecionado().getISBN() == null
                                 ? "" : livroDao.getObjetoSelecionado().getISBN()%>" size="20"/>
            <br/>Titulo: <input type="text" name="titulo"
                                value="<%= livroDao.getObjetoSelecionado().getTitulo() == null
                                        ? "" : livroDao.getObjetoSelecionado().getTitulo()%>" size="40"/> 
        </select>
        <br/>Editora: <input type="text" name="editora"
                             value="<%= livroDao.getObjetoSelecionado().getEditora() == null
                                     ? "" : livroDao.getObjetoSelecionado().getEditora()%>" size="40"/>  
        <br/>N paginas: <input type="text" name="numeroPaginas"
                               value="<%= livroDao.getObjetoSelecionado().getNumeroPaginas() == null
                                       ? "" : livroDao.getObjetoSelecionado().getNumeroPaginas()%>" size="40"/> 
        <br/>Idioma:
        <select name="idIdioma" id="idIdioma">
            <%
                for (Idioma e : idiomaDao.getLista()) {
                    String selected = "";
                    if (livroDao.getObjetoSelecionado().getIdioma() != null) {
                        if (livroDao.getObjetoSelecionado().getIdioma().getId().equals(e.getId())) {
                            selected = "selected ";
                        }
                    }
            %>
            <option value="<%=e.getId()%>" <%=selected%> ><%=e.getNome()%></option>
            <%
                }
            %>
        </select>
        <br/>Data Publicação:
        <%
            String dataP = "";
            String dataC = "";
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            if (livroDao.getObjetoSelecionado().getDataPublicacao() != null) {
                Calendar dp = livroDao.getObjetoSelecionado().getDataPublicacao();
                dataP = sdf.format(dp.getTime());
                Calendar dc = livroDao.getObjetoSelecionado().getDataCadastro();
                dataC = sdf.format(dc.getTime());
            }
        %>
        <input type="text" name="dataPublicacao" id="dataPublicacao"
               value="<%= livroDao.getObjetoSelecionado().getDataPublicacao() == null
                       ? "" : dataP%>"/>
        <br/>Ativo: 
        <input type="radio" name="ativo" value="true" 
               <%String checked = "false";
                   if (livroDao.getObjetoSelecionado().getAtivo() != null) {
                       if (livroDao.getObjetoSelecionado().getAtivo()) {
                           checked = "true";%>checked="<%=checked%>"<%
                                   }
                               }%>  > Ativo
        <input type="radio" name="ativo" value="false"
               <%if (livroDao.getObjetoSelecionado().getAtivo() != null) {
                       if (!livroDao.getObjetoSelecionado().getAtivo()) {
                           checked = "true";%>checked="<%=checked%>"<%
                                   }
                               }%> > Desativado
        <br/>Formato:
        <select name="idFormato" id="idFormato">
            <%
                for (Formato f : formatoDao.getLista()) {
                    String selected = "";
                    if (livroDao.getObjetoSelecionado().getFormato() != null) {
                        if (livroDao.getObjetoSelecionado().getFormato().getId().equals(f.getId())) {
                            selected = "selected ";
                        }
                    }
            %>
            <option value="<%=f.getId()%>" <%=selected%> ><%=f.getNome()%></option>
            <%
                }
            %>
        </select>
        <br/>Valor: <input type="text" name="valor" id="valor"
                           value="<%= livroDao.getObjetoSelecionado().getValor() == null
                                   ? "" : livroDao.getObjetoSelecionado().getValor()%>" size="12"/> 
        <br/>Codigo de Barras: <input type="text" name="codigoBarras"
                                      value="<%= livroDao.getObjetoSelecionado().getCodigoBarras() == null
                                              ? "" : livroDao.getObjetoSelecionado().getCodigoBarras()%>" size="20"/> 

        <br/>Catalogo:
        <select name="idCatalogo" id="idCatalogo">
            <%
                for (Catalogo c : catalogoDao.getLista()) {
                    String selected = "";
                    if (livroDao.getObjetoSelecionado().getCatalogo() != null) {
                        if (livroDao.getObjetoSelecionado().getCatalogo().getId().equals(c.getId())) {
                            selected = "selected ";
                        }
                    }
            %>
            <option value="<%=c.getId()%>" <%=selected%> ><%=c.getNome()%></option>
            <%
                }
            %>
        </select>
        <br/>Data Cadastro:
        <input type="text" name="dataCadastro" id="dataCadastro"
               value="<%= livroDao.getObjetoSelecionado().getDataCadastro() == null
                       ? "" : dataC%>"/>
        <br/>Resumo:<br/>
        <input type="text" name="resumo" id="resumo"
               value = "<%=livroDao.getObjetoSelecionado().getResumo() == null
                       ? "" : livroDao.getObjetoSelecionado().getResumo()%>" size="200"/>
        <br/>
        <input type="button" value="Salvar" name="btnSalvar" onclick="doSalvar()"/>
        <input type="button" value="Cancelar" name="btnCancelar" onclick="doCancelar()"/>
        <input type="hidden" name="acao" id="acao" value=""/>
    </form>
</body>
</html>
