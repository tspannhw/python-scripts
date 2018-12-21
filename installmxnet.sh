sudo yum groupinstall 'Development Tools' -y
sudo yum install cmake git pkgconfig -y
sudo yum install libpng-devel libjpeg-turbo-devel jasper-devel openexr-devel libtiff-devel libwebp-devel -y
sudo yum install libdc1394-devel libv4l-devel gstreamer-plugins-base-devel -y
sudo yum install gtk2-devel -y
sudo yum install tbb-devel eigen3-devel -y
pip install numpy
cd ~
git clone https://github.com/Itseez/opencv.git
cd opencv
git checkout 3.1.0
git clone https://github.com/Itseez/opencv_contrib.git
cd opencv_contrib
git checkout 3.1.0
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
    -D INSTALL_C_EXAMPLES=OFF \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D BUILD_EXAMPLES=ON \
    -D BUILD_OPENCV_PYTHON2=ON \
    -D BUILD_OPENCV_PYTHON3=ON ..
sudo make
sudo make install
sudo ldconfig



git clone https://github.com/apache/incubator-mxnet.git
git clone https://github.com/tspannhw/ApacheDeepLearning101.git
git clone https://github.com/tspannhw/ApacheDeepLearning201.git
git clone https://github.com/tspannhw/mxnet-for-iot.git

sudo yum install -y https://centos7.iuscommunity.org/ius-release.rpm
sudo yum update -y
sudo yum install -y python36u python36u-libs python36u-devel python36u-pip -y
python3.6 -V

curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
python3.6 get-pip.py

pip3.6 install --upgrade pip
pip3.6 install --upgrade setuptools
pip3.6 install mxnet


<dependency>
    <groupId>org.apache.mxnet</groupId>
    <artifactId>mxnet-full_2.11-linux-x86_64-cpu</artifactId>
    <scope>system</scope>
<version>1.4.0-SNAPSHOT</version>
</dependency>

# http://mxnet.incubator.apache.org/install/centos_setup.html


