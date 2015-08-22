%{
    #include "sqlparser.tab.h"
    #define YY_DECL extern "C" int yylex()
    int line_num = 0;
%}

%option noyywrap

%%

SELECT  { 
    return SELECT; 
}

FROM    { 
    return FROM; 
}

\n  {
    ++line_num;
}

; {
    return END;
}

[a-z]+ {
    yylval.sval = strdup(yytext);
    return STRING;
}

%%
