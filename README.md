# 09-jflex

## Instalação:
`sudo apt update`

`sudo apt install jflex`

# Alguns métodos e variáveis disponíveis:
 * **int yyline**: armazena o número da linha atual.
 * **int yycolumn**: armazena o número da coluna atual na linha atual.
 * **String yytext()**: método que retorna a sequência de caracteres que foi casada com a regra.
 * **int yylength()**: método que retorna o comprimento da sequência de caracteres que foi casada com a regra.

 Para se usar esses métodos e variáveis, é necessário incluir as diretivas abaixo na seção 2:
 * **%line**: permite usar yyline.
 * **%column**: permite usar yycolumn.

 **OBS**: a diretiva "%class" permite alterar o nome padrão da classe Yylex.java.
 
 Exemplo:
 
 * **%class AnalisadorLexico**
 
 ou
 
 * **%class Scanner**

# Exemplo: 

## Classe Token

<pre>
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
</pre>

## Arquivo: exemplo.flex

<pre>
/* Alguns métodos e variáveis disponíveis:
 * int yyline: armazena o número da linha atual.
 * int yycolumn: armazena o número da coluna atual na linha atual.
 * String yytext(): método que retorna a sequência de caracteres que foi casada com a regra.
 * int yylength(): método que retorna o comprimento da sequência de caracteres que foi casada com a regra.
 */

/* 
 * Definição: seção para código do usuário. 
 */

import token.Token;

%%

/* 
 * Opções e Declarações: seção para diretivas e macros. 
 */

// Diretivas:
%standalone         // Execução independente do analisador sintático.
%line               // Permite usar yyline.
%column             // Permite usar yycolumn.
%class Scanner      // Troca o nome da classe Yylex para Scanner.

%{
  Token token;
%}

// Macros:
BRANCO = [\n| |\t|\r]
PONTOEVIRGULA = ";"
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
{ABREPARENTESE}  { token = new Token(yyline, yycolumn, yytext(), "Abre parêntese"); token.imprimir(); }
{FECHAPARENTESE} { token = new Token(yyline, yycolumn, yytext(), "Fecha parêntese"); token.imprimir(); }
{PONTOEVIRGULA}  { token = new Token(yyline, yycolumn, yytext(), "Ponto e vírgula"); token.imprimir(); }
{ATRIBUICAO}     { token = new Token(yyline, yycolumn, yytext(), "Atribuição"); token.imprimir(); }
{COMPARACAO}     { token = new Token(yyline, yycolumn, yytext(), "Comparação"); token.imprimir(); }   
"if"             { token = new Token(yyline, yycolumn, yytext(), "Palavra reservada if"); token.imprimir(); }
"then"           { token = new Token(yyline, yycolumn, yytext(), "Palavra reservada then"); token.imprimir(); }
{BRANCO}         { token = new Token(yyline, yycolumn, yytext(), "Espaço em branco"); token.imprimir(); }
{ID}             { token = new Token(yyline, yycolumn, yytext(), "Identificador"); token.imprimir(); }
{SOMA}           { token = new Token(yyline, yycolumn, yytext(), "Operador de soma"); token.imprimir(); }
{INTEIRO}        { token = new Token(yyline, yycolumn, yytext(), "Número inteiro"); token.imprimir(); }
.                { token = new Token(yyline, yycolumn, yytext(), "Caracter inválido"); token.dispararExcecao(); }
</pre>

## Arquivo: entrada01.txt:
<pre>
soma = num1 + num2;
if(soma == 7) then
  soma = soma + 3;
<
</pre>

## Arquivo: entrada02.txt:

<pre>
<
soma = num1 + num2;
if(soma == 7) then
  soma = soma + 3;
</pre>

## Execução:
`jflex exemplo.flex`

`javac Scanner.java`

`java Scanner entrada01.txt`

`java Scanner entrada02.txt`

## Jogando a saída num arquivo:
`java Scanner entrada01.txt > saida01.txt`

`java Scanner entrada02.txt > saida02.txt`

# Git
`git add .`

`git commit -m "Exemplo"`

`git push`