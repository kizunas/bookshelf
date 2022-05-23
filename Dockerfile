FROM ruby:2.6.3



# yarnパッケージ管理ツールをインストール
# Yarnのレポジトリを有効化。レポジトリのGPGキーをcurlコマンドを使って取得する(debianはubuntuと互換性がある)
# YarnのAPTパッケージレポジトリを自分のシステムに追加。teeコマンドを使って書き込み。
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
apt-get update && apt-get install -y yarn

# レポジトリがシステムに加えられたらパッケージリストをアップデートしてからYarnをインストールする
RUN apt-get update -qq && apt-get install -y nodejs yarn
RUN mkdir /myapp

# Dockerコンテナ上の作業ディレクトリ
WORKDIR /myapp

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
# ローカル開発環境の./配下の内容をDockerコンテナ上の/myappにコピー
COPY . /myapp

# コンテナ起動時に実行させるスクリプトを追加
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# ローカル開発環境のstart.shの内容をDockerコンテナ上の/start.shにコピー
COPY start.sh /start.sh
# Docker側の下記のファイルに実行権限を渡すので権限を変更する
RUN chmod 744 /start.sh
# 実行
CMD ["sh", "/start.sh"]

