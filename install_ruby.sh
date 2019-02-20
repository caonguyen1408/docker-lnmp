#~/usr/bin/bash
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL
cd
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL
rbenv install 2.4.0
rbenv global 2.4.0
gem install bundler
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
gem install rails -v 5.0.1
rbenv rehash
ruby -v