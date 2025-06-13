/* Alguns métodos e variáveis disponíveis:
 * int yyline: armazena o número da linha atual.
 * int yycolumn: armazena o número da coluna atual na linha atual.
 * String yytext(): método que retorna a sequência de caracteres que foi casada com a regra.
 * int yylength(): método que retorna o comprimento da sequência de caracteres que foi casada com a regra.
 */

/* 
 * Definição: seção para código do usuário. 
 */

class Token {
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

%%

/* 
 * Opções e Declarações: seção para diretivas e macros. 
 */

// Diretivas:
%standalone         // Execução independente do analisador sintático.
%line               // Permite usar yyline.
%column             // Permite usar yycolumn.
%class njava    // Troca o nome da classe Yylex para Scanner.

%{
  Token token;
%}

// Macros:
BRANCO = [\n| |\t|\r]
PONTO = "."
VIRGULA = ","
PONTOEVIRGULA = ";"
DOISPONTOS = ":"
ABRECHAVE ="{"
FECHACHAVE = "}"
ABRECOLCHETE = "["
FECHACOLCHETE = "]"
ABREPARENTESE = "("
FECHAPARENTESE = ")"
SOMA = "+"
ATRIBUICAO = "="
COMPARACAO = "=="
INTEIRO = 0|[1-9][0-9]*
ID = [_|a-z|A-Z][a-z|A-Z|0-9|_]*

%%

/*  
 * Regras e Ações Associadas: seção de instruções para
 * o analisador léxico. 
 */
{PONTO}          { token = new Token(yyline, yycolumn, yytext(), "Ponto"); token.imprimir();}
{VIRGULA}        { token = new Token(yyline, yycolumn, yytext(), "Virgula"); token.imprimir(); }
{ABRECOLCHETE}   { token = new Token(yyline, yycolumn, yytext(), "Abre colchete"); token.imprimir(); }
{FECHACOLCHETE}  { token = new Token(yyline, yycolumn, yytext(), "Fecha colchete"); token.imprimir(); }
{ABREPARENTESE}  { token = new Token(yyline, yycolumn, yytext(), "Abre parêntese"); token.imprimir(); }
{FECHAPARENTESE} { token = new Token(yyline, yycolumn, yytext(), "Fecha parêntese"); token.imprimir(); }
{ABRECHAVE}      { token = new Token(yyline, yycolumn, yytext(), "Abre chave"); token.imprimir(); }
{FECHACHAVE}     { token = new Token(yyline, yycolumn, yytext(), "Fecha chave"); token.imprimir(); }
{PONTOEVIRGULA}  { token = new Token(yyline, yycolumn, yytext(), "Ponto e vírgula"); token.imprimir(); }
{DOISPONTOS}     { token = new Token(yyline, yycolumn, yytext(), "Dois pontos"); token.imprimir(); }
{ATRIBUICAO}     { token = new Token(yyline, yycolumn, yytext(), "Atribuição"); token.imprimir(); }
{COMPARACAO}     { token = new Token(yyline, yycolumn, yytext(), "Comparação"); token.imprimir(); }   
"if"             { token = new Token(yyline, yycolumn, yytext(), "Palavra reservada if"); token.imprimir(); }
"then"           { token = new Token(yyline, yycolumn, yytext(), "Palavra reservada then"); token.imprimir(); }
"public"         { token = new Token(yyline, yycolumn, yytext(), "Palavra reservada public"); token.imprimir(); }
"class"          { token = new Token(yyline, yycolumn, yytext(), "Palavra reservada class"); token.imprimir(); }
"void"           { token = new Token(yyline, yycolumn, yytext(), "Palavra reservada void"); token.imprimir(); }
"int"            { token = new Token(yyline, yycolumn, yytext(), "Palavra reservada int"); token.imprimir(); }
"for"            { token = new Token(yyline, yycolumn, yytext(), "Palavra reservada for"); token.imprimir(); }
{BRANCO}         { token = new Token(yyline, yycolumn, yytext(), "Espaço em branco"); token.imprimir(); }
{ID}             { token = new Token(yyline, yycolumn, yytext(), "Identificador"); token.imprimir(); }
{SOMA}           { token = new Token(yyline, yycolumn, yytext(), "Operador de soma"); token.imprimir(); }
{INTEIRO}        { token = new Token(yyline, yycolumn, yytext(), "Número inteiro"); token.imprimir(); }
.                { token = new Token(yyline, yycolumn, yytext(), "Caracter inválido"); token.dispararExcecao(); }