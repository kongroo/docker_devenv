FROM kongroo/vim_ycm as VIM

FROM ubuntu
MAINTAINER kongroo
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en ENV LC_ALL en_US.UTF-8
ENV TZ Asia/Shanghai
ENV DEBIAN_FRONTEND noninteractive
ARG NVM_VERSION="0.33.8" 
ARG LLVM_VERSION="6.0"
# ARG UBUNTU_SOURCE="http://ftp.jaist.ac.jp/pub/Linux/ubuntu/"
ARG UBUNTU_SOURCE="http://mirrors.zju.edu.cn/ubuntu/"

# Copy configuration files
COPY . /root
COPY --from=VIM /root/.vim /root/.vim
WORKDIR /root

RUN sed -i.bak -e "s%http://archive.ubuntu.com/ubuntu/%${UBUNTU_SOURCE}%g" /etc/apt/sources.list \
    && apt update && apt install -y --no-install-recommends --no-install-suggests \
        zsh locales tzdata git ca-certificates \
        vim astyle clang-format exuberant-ctags \
        net-tools iputils-arping iputils-ping iproute2 \
        less zip unzip curl wget \
        python3 python3-pip python3-setuptools python-autopep8 flake8 \
        #init systemd \
        supervisor openssh-server lrzsz xauth dbus-x11 psmisc cron \
    && locale-gen en_US.UTF-8 \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && apt purge -y --autoremove \
    && apt clean \
    && rm -rf /var/cache/apt \
    && mkdir -p /var/run/sshd \
    && mkdir -p /etc/ssh/ \
    && mv sshd_config /etc/ssh/ \
    && mv jupyter.conf /etc/supervisor/conf.d/ \
    && mv supervisord.conf /etc/supervisor/conf.d/ \
    && mv sshd.conf /etc/supervisor/conf.d/ \
    && mv cron.conf /etc/supervisor/conf.d/ \
    && pip3 --no-cache-dir install virtualenvwrapper pysocks neovim \
    # Setup oh-my-zsh
    && wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true \
    && cat zshrc_append >> .zshrc \
    && rm zshrc_append \
    && usermod root -s /bin/zsh \
    # Install nvm
    && curl -o- https://raw.githubusercontent.com/creationix/nvm/v${NVM_VERSION}/install.sh | zsh \
    # Install vim plugins
    && curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
    && vim +PlugInstall +qall \
    && rm -rf .vim/plugged/**/.git \
    && mkdir -p .vim/plugged/ultisnips/ \
    && mv mysnippets/ .vim/plugged/ultisnips/ \
    && mkdir -p /usr/include/llvm-${LLVM_VERSION}/llvm/bits/ \
    && mv stdc++.h /usr/include/llvm-${LLVM_VERSION}/llvm/bits/ \
    # Setup python virtualenv and jupyter
    && mkdir -p .jupyter \
    && mv jupyter_notebook_config.json .jupyter/ \
    && cat jupyter_notebook_config.py >> .jupyter/jupyter_notebook_config.py \
    && mkdir -p .ipython/profile_default \
    && cp -f ipython_config.py .ipython/profile_default \
    && rm ipython_config.py jupyter_notebook_config.py \
    # Setup ssh
    && mkdir -p .ssh \
    && touch .ssh/authorized_keys \
    && cat id_rsa.pub >> .ssh/authorized_keys \
    && rm id_rsa.pub \
    && chmod 700 .ssh \
    && chmod 600 .ssh/authorized_keys \
    # Setup git
    && git config --global user.name "kongroo" \
    && git config --global user.email "imjcqt@gmail.com" \
    && git config --global credential.helper store

EXPOSE 80 443 8888 10022

CMD ["/usr/bin/supervisord"]
