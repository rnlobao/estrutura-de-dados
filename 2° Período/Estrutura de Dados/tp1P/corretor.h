# ifndef corretor_h
# define corretor_h

//TAD dos alunos
typedef struct alunos TADalunos;
//Ler ordem do arquivo
void lerOrdem(int *ordem);
//ALocar os alunos dinamicamente
TADalunos *alocaAlunos(TADalunos *A, int ordem);
//Desalocar os alunos
TADalunos *desalocaAlunos(TADalunos *A);
//Ler os dados para colocar na struct
void lerAlunos(TADalunos *A, int ordem);
//Contar quantos corretos tem
int contandocorretos(TADalunos *A, int ordem);
//Calcular o tempo total
int tempototal(TADalunos *A, int ordem);
//printar a saida correta
void printsaida(int s, int p);

# endif