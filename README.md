# MonitorMAPA 3.0.3-UTF8!
-------------

MonitorMAPA é um arquivo do tipo batch (.bat) do Windows.


MonitorMAPA (C) 2023 Valmir Morais.
-------------

Script destinado ao simples monitoramento de ativos de redes
por meio do protocolo ICMP;


Principais recursos do MonitorMAPA:
-------------

	1. Informa se o link de internet está ativo por meio de consultas de NSLOOKUP;
	2. A inserção de hosts é facilitada por meio de arquivo, sem necessitar alterar o arquivo do script;
	3. Título para separar a quantidade de ativos por setor;
	
Este script não gera estatísticas, a finalidade é somente informar o status do host, informando somente se está "ONLINE" ou "OFFLINE".


Instruções rápidas:
-------------

	O arquivo "moni.ini" deve conter a informação no seguinte formato:
  
		[Título]
		host:ip
	
	O título para exibição deverá estar, obrigatoriamente, entre os colchetes. Caso não esteja, a formatação exibida na 
	tela ficará fora do padrão esperado.
O "host" é um nome que desejar exibir o ativo de rede. 
O ip, literalmente, é o IP do ativo de rede (ou nome totalmente qualificado) a monitorar.
Devem estar separados por ":", de outra forma irá afetar o funcionamento do script.
  
  
INSTALAÇÂO:
-------------

O script roda a partir da pasta que estiver. 
O arquivo de configuração deve estar na mesma pasta do script.
Basta descompactar, editar o arquivo com as informações precisas e executar o script.

-------Easy to use-------
