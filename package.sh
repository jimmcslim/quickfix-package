QF_VERSION=$1

rm -rf quickfix

git clone --depth 1 --branch nm-206 https://github.com/jimmcslim/quickfix.git
rm -rf quickfix/.git

pushd quickfix/doc
./document.sh
popd

pushd quickfix
../git2cl > ChangeLog
./bootstrap
popd

rm -f quickfix-$QF_VERSION.tar.gz

tar czvf quickfix-$QF_VERSION.tar.gz quickfix

pushd quickfix
./configure --with-python3 && make && make check
popd
