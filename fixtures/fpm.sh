if [ ! -d "fpm" ] ; then
  git clone https://github.com/jordansissel/fpm.fpm
fi

(
  cd fpm
  git fetch
  git reset --hard origin/master
)
