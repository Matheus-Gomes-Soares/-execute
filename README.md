# EXECUTE 

Um script Bash simples para executar diferentes arquivos rapidamente no Unix/Linux.

## Descrição

O script:

-  Executa todos os arquivos cujo nome começa com um dos parâmetro (como no padrão nome*).
-  Executa arquivos binários diretamente (`-x`);
-  Roda scripts Python e Go (`-r`);
-  Evita rodar scripts se um executável equivalente já tiver rodado (se rodou code1 não roda code1.go);
-  Tem uma tela de ajuda (`-h`);
-  E uma ASCII ART, que você pode ocultar (`-s`).

---

## Propósito

Esse script nasceu durante um curso da IBM, onde eu precisava executar vários códigos com nomes semelhantes, como `code1`, `code2`, `code3`...

Quando tentei executar usando `./code*`, a saída do terminal não foi a que eu esperava. Foi aí que resolvi criar este script:

-  Para **praticar Bash**;
-  Aprender a lidar com **flags na linha de comando** (em qualquer ordem);
-  interagir com um ambiente Unix-like
   


## Como usar
./execute.sh [arquivos] [flags]
