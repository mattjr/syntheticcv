echo "installing vapory and patched versoin of povray and megapov"
echo "installing vapory"
pip install vapory
mkdir thirdparties 
cd thirdparties 
wget http://github.com/devernay/vlpovutils/archive/71890a3acc8501f674795285aa69669f15c95f69/master.zip --no-check-certificate -O vlpovutils.zip
unzip vlpovutils.zip 
rm vlpovutils.zip
mv vlpovutils-71890a3acc8501f674795285aa69669f15c95f69 vlpovutils


echo "installing libpng1.5"
wget http://sourceforge.net/projects/libpng/files/libpng15/1.5.26/libpng-1.5.26.tar.gz
tar xf libpng-1.5.26.tar.gz 
cd libpng-1.5.26
./configure --prefix=/usr/local/libpng
make check
sudo make install
make check
sudo updatedb
sudo ln -s /usr/local/libpng/lib/libpng15.so.15 /usr/lib/libpng15.so.15
sudo ln -s /usr/local/libpng/lib/libpng15.so.15 /usr/local/libpng/lib/libpng12.so
cd ..

echo "installing povray 3.6.1"
wget http://www.povray.org/ftp/pub/povray/Old-Versions/Official-3.62/Unix/povray-3.6.1.tar.bz2
tar -jxjf povray-3.6.1.tar.bz2
cd povray-3.6.1/
patch -p1 < ../vlpovutils/povray/megapov-focalblur.patch 
patch -p0 < ../vlpovutils/povray/povray-3.6.1-png15.patch
export CPPFLAGS=-I/usr/local/libpng/include
export LDFLAGS=-L/usr/local/libpng/lib
./configure --prefix=/opt/megapov --with-x COMPILED_BY="martin.de-la-gorce@enpc.fr" 
make
sudo make install 
sudo sed -i 's/;none /none /g' /opt/megapov/etc/povray/3.6/povray.conf
sudo sed -i 's/restricted /;restricted /g' /opt/megapov/etc/povray/3.6/povray.conf
cd ..

echo "installing megapov 1.2.1"
wget http://megapov.inetart.net/packages/unix/megapov-1.2.1.tgz
tar -zxvf megapov-1.2.1.tgz
cd megapov-1.2.1/
patch -p1  < ../vlpovutils/povray/megapov-annotation-0.2.patch 
patch -p1 < ../vlpovutils/povray/megapov-focalblur.patch
patch -p1 < ../megapov-png15.patch
export CPPFLAGS=-I/usr/local/libpng/include
export LDFLAGS=-L/usr/local/libpng/lib
./configure --prefix=/opt/megapov --with-x COMPILED_BY="martin.de-la-gorce@enpc.fr"  --disable-lib-checks
make 
sudo make install
cd ..

echo "compying and modifying megapov default configuration files"
sudo cp /opt/megapov/bin/megapov /usr/local/bin
sudo sed -i 's/;none /none /g' /opt/megapov/etc/megapov/1.2.1/povray.conf
sudo sed -i 's/restricted /;restricted /g' /opt/megapov/etc/megapov/1.2.1/povray.conf
sudo sed -i '$ a\ Library_Path="/opt/megapov/share/povray-3.6"' /opt/megapov/etc/megapov/1.2.1/povray.ini
sudo sed -i '$ a\ Library_Path="/opt/megapov/share/povray-3.6/ini"' /opt/megapov/etc/megapov/1.2.1/povray.ini
sudo sed -i '$ a\ Library_Path="/opt/megapov/share/povray-3.6/include"' /opt/megapov/etc/megapov/1.2.1/povray.ini
sudo chmod  777 /usr/local/bin/megapov
sudo mkdir ~/.megapov
sudo mkdir ~/.megapov/1.2.1/
sudo cp /opt/megapov/etc/megapov/1.2.1/povray.ini ~/.megapov/1.2.1/povray.ini
sudo cp /opt/megapov/etc/megapov/1.2.1/povray.conf ~/.megapov/1.2.1/povray.conf

echo "installing vlpovutils"
cd vlpovutils
sudo apt-get install libboost-dev libboost-test-dev
sed -i 's/CXXFLAGS=/CXXFLAGS= -std=c++11 /g' Makefile   
make
sudo cp vlpov_motionfield2 /usr/local/bin
sudo chmod  777 /usr/local/bin/motionfield2
sudo cp vlpov_project /usr/local/bin
sudo chmod  777 /usr/local/bin/vlpov_project

sudo ln -s /usr/local/bin/megapov /usr/local/bin/povray

