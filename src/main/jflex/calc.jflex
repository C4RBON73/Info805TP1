package fr.usmb.compilation.jflex.calc.standalone;

import java.util.LinkedList;
import java.io.*;

%%

%class Calc

%public
%integer
%unicode

%{
    private LinkedList<Integer> pile = new LinkedList<>();
    
    public void printPile() {
        System.out.print("pile: ");
        java.util.Iterator<Integer> it = pile.descendingIterator();
        while (it.hasNext()){
            System.out.print(it.next() + " ");
        }
        System.out.println();
    }
    public static void main(String[] args) {
        try {
            Calc scanner; 
            if (args.length > 1) {
                scanner = new Calc(new FileReader(args[1]));
            } else {
                scanner = new Calc(new InputStreamReader(System.in));
            }
            scanner.yylex();
            scanner.printPile();
        } catch (IOException e) {
          System.out.println("Unexpected exception:");
          e.printStackTrace();
        }
    }
%}

espace     = \s+
uint       = ([1-9][0-9]*)|0
entier     = (\+|-)?{uint}

%%

"="         { System.out.println("--> " + pile.peek()); }
"+"         { int op2 = pile.pop(); int op1 = pile.pop(); pile.push(op1 + op2); }
"-"         { int op2 = pile.pop(); int op1 = pile.pop(); pile.push(op1 - op2); }
"/"         { int op2 = pile.pop(); int op1 = pile.pop(); pile.push(op1 / op2); }
"*"         { int op2 = pile.pop(); int op1 = pile.pop(); pile.push(op1 * op2); }
"n"         { int op1 = pile.pop(); pile.push(- op1);  /* moins unaire */       }
{entier}    { pile.push(Integer.parseInt(yytext())); }
{espace}    { /* espace : pas d'action */            }
.           { System.out.println("caractere imprevu : " + yytext()); }
