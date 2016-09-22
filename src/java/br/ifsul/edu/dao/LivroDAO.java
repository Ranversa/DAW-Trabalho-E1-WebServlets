package br.ifsul.edu.dao;

import br.edu.ifsul.jpa.EntityManagerUtil;
import br.edu.ifsul.modelo.Livro;
import br.edu.ifsul.util.Util;
import java.io.Serializable;
import java.util.List;
import java.util.Set;
import javax.persistence.EntityManager;
import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;

/**
 *
 * @author Prof. Me. Jorge Luis Boeira Bavaresco
 * @email jorge.bavaresco@passofundo.ifsul.edu.br
 * @organization IFSUL - Campus Passo Fundo
 */
public class LivroDAO implements Serializable {

    // atributo para armazenar o objeto que está sendo editado
    private Livro objetoSelecionado;
    // mensagem para ser exibida ao usuário
    private String mensagem = "";
    // objeto responsável por realizar operações de persistencia
    private EntityManager em;

    public LivroDAO() {
        // inicializando a entityManager
        em = EntityManagerUtil.getEntityManager();
    }

    /**
     * Método que valida um objeto verificando as anotações da bean validation
     * API e joga no atributo mensagem da classe DAO os erros de validação
     *
     * @param obj
     * @return se o objeto possui erros ou não
     */
    public boolean validaObjeto(Livro obj) {
        Validator validador = Validation.buildDefaultValidatorFactory().getValidator();
        Set<ConstraintViolation<Livro>> erros = validador.validate(obj);
        if (erros.size() > 0) { // se a lista de erros for maior que erro o objeto tem erro de validação
            mensagem = "";
            mensagem += "Objeto com erros: <br/>";
            for (ConstraintViolation<Livro> erro : erros) {
                mensagem += "Erro: " + erro.getMessage() + "<br/>";
            }
            return false;
        } else {
            return true;
        }
    }

    /**
     * Método que retorna uma lista de livros do banco de dados
     *
     * @return Lista de livros
     */
    public List<Livro> getLista() {
        return em.createQuery("from Livro order by titulo").getResultList();
    }

    public boolean salvar(Livro obj) {
        try {
            em.getTransaction().begin();
            String isbn = obj.getISBN();
            if (localizar(isbn)==null) { 
                em.persist(obj);
            } else {
                em.merge(obj);
            }
            em.getTransaction().commit();
            mensagem = "Objeto persistido com sucesso!";
            return true;
        } catch (Exception e) { // se gerar um erro a transação deve executar um rollback para desfazer qualquer alteração
            if (em.getTransaction().isActive() == false) {
                em.getTransaction().begin();
            }
            em.getTransaction().rollback();
            mensagem = "Erro ao persistir: " + Util.getMensagemErro(e);
            return false;
        }
    }
    
    public boolean remover(Livro obj){
        try {
            em.getTransaction().begin();
            em.remove(obj);
            em.getTransaction().commit();
            mensagem = "Objeto removido com sucesso!";
            return true;
        } catch(Exception e){
            if (em.getTransaction().isActive() == false){
                em.getTransaction().begin();
            }
            em.getTransaction().rollback();
            mensagem = "Erro ao remover objeto: "+Util.getMensagemErro(e);
            return false;
        }
    }
    
    public Livro localizar(String isbn){
        return em.find(Livro.class, isbn);
    }

    public Livro getObjetoSelecionado() {
        return objetoSelecionado;
    }

    public void setObjetoSelecionado(Livro objetoSelecionado) {
        this.objetoSelecionado = objetoSelecionado;
    }

    public String getMensagem() {
        return mensagem;
    }

    public void setMensagem(String mensagem) {
        this.mensagem = mensagem;
    }

    public EntityManager getEm() {
        return em;
    }

    public void setEm(EntityManager em) {
        this.em = em;
    }
}
