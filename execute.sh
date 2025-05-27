shopt -s nullglob
declare fileName=()
declare modos=""
declare executados=()
declare erros=()
declare ignorados=()

#verifica se o script a ser executado já foi executado previamente
function contem {
    local elemento="$1"
    shift
    declare verdadeiro=0
    local arr=("$@")  
    for item in "${arr[@]}"; do
      if [[ "$elemento" == "$item."* ]]; then
        verdadeiro=1
        ignorados+=("$elemento")
        break
      fi
    done
     if [ $verdadeiro -eq 0 ]; then
        return 0
    else
        return 1
    fi
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    echo "Forneca o nome dos seus arquivos separados por espaco"
    echo "e as flags desejadas"
    echo "-x ou --execute para rodar executaveis"
    echo "-r para rodar scripts python ou go"

   
    echo "exemplo: ./execute code teste -r -x"
    echo " ele roda code1, code2, code3.go, ele nao roda scripts que os executaveis ja rodaram"
    echo "por isso se existirem code1.go e code2.go sao ignorados"
    echo "-s se não quiser ver minha ascii lindissima"
    exit 0
fi
# Processar argumentos
for arg in "$@"; do
    if [[ $arg == "-"* ]]; then
        modos+=" $arg"
    else
        fileName+=("$arg")
    fi
done

if [[ ! $modos == *"-s"* && ! $modos == *"--suprimir"* && ! $modos == *"--supress"* ]]; then
    echo "  _______  _______ ____ _   _ _____ _____ 
 | ____\ \/ / ____/ ___| | | |_   _| ____|
 |  _|  \  /|  _|| |   | | | | | | |  _|  
 | |___ /  \| |__| |___| |_| | | | | |___ 
 |_____/_/\_\_____\____|\___/  |_| |_____|
                                           by Matheus Gomes Soares"
fi
# Executáveis diretos
if [[ $modos == *"-x"* || $modos == *"--execute"* ]]; then
    for file in "${fileName[@]}"; do
        files=("${file}"*)
        for i in "${files[@]}"; do
            if [[ -x "$i" && ! "$i" == *".py" && ! "$i" == *".go" ]]; then
                printf "executarei %s \n" "$i"
                if ./"$i"; then
                    executados+=("$i")
                else
                    erros+=("$i")
                fi
            fi
        done
    done
fi


# Scripts (python/go)

if [[ $modos == *"-r"* || $modos == *"--run"* ]]; then
    for file in "${fileName[@]}"; do
        files=("${file}"*)
        for i in "${files[@]}"; do
            if  contem "$i" "${executados[@]}"; then
                if [[ $i == *".go" ]]; then
                    printf "executarei %s como script \n" "$i"
                    if go run "./$i"; then
                        executados+=("$i")
                    else
                        erros+=("$i")
                    fi
                elif [[ $i == *".py" ]]; then
                    printf "executarei %s como script \n" "$i"
                    if python3 "$i"; then
                         executados+=("$i")
                    else 
                        erros+=("$i")
                    fi
                fi
            fi
        done
    done
fi

echo "Sucessos em: ${executados[@]}"
echo "Erros em: ${erros[@]}"
echo "ignorados: ${ignorados[@]}"
