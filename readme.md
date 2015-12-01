
# getting data

* create a subfolder data or a symbolic link data where the datz will be stored
* get data by running setup.py

	python setup.py


# references and links

synthetic office and living room images + depth [here](http://www.doc.ic.ac.uk/~ahanda/VaFRIC/iclnuim.html)
the paper describing the image generation process can be found [here](http://www.doc.ic.ac.uk/~ahanda/VaFRIC/icra2014.pdf)
it has been generated wit POVray http://www.povray.org/
improved version of thes synthetic data with additional what can be found [here](http://redwood-data.org/indoor/dataset.html)
explaination on how to create a camera paramterized as usually done in computer vision in povray in http://www.inf.u-szeged.hu/projectdirs/kepaf2011/pdfs/S07_02.pdf
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

