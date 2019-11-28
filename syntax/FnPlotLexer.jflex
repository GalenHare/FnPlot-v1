package fnplot.syntax;

/* Specification for ArithExp tokens */

// user customisations
import java_cup.runtime.*;

// Jlex directives
%%
    
%cup
%public

%class FnPlotLexer

%type java_cup.runtime.Symbol

%eofval{
	return new Symbol(sym.EOF);
%eofval}

%eofclose	false

%char
%line

%{
    public int getChar() {
	return yychar + 1;
    }

    public int getColumn() {
    	return yycolumn + 1;
    }

    public int getLine() {
	return yyline + 1;
    }

    public String getText() {
	return yytext();
    }
%}

nl = [\n\r]

cc = ([\b\f]|{nl})

ws = {cc}|[\t ]

alpha = [a-zA-Z_]

num = [0-9]
real = (0*|[1-9])*\.num+

alphanum = {alpha}|{num}

%%

<YYINITIAL>	{nl}	{
                        //skip newline, but reset char counter
			yycolumn = 0;
			}
<YYINITIAL>	{ws}	{
                        //skip whitespace
			}
<YYINITIAL>	"+"	{return new Symbol(sym.PLUS);}
<YYINITIAL>	"-"	{return new Symbol(sym.MINUS);}
<YYINITIAL>	"*"	{return new Symbol(sym.MUL);}
<YYINITIAL>	"/"	{return new Symbol(sym.DIV);}
<YYINITIAL>	"%"	{return new Symbol(sym.MOD);}
<YYINITIAL>	"="	{return new Symbol(sym.ASSIGN);}

<YYINITIAL>	"("	{return new Symbol(sym.LPAREN);}
<YYINITIAL>	")"	{return new Symbol(sym.RPAREN);}

<YYINITIAL>	"{"	{return new Symbol(sym.LBRACE);}
<YYINITIAL>	"}"	{return new Symbol(sym.RBRACE);}

<YYINITIAL>	","	{return new Symbol(sym.COMMA);}

<YYINITIAL>	"let"	{return new Symbol(sym.LET);}
<YYINITIAL>	"in"	{return new Symbol(sym.IN);}

<YYINITIAL>	";" 	{return new Symbol(sym.SEMI);}

<YYINITIAL>    {num}+ {
	       // INTEGER
	       return new Symbol(sym.INTEGER, 
				 new Integer(yytext()));
	       }
<YYINITIAL> {real} {
			return new Symbol(sym.REAL,
				new Double(yytext()));
			}

<YYINITIAL> -({real}|{num}+) {
			return new Symbol(sym.INTEGER,
				new Double(yytext()));		
			}

<YYINITIAL>	"fun"	{return new Symbol(sym.FUN);}	
<YYINITIAL>	"mapsto"|"->"	{return new Symbol(sym.MAPSTO);}
<YYINITIAL>	"plot"	{return new Symbol(sym.PLOT);}
<YYINITIAL>	"for"	{return new Symbol(sym.FOR);}
<YYINITIAL>	"clear"	{return new Symbol(sym.CLEAR);}
<YYINITIAL>	"^"	{return new Symbol(sym.EXPONENT);}

<YYINITIAL>	":"	{return new Symbol(sym.COLON);}
<YYINITIAL>	"[" {return new Symbol(sym.LSQUARE);}
<YYINITIAL>	"]"	{return new Symbol(sym.RSQUARE);}

<YYINITIAL>    {alpha}{alphanum}* {
	       // VARIABLE
	       return new Symbol(sym.VARIABLE, yytext());
	       }
