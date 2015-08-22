%{
    #include <iostream>
    #include <cstdio>

    extern "C" int yylex();
    extern "C" int yyparse();
    extern "C" FILE * yyin;
    extern int line_num;

    void yyerror(const char *s);
%}

%union {
    char *sval;
}

%token SELECT
%token FROM
%token <sval> STRING

%%

sqlparser: SELECT STRING FROM STRING
         {
            std::cout << "Selecting Column " << $2 << " from Table " << $4 << std::endl;
         }
         
%%

int main (const int argc, const char ** argv) {
    if (argc < 2) {
        yyin = stdin;
    } else {
        FILE *infile = fopen(argv[1], "r");
        if (!infile) {
            std::cerr <<"Error reading file " << argv[1] << std::endl;
            return -1;
        }
        yyin = infile;
    }
    do {
        yyparse();
    } while (!feof(yyin));
    return 0;
}

void yyerror (const char *s) { 
    std::cerr << "Parse error on line " << line_num << " ! Message : " << s << std::endl;
    exit(-1);
}
