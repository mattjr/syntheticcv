#Project's goals

The goal of this project is to provide an easy-to-install python toolbox that can be used to easily generate synthetic training and testing data for various computer-vision problems such as stereo reconstruction, optical flow, multiview reconstruction, structure from motion, point and segment matching, single view surface normals estimation or shape from shading.

The synthetic images are obtained through the generation of a random 3D scene using  that is rendered using the open-source ray-tracer called povray trough a simple python interface [vapory](https://github.com/Zulko/vapory).
The ray tracer is patched to allow the obtention of the disparity map in case of stereo pairs generation. 

Generating synthetic data allows us 
* to have a complete control on the type a scenes we want to specialize our algorithm on, For example we can generate scenes that piecewise planar and that are manahattan or not. We have a control on the surface properties (lambertian  or with specularities) and we can control the amount and type of textures. 
* to generate data in large quantities (assuming you have enough computational ressources) 
* to have perfect ground truth with no measure error, that can be usefull when checking that there are no bugs in your stereo or optical flow code. 

 
## examples

synthetic stereo pairs
 
![left image[image_left.png]![right image[image_right.png]

![left image[image_left2.png]![right image[image_right2.png]


# limitations

The scenes are generated in the pov-ray format using a constructive solid geometry (CSG) description of the surface i.e. using unions and differences of basic 3D shapes such as sphere cubes etc and thus there is no triangulated surface description of the scene.
This could be overcome by allowing the user the generate random scene that are triangulated surfaces, either by generating directly triangulated surfaces or by converting the CSG into a triangulated surface before rendering and by giving access to the triangulated surface to the user. 


# getting data



* create a subfolder data or a symbolic link data where the data will be stored
* get data by running setup.py

	python setup.py


# references and links

synthetic office and living room images + depth [here](http://www.doc.ic.ac.uk/~ahanda/VaFRIC/iclnuim.html)
the paper describing the image generation process can be found [here](http://www.doc.ic.ac.uk/~ahanda/VaFRIC/icra2014.pdf)
it has been generated wit POVray http://www.povray.org/
improved version of thes synthetic data with additional what can be found [here](http://redwood-data.org/indoor/dataset.html)
explaination on how to create a camera paramterized as usually done in computer vision in povray in [here](http://www.inf.u-szeged.hu/projectdirs/kepaf2011/pdfs/S07_02.pdf)
gettign data from http://robotvault.bitbucket.org/
but there is no texture for now...

# install


* install POVray  See [here](http://www.povray.org/download/) for the Windows binaries. For Linux/MacOS you must compile the source.
* install vaporay a python interface to POVray	

	pip install vapory

* install OpenMVG ? 
* install PMVS2

# 
run PMVS2 on synthetic data
run CMPMVS
run other stereo algorithms ? 
run edge matching ? 
compute error with ground truth on the depth
run manhattan world stereo ? 

# test training ?

generate good matches , wrong matches and clasify  


# computing the depth map


## installation 


### installing povray 3.6



note:  sudo apt-get install povray  installs povray 3.7 while megapov requires povray 3.6. It would be good that megapov get updated. 
Howverver on this vlpovutils [here](http://devernay.free.fr/vision/focus/office/) he says he uses 
 POV-Ray 3.7 RC6 as POV-Ray 3.6 generates visible artifacts between the left and right views.
How did he manage to install megapov 1.2.1 with povray 3.7 ?

	wget http://www.povray.org/redirect/www.povray.org/ftp/pub/povray/Old-Versions/Official-3.62/Unix/povray-3.6.tar.bz2
	tar -xjf povray-3.6.tar.bz2
	cd povray-3.6.1/
	./configure COMPILED_BY="your name <martin.de-la-gorce@enpc.fr>"
	make
	sudo su
	make install 
	sudo sed -i 's/;none /none /g' /usr/local/etc/povray/3.6/povray.conf
	sudo sed -i 's/restricted /;restricted /g' /usr/local/etc/povray/3.6/povray.conf

### installing megapov 1.2.1

	wget http://megapov.inetart.net/packages/unix/megapov-1.2.1-linux-amd64.tgz
	tar -zxvf megapov-1.2.1-linux-amd64.tgz
	cd megapov-1.2.1/
	./install
	mkdir ~/.megapov
	mkdir ~/.megapov/1.2.1/
	cp /usr/local/etc/megapov/1.2.1/* ~/.megapov/1.2.1/
	sed -i 's/;none /none /g' /usr/local/etc/megapov/1.2.1/povray.conf
	sed -i 's/restricted /;restricted /g' /usr/local/etc/megapov/1.2.1/povray.conf
	sed -i 's/;none /none /g' ~/.megapov/1.2.1/povray.conf
	sed -i 's/restricted /;restricted /g' ~/.megapov/1.2.1/povray.conf
	sudo chmod -R ugo+rw /usr/local/share/megapov-1.2.1
	sudo chmod  777 /usr/local/share/megapov-1.2.1/include/pprocess.inc # does not work , not sure why

### installing vlpovutils

	wget http://github.com/devernay/vlpovutils/archive/71890a3acc8501f674795285aa69669f15c95f69/master.zip --no-check-certificate
	unzip master.zip
	rm master.zip 
	cd vlpovutils-master
	sudo apt-get install libboost-dev libboost-test-dev
	sed -i 's/CXXFLAGS=/CXXFLAGS= -std=c++11 /g' Makefile
	
	make

### testing 
mkdir office
cd office
wget http://devernay.free.fr/vision/focus/office/office-focalblur.zip
unzip -a office-focalblur.zip
wget  http://www.ignorancia.org/uploads/zips/office.zip
unzip -a office.zip
wget  http://www.ignorancia.org/uploads/zips/lightsys4c.zip
unzip -a lightsys4c.zip
wget http://www.ignorancia.org/uploads/zips/bookplacer.zip
unzip -a bookplacer.zip
wget http://www.ignorancia.org/uploads/zips/meshlath.zip
unzip -a meshlath.zip
megapov
mkdir office-left office-right
cd office-focalblur
sudo su # other can't access /usr/local/share/megapov-1.2.1/include/pprocess.inc
megapov +Q0 -UV +w1080 +h720 -A +L.. +L../office +L../office/maps +L../LightsysIV +K0.0 +Ioffice_stereo_megapov.pov +Ooffice_stereo1_megapov.png
megapov +Q0 -UV +w1080 +h720 -A +L.. +L../office +L../office/maps +L../LightsysIV +K1.0 +Ioffice_stereo_megapov.pov +Ooffice_stereo2_megapov.png

 cannot open the user configuration file /home/martin/.megapov/1.2.1/povray.conf


we could use a patched version of poveray or megapov from [here](https://github.com/devernay/vlpovutils)
original page [here](http://devernay.free.fr/hacks/povray/vlpovutils/)
There are example of data that have been generated using this tool:
* the povray office with depth maps [here](http://devernay.free.fr/vision/focus/office/)
* a patio [here](http://devernay.free.fr/vision/focus/patio/) 
the use of the vlpovutils code to generate depths maps is not very well documented . all the links i found to the annotation patch by Dr Andrea Vedaldi point to [this](http://www.robots.ox.ac.uk/~vedaldi/code/vlpovy.html) page that does not exist anymore 
maybe the most detailed instruction are the office and patio pages
Another approach would consist in using only meshed an no solid geometry , and then use CGAL to generate the depth map using raytracing in CGAL.
This has the advantage of beeing more flexible ? of getting hiddent part depths too ? 
We could also generate meshes from solid geomtry desciption of the scene but  i could not find tool to generate meshes from povrayfile (which would require some solid geometry to mesh tool , maybe using openSCAD or [solidPython](https://github.com/SolidCode/SolidPython)). 



## some models available online



archive3D.net archibase.co

website listing most webstite with a short descritpion :
	http://en.wikibooks.org/wiki/Blender_3D:_Noob_to_Pro/Sources_of_free_3D_models


http://www.blender-models.com/
	not many model in total (392items), and very few interesting for us

http://blender-archi.tuxfamily.org/Models#Chair
	quite a few furniture models, no scenes

http://archive3d.net/
	many furniture models , not blender files  no scenes

http://www.blendswap.com/blends/view/67359
	many scenes , can be filtrer by licens (CC-0 ,CC-By, CC-BY-SA) will look what these licences mean
	http://www.blendswap.com/search?term=kitchen		
	www.blendswap.com/search?term=+room


http://sketchup.google.com/3dwarehouse
	quite a few kitchen and living rooms, not really reastic models in general

http://resources.blogscopia.com
 	license : Creative Commons 3.0 Unported ( http://resources.blogscopia.com/license-2/)	
	furnitures but not complete scenes
	exemple
	contemp_living_room_sh3d.zip
	contemp_living_room_obj.zip

