#!/bin/sh

DIR="."
REMOTE="https://github.com/YesWiki/yeswiki.git"

ls -la

if [ $REPOSITORY ]
then
  echo "git repository environement variable defined"
  export REMOTE=$REPOSITORY
else
	echo "not git repository environement variable defined"
fi

if [ "$(ls -A $DIR)" ]; then
  echo "source directory is NOT Empty : no clone"
else
  echo "source directory is Empty : clone"
  echo "remote GIT repository to clone"
  echo "$REMOTE"
  git clone "$REMOTE" .
  # cp -r /git/* .
fi

# margot theme installed by make composer-install
# if [ -d "$DIR/themes/margot" ]; then
#    echo "themes ever installed"
# else
#   echo "margot theme install"
#   mkdir -p themes/margot && curl -o - -sSL https://github.com/YesWiki/yeswiki-theme-margot/archive/master.tar.gz | tar xzfv - --strip-components 1 -C themes/margot
# fi

if [ -d "$DIR/vendor" ]; then
   echo "php vendor ever installed"
else
  echo "php install"
  make composer-install
fi

if [ -d "$DIR/node_modules" ]; then
   echo "javascript dependencies ever installed"
else
  echo "javascript dependencies install"
  make yarn-install
fi


# allow apach to write to workdir even if is mont as volume
chmod -R o+w .

exec apache2-foreground
