#!/usr/bin/env bash





main() {

    ##run script with sudo.
#    if [[ $UID != 0 ]];then
#        echo "Please start the script as root ot sudo!"
#        exit 1
#    fi


    if which tput >/dev/null 2>&1; then
      ncolors=$(tput colors)
    fi
    if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
    else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    NORMAL=""
    fi





    cur_dir=$PWD
    home_dir=$HOME
    user=`printf ${home_dir}|awk -F "/" '{print $(split($0, a))}'`
    corgi_dir=${home_dir}/.corgi_repository
    corgi_rc_file=${home_dir}/.corgi_rc
    mkdir -p ${corgi_dir}

    mkdir -p ${corgi_rc_file}



    sudo rm /var/lib/apt/lists/lock
    sudo rm /var/lib/dpkg/lock

    sudo apt-get update
    sudo apt-get upgrade

    sudo apt-get install wget -y
    sudo apt-get install curl -y

    ##install vim
    sudo apt-get install vim -y

    ##install zsh
    ##see http://ohmyz.sh/
    sudo apt-get install zsh -y
    zsh_install_file="zsh_install.sh"
    wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O "${corgi_dir}/${zsh_install_file}"
    cd ${corgi_dir}
    sed -i 's/env zsh//g' ${zsh_install_file}
    chmod u+x ${zsh_install_file}
    sh ${zsh_install_file}
    cd -

    ##install tmux
    sudo apt-get install tmux -y





    ##install git

    ##ubuntu 14.04
    sudo apt-get install software-properties-common -y

    sudo apt-add-repository ppa:git-core/ppa -y
    sudo apt-get update
    sudo apt-get install git -y
    git --version



    ##install teamviewer
    is_install=`dpkg -l teamviewer 2>&1 > /dev/null`
    if [ ! $? -eq 0 ];then
        if [ `uname -m` == "x86_64" ];then
            teamviewer_deb="teamviewer_amd64.deb"
        else
            teamviewer_deb="teamviewer_i386.deb"
        fi

        wget https://download.teamviewer.com/download/${teamviewer_deb} -P ${corgi_dir}&& \
        sudo dpkg -i ${corgi_dir}/${teamviewer_deb} && apt-get install -f

        if [ ! $? -eq 0 ];then
        printf "${RED}teamviewer install failed, please install later...${NORMAL}\n"
        else
            printf "${GREEN}teamviewer install success...${NORMAL}\n"
        fi
    else
        printf "${YELLOW}teamviwer exists...${NORMAL}\n"
    fi

    ##install oracle jdk
    ##see http://www.webupd8.org/2012/09/install-oracle-java-8-in-ubuntu-via-ppa.html
    is_install=`java -version 2>&1 |grep -c "1.8"`
    if [ ! ${is_install} -gt 0 ];then
        sudo add-apt-repository ppa:webupd8team/java -y
        sudo apt-get update
        sudo apt-get install oracle-java8-installer -y
        sudo apt-get install oracle-java8-set-default -y

        result=`java -version 2>&1 |grep -c "1.8"`
        if [ ${result} -gt 0 ];then
            printf "${GREEN}oracle jdk install success...${NORMAL}\n"
        else
            printf "${RED}oracle jdk install failed, please install later...${NORMAL}\n"
        fi
    else
        printf "${YELLOW}oracle jdk exists...${NORMAL}\n"
    fi


    #chsh -s $(grep /bash /etc/shells|tail -1)
    #echo $SHELL


    ##install maven
    result=`mvn -v 2>&1 > /dev/null`
    if [ ! $? -eq 0 ]; then
        maven_package="apache-maven-3.5.2-bin.tar.gz"
        wget https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz -P ${corgi_dir}
        sudo tar -zxvf ${corgi_dir}/${maven_package} -C /usr/local > /dev/null
        cd /usr/local
        sudo ln -s apache-maven-3.5.2 maven
        cd -
        echo -e 'MAVEN_HOME=/usr/local/maven\nPATH=${MAVEN_HOME}/bin:${PATH}' >> ${corgi_rc_file}
        printf "${GREEN}maven install success...${NORMAL}\n"
    else
        printf "${YELLOW}maven exists...${NORMAL}\n"
    fi

    ##install chromium-browser
    sudo apt-get install chromium-browser -y



    ##install gradle 3.4.1
    wget https://services.gradle.org/distributions/gradle-3.4.1-bin.zip
    sudo mkdir -p /opt/gradle
    sudo unzip -d /opt/gradle gradle-3.4.1-bin.zip
    echo 'PATH=${PATH}:/opt/gradle/gradle-3.4.1/bin' >> ${corgi_rc_file}
    source ${corgi_rc_file}

    if [[ `gradle -v | grep -c "Build time"` -eq 1 ]];then
        printf "${GREEN}gradle install success......${NORMAL}\n"
    else
        printf "${YELLOW}gradle install failed......${NORMAL}\n"
    fi


#############################################################################
##ending...
#############################################################################

    sudo rm -r ${corgi_dir}



    chown -R ${user}:${user} ${home_dir}/.zsh*
    chown -R ${user}:${user} ${home_dir}/.oh-my-zsh
    chown -R ${user}:${user} ${corgi_rc_file}


    echo "source ${corgi_rc_file}" >> ${home_dir}/.bashrc
    echo "source ${corgi_rc_file}" >> ${home_dir}/.zshrc


    echo "${BLUE}corgi init finished...${NORMAL}${GREEN}"

    echo "                .c.
                 .:,.     :l:.
                 'olcc,.  coc:
                  ,oolcc;:c:;ll'
                   'lol:codxlcxd
                    :ollookOd;ld;.,,
                     :lcllllc....;kx.
                     .c:cc:;.......
                     .;.......,..
            ...,',;;:cccc,....:.
        .,:c:::::::::::::c;.....
      .,::::::::::::::::::c...'.
      ::::::llc:;;ccc::c:c:.;c.
      :::::::co...''.;..''.:;'
      :lc:::cclco;   .,....:..
       :olloc;.;;'.    .,..;;''
        .''. .           . .. ${NORMAL}"
    ## use oh-my-zsh
    env zsh
}

main