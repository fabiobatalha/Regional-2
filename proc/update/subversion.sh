#!/bin/bash
# SHELL SCRIPT que atualiza o scielo-regional local 
# @author: Deivid Martins

# Arquivo com as variaveis de configuração
. conf.sh

echo "************************************"
echo "** Scielo Regional Update 0.01	**"
echo "************************************"
sleep 3
echo "Acessando o Repositorio."
sleep 1
echo "Acessando o Repositorio.."
sleep 1
echo "Acessando o Repositorio..."

# Cria a pasta Temporaria
mkdir -p $caminhoTemp
cd $caminhoTemp
echo "BAIXANDO ARQUIVOS DO BVS-SITE"
# Acessa o repositorio bvs-site
svn co $svnLocalBVS --username $login --password $senha -q $caminhoTemp

mkdir -p $caminhoTemp2
cd $caminhoTemp2
echo "BAIXANDO ARQUIVOS DO SCIELO-REGIONAL"
# Acessa o repositorio scielo-regional
svn co $svnLocalTrunk --username $login --password $senha -q $caminhoTemp2

mkdir -p $caminhoTemp3
cd $caminhoTemp3
echo "BAIXANDO ARQUIVOS DO SCIELO-REGIONAL-PROC"
# Acessa o repositorio scielo-regional
svn co $svnLocalProc --username $login --password $senha -q $caminhoTemp3


# Acha todos os arquivos .def e remove eles 
echo "REMOVENDO ARQUIVOS DE CONFIGURAÇÃO .def" 
find $caminhoTemp -name *.def>def.txt
rm -f `cat def.txt`

echo "REMOVENDO DIRETÓRIOS .SVN" 
# Acha todas as pastas .svn e remove-as
find $caminhoTemp -name .svn>svn.txt
rm -rf `cat svn.txt`

echo "REMOVENDO ARQUIVOS EXTRAS DE CONFIGURACAO"
# cantUpdate.txt contém todos os arquivos extras
rm -rf `cat /home/scieloorg/www/proc/scieloUpdate/cantUpdate.txt`

# Zipando as pastas
echo "ZIPANDO DIRETÓRIOS" 
cd $caminhoTemp
tar cfpz scieloregional.tgz htdocs/ proc/ cgi-bin/ bases/

# Atualizando aplicação
echo "ATUALIZANDO APLICACAO"
cd $caminhoAPL/www
tar xfpz $caminhoTemp/scieloregional.tgz 

# Apagando repositório
echo "APAGANDO ARQUIVOS TEMPORARIOS"
rm -r $caminhoTempRoot

# Altera permisões
echo "ALTERANDO PERMISSAO DO WXIS, DIRETORIO PROC E DO DIRETORIO BASES"
cd $caminhoAPL/www/cgi-bin/
chmod 775 wxis.exe
chmod 766 $caminhoAPL/www/htdocs/applications/scielo-org/users/appToken.txt
chmod 775 $caminhoAPL/www/htdocs/applications/scielo-org/users/
chmod -R 774 $caminhoAPL/www/proc/*
chmod -R 777 $caminhoAPL/www/bases/*
echo "FINISH"
