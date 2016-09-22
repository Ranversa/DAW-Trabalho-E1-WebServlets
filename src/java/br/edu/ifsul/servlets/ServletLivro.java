package br.edu.ifsul.servlets;

import br.edu.ifsul.jpa.EntityManagerUtil;
import br.edu.ifsul.modelo.Autor;
import br.edu.ifsul.modelo.Livro;
import br.ifsul.edu.dao.CatalogoDAO;
import br.ifsul.edu.dao.FormatoDAO;
import br.ifsul.edu.dao.IdiomaDAO;
import br.ifsul.edu.dao.LivroDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import javax.persistence.EntityManager;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author jorge
 */
@WebServlet(name = "ServletLivro", urlPatterns = {"/livro/ServletLivro"})
public class ServletLivro extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        EntityManager em;
        em = EntityManagerUtil.getEntityManager();
        LivroDAO dao = (LivroDAO) request.getSession().getAttribute("livroDao");
        if (dao == null) {
            dao = new LivroDAO();
        }
        IdiomaDAO daoIdioma = (IdiomaDAO) request.getSession().getAttribute("idiomaDao");
        if (daoIdioma == null) {
            daoIdioma = new IdiomaDAO();
        }
        FormatoDAO daoFormato = (FormatoDAO) request.getSession().getAttribute("formatoDao");
        if (daoFormato == null) {
            daoFormato = new FormatoDAO();
        }
        CatalogoDAO daoCatalogo = (CatalogoDAO) request.getSession().getAttribute("catalogoDao");
        if (daoCatalogo == null) {
            daoCatalogo = new CatalogoDAO();
        }
        String tela = "";
        String acao = request.getParameter("acao");
        if (acao == null) {
            tela = "listar.jsp";
        } else if (acao.equals("incluir")) {
            dao.setObjetoSelecionado(new Livro());
            dao.setMensagem("");
            tela = "formulario.jsp";
        } else if (acao.equals("alterar")) {
            // carregando o objeto do banco pelo id que veio por parametro
            String isbn = request.getParameter("isbn");
            dao.setObjetoSelecionado(dao.localizar(isbn));
            dao.setMensagem("");
            tela = "formulario.jsp";
        } else if (acao.equals("excluir")) {
            String isbn = request.getParameter("isbn");
            Livro objeto = dao.localizar(isbn);
            if (objeto != null) {
                dao.remover(objeto);
                tela = "listar.jsp";
            }
        } else if (acao.equals("salvar")) {
            String isbn = null;
            try {
                isbn = request.getParameter("isbn");
            } catch (Exception e) {
                e.printStackTrace();
            }
            // ATRIBUINDO OS DADOS QUE VIERAM VIA REQUISIÇÃO
            
            dao.getObjetoSelecionado().setISBN(isbn);
            dao.getObjetoSelecionado().setTitulo(request.getParameter("titulo"));
            dao.getObjetoSelecionado().setEditora(request.getParameter("editora"));
            dao.getObjetoSelecionado().setResumo(request.getParameter("resumo"));
            dao.getObjetoSelecionado().setAtivo(Boolean.parseBoolean(request.getParameter("ativo")));
            dao.getObjetoSelecionado().setCodigoBarras(request.getParameter("codigoBarras"));
            dao.getObjetoSelecionado().setNumeroPaginas(Integer.parseInt(request.getParameter("numeroPaginas")));
            dao.getObjetoSelecionado().setValor(Double.parseDouble(request.getParameter("valor")));
            
            // CONVERTENDO AS DATAS
            
            Calendar dataPublicacao = Calendar.getInstance();
            try {
                String data = request.getParameter("dataPublicacao");
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                dataPublicacao.setTime(sdf.parse(data));
            } catch (ParseException e) {
                e.printStackTrace();
            }
            dao.getObjetoSelecionado().setDataPublicacao(dataPublicacao);
            Calendar dataCadastro = Calendar.getInstance() ;
            try {
                String data = request.getParameter("dataCadastro");
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                dataCadastro.setTime(sdf.parse(data));
            } catch (ParseException e) {
                e.printStackTrace();
            }
            dao.getObjetoSelecionado().setDataCadastro(dataCadastro);
            
            // CAPTURANDO OS OBJETOS DAS CHAVES ESTRANGEIRAS
            
            Integer idIdioma = null;
            try {
                idIdioma = Integer.parseInt(request.getParameter("idIdioma"));
            } catch (Exception e) {
                System.out.println("Erro ao converter Idioma");
            }
            dao.getObjetoSelecionado().setIdioma(daoIdioma.localizar(idIdioma));
            Integer idFormato = null;
            try {
                idFormato = Integer.parseInt(request.getParameter("idFormato"));
            } catch (Exception e) {
                System.out.println("Erro ao converter Formato");
            }
            dao.getObjetoSelecionado().setFormato(daoFormato.localizar(idFormato));
            Integer idCatalogo = null;
            try{
                idCatalogo = Integer.parseInt(request.getParameter("idCatalogo"));
            }catch (Exception e) {
                System.out.println("Erro ao adicionar no catalogo");
            }
            daoCatalogo.setObjetoSelecionado(daoCatalogo.localizar(idCatalogo));
            daoCatalogo.getObjetoSelecionado().adicionarLivro(dao.getObjetoSelecionado());
            
            // teste se os dados o objeto são validos
            if (dao.validaObjeto(dao.getObjetoSelecionado())) {
                dao.salvar(dao.getObjetoSelecionado()); // se são validos tento salvar
                tela = "listar.jsp";
            } else {
                tela = "formulario.jsp";
            }
        } else if (acao.equals("cancelar")) {
            dao.setMensagem("");
            tela = "listar.jsp";
        }
        // atualizar o dao na sessão
        request.getSession().setAttribute("livroDao", dao);
        request.getSession().setAttribute("idiomaDao", daoIdioma);
        request.getSession().setAttribute("formatoDao", daoFormato);
        // redireciona para a tela
        response.sendRedirect(tela);

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
