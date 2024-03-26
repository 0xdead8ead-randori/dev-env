#FROM --platform=linux/amd64 ubuntu:22.04
FROM --platform=linux/arm64 ubuntu:22.04

ARG PYTHON_VERSION=3.11.2
ENV PYTHON_VERSION=$PYTHON_VERSION

# Username for dev environment - make sure it matches the host user for easy access to workspace files under ~/.dev-env/
ARG DEV_USER="dead8ead"
ENV DEV_USER=$DEV_USER

ARG SSH_PUB_KEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEXhGGQ0BpRfDTf/J1E2E+1sYPgkjB/MHbL5OEIK1JCh"
ENV SSH_PUB_KEY=$SSH_PUB_KEY

# initial dependencies
RUN apt update && apt install -y sudo zsh vim net-tools procps

# create user
RUN groupadd -g 1001 $DEV_USER
RUN useradd -rm -d /home/$DEV_USER -s /bin/zsh -g $DEV_USER -G sudo -u 1001 $DEV_USER && passwd -d $DEV_USER
USER $DEV_USER
WORKDIR /home/$DEV_USER
ENV HOME=/home/$DEV_USER
ENV TERM=xterm-256color


# install ohmyzsh
RUN sudo apt install -y curl git
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# install powerlevel10k
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
RUN $HOME/.oh-my-zsh/custom/themes/powerlevel10k/gitstatus/install -f
COPY .zshrc .p10k.zsh /home/$DEV_USER

# install zsh plugins
RUN git clone https://github.com/MichaelAquilina/zsh-autoswitch-virtualenv.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/autoswitch_virtualenv
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions 
RUN git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions 

# set shell to zsh
SHELL ["/usr/bin/zsh", "-i", "-c"]

# install pyenv
RUN sudo apt install -y zlib1g-dev liblzma-dev libssl-dev libreadline-dev libbz2-dev libsqlite3-dev libffi-dev build-essential checkinstall
RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv
RUN pyenv install -v $PYTHON_VERSION 
RUN pyenv global $PYTHON_VERSION

# install vim plugins
RUN git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
COPY .vimrc $HOME/.vimrc
RUN vim +PluginInstall +qall 

# install you-complete-me
RUN sudo apt install -y clang golang openjdk-17-jdk openjdk-17-jre cmake
RUN (cd ~/.vim/bundle/YouCompleteMe && python3 install.py --clangd-completer --go-completer --java-completer)

# install python linters
RUN pip install flake8 

# install gcloud
RUN sudo apt install -y apt-transport-https ca-certificates gnupg curl
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN sudo apt update && sudo apt install -y google-cloud-cli

# install docker cli
RUN sudo apt-get install ca-certificates curl
RUN sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN sudo apt-get update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# install poetry
RUN pip install poetry

# install openssh
RUN sudo apt install -y openssh-server
RUN sudo mkdir /run/sshd
RUN mkdir $HOME/.ssh && echo $SSH_PUB_KEY > $HOME/.ssh/authorized_keys
RUN sudo adduser $DEV_USER _ssh

# additional deps - add any additional system tools needed here
RUN sudo apt install -y tree


COPY start-services.sh /app/
EXPOSE 22
CMD ["/app/start-services.sh"]
