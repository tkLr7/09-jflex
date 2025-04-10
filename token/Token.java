package token;

public class Token {
    private int linha;
    private int coluna;
    private String lexema;
    private String descricao;
  
    public Token(int linha, int coluna, String lexema, String descricao) {
      this.linha = linha;
      this.coluna = coluna;
      this.lexema = lexema;
      this.descricao = descricao;
    }
    
    public int getLinha() {return linha;}
    public void setLinha(int linha) {this.linha = linha;}
  
    public int getColuna() {return coluna;}
    public void setColuna(int coluna) {this.coluna = coluna;}
  
    public String getLexema() {return lexema;}
    public void setLexema(String lexema) {this.lexema = lexema;}
  
    public String getDescricao() {return descricao;}
    public void setDescricao(String descricao) {this.descricao = descricao;}
  
    public void imprimir() {
      System.out.println("[" + linha + "]" + "[" + coluna + "] " + lexema + ": " + descricao + ".");
    }
  
    public void dispararExcecao() {
      imprimir();
      throw new RuntimeException(descricao + ": " + lexema + "");
    }
  }
  