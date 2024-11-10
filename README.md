# Projeto Post-Install

O objeto desse projeto é criar scripts que automatizem etapas de configuração pós-instalação para instalar e configurar minhas maquinas, e compartilhar o resultado para que qualquer um possa adaptá-los para suas necessidades. A minha pretensão é separa os scripts em categorias, para organizar, e para garantir que eu possa executar etapas em separado caso algo dê errado.

## PowerShell

A primeira decisão sobre esse projeto é em que linguagem os scripts serão escritos. Em primeiro como devo considerar que minhas máquinas usam o sistema Windows, portanto, entre as opções estão `Batch` e `PowerShell`[^1], mas também seria possível tentar usar `Python` e, com alguma dificuldade, `Shell Script`.

No meu caso vou escolher `PowerShell`, pois é uma linguagem que já tenho algum conhecimento e acredito ser mais versátil que `Batch`. Note que existe uma diferença entre a versão do `Windows PowerShell` e `PowerShell`, geralmente os scripts que ire escrever podem ser executadas em ambas as versões, mas para evitar qualquer tipo de incompatibilidade vou preferir executar os scripts no último, devido a sua proposta multiplataforma.

## WinGet

Como uso o Windows, para instalar qualquer software de que necessito irei usar, em primeiro lugar, o WinGet[^2], e caso ele não o possua recorrei a gestores de pacotes de terceiros, como o Scoop[^3] e o Chocolatey[^4]. Irei evitar ao máximo baixar software direto pela URL, pois isso pode implicar em instalar software desatualizado.

## OneDrive

Uma das minhas pretensões nesse projeto é manter uma pasta de configurações em um armazenamento na nuvem, automatizando o backup das configurações e sincronizado diferentes estações de trabalho que tenho. Isso será feito substituindo os arquivos de configuração por *links simbólicos* que apontem para os arquivos de configuração no armazenamento da nuvem. Alguns programas permitem alterar a pasta em que armazenam, ou procuram, seus arquivos de configuração, e quando isso estiver disponível será preferido. Mas outros vão exigir alguma solução para fazer ou restaurar uma cópia de segurança.

Existem muitas soluções de armazenamento na nuvem gratuitos disponíveis, mas em meu caso irei usar o `OneDrive`[^5], porque já uso a bastante tempo, e já está pré-instalado no Windows. Acredito que qualquer outra solução deva funcionar bem.

## Referências

[^1][PowerShell](https://github.com/PowerShell/PowerShell)  
[^2][Usar a ferramenta WinGet para instalar e gerenciar aplicativos](https://learn.microsoft.com/pt-br/windows/package-manager/winget/)  
[^3][Scoop: A command-line installer for Windows](https://scoop.sh/)  
[^4][The Package Manager for Windows](https://chocolatey.org/)  
[^5][Microsoft OneDrive](https://onedrive.live.com/about/pt-br/)  