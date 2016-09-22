package br.edu.ifsul.servlets;


import br.edu.ifsul.modelo.Autor;
import br.ifsul.edu.dao.AutorDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author jorge
 */
@WebServlet(name = "ServletAutor", urlPatterns = {"/autor/ServletAutor"})
public class ServletAutor extends HttpServlet {

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
        // capturando o DAO da sessão
        AutorDAO dao = (AutorDAO) request.getSession().getAttribute("autorDao");
        // caso o DAO seja nulo (não existe na sessão) ele deve ser criado
        if (dao == null){
            dao = new AutorDAO();
        }
        String tela = ""; // armazena a tela que o servlet irá redirecionar após o processamento
        // capturar a operação a ser executada        
        String acao = request.getParameter("acao");
        // conforme a acao que veio da tela será executado um processamento diferente
        if (acao == null){
            tela = "listar.jsp";
        } else if (acao.equals("incluir")){
            dao.setObjetoSelecionado(new Autor());
            dao.setMensagem("");
            tela = "formulario.jsp";
        } else if(acao.equals("alterar")){
            // carregando o objeto do banco pelo id que veio por parametro
            Integer id = Integer.parseInt(request.getParameter("id"));
            dao.setObjetoSelecionado(dao.localizar(id));
            dao.setMensagem("");
            tela = "formulario.jsp";                    
        } else if (acao.equals("excluir")){
            Integer id = Integer.parseInt(request.getParameter("id"));
            Autor objeto = dao.localizar(id);
            if (objeto != null){
                dao.remover(objeto);
                tela = "listar.jsp";
            }
        } else if (acao.equals("salvar")){
            Integer id = null;
            try {
                id = Integer.parseInt(request.getParameter("id"));
            } catch (Exception e){
                e.printStackTrace();
            }
            // atribuindo os dados que vieram na requisição ao objeto selecionado do DAO
            dao.getObjetoSelecionado().setId(id);
            dao.getObjetoSelecionado().setNome(request.getParameter("nome"));
            dao.getObjetoSelecionado().setBibliografia(request.getParameter("bibliografia"));
            // teste se os dados o objeto são validos
            if (dao.validaObjeto(dao.getObjetoSelecionado())){
                dao.salvar(dao.getObjetoSelecionado()); // se são validos tento salvar
                tela = "listar.jsp";
            } else {
                tela = "formulario.jsp";
            }            
        } else if (acao.equals("cancelar")){
            dao.setMensagem("");
            tela = "listar.jsp";
        }
        // atualizar o dao na sessão
        request.getSession().setAttribute("autorDao", dao);
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
