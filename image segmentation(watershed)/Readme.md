# Segmenting plant from the background, segment each leaf of a plant and count them:<br />
<p align="justify">
The dataset is the image of 15 plants and 15 ground truths manually segmented and used to calculate the segmentation accuracy. Two methods, active-contour and RGB mask, were used for plant segmentation. For leaf segmentation watershed method was a good choice because lots of leaves were occluded with each other.
 
## Plant object segmentation (segment plant from background):<br />
<p align="justify">
Several conventional computer vision techniques are used to segment objects from an image’s background, including edge-based, region-based, and contour-based. The best one depends on the image characteristics and desired output. For this project, one region-based method, mask and one contour-based method, active contour, were tried. <br/>
 
 *Methodology and result:<br />
 <p align="justify">
 Mask: The Matlab APPS colorThresholder in Image processing and computer vision was applied to the RGB image for the mask method. It builds three ranges for three channels as a mask function. The output is a binary image that separates the plant from the background. <br />
Active-contour: A mask that encloses the object (plant) is selected. Then, the algorithm iteratively deforms the contour to align with the object’s edges based on minimising the energy function. The image, mask, and number of iterations are given as inputs. The energy function has two internal and external components that control how the contour matches the object’s boundaries. The internal energy consists of the continuity of the contour (first-order gradian) and the contour smoothness (second-order gradian) to control the deformations made to the contour. The external energy term controls the contour’s fitting towards the object’s boundaries.<br />
The Dice coefficient was used to compare the results of different segmentation methods. It measures the overlap or similarity between binary ground truth images and binary segmented images. In the formula, the number of common pixels of two images is multiplied by two and divided by the total number of pixels of two images. The result of the Dice coefficient is in the following image. The best result was for the mask method. The mask gives better results than the active contour because the active contour matches with the outer boundary of the object and gets stuck in local minima. If there is a place between two leaves that belong to the background because it is inside the outer boundary, the active contour method can not reach that place and detect them as plants in segmentation. Samples of it are plants 3 and 5. The mask is robust to intensity variations. The lowest Dice coefficient belongs to image eight because of its low resolution (smallest image). 
 </p>
 
<p align="center">
![barGraphDS](https://github.com/Afsaneh-Karami/Computer_Vision/assets/78735911/f495db19-0ed0-48ea-87db-35a7b3274565)

</p><br/>
* creating a topological map (GOTO [map folder link](https://github.com/Afsaneh-Karami/my_package/blob/main/maps/foo3.tmap2)) <br />

<p align="justify">

</p>
<p align="center">
<img width="673" alt="Screenshot 2023-02-09 000653" src="https://user-images.githubusercontent.com/78735911/217680260-6198e930-0851-47d0-84a0-98a37d447362.png">

</p><br/>

* move-based (GOTO [config folder link](https://github.com/Afsaneh-Karami/my_package/tree/main/config)) <br />
<p align="justify">


## Image processing with OpenCV (GOTO [src folder link](https://github.com/Afsaneh-Karami/my_package/tree/main/src)) <br />


 </p>
<p align="center">
<img width="736" alt="Screenshot 2023-02-09 000417" src="https://user-images.githubusercontent.com/78735911/217679954-cecb64ee-2504-4483-be19-72e8a80b03e4.png">
  </p></p><br/>
  
2. avoid double counting <br/>
<p align="justify">

  </p>
<p align="center">
<img width="335" alt="Screenshot 2023-02-09 000224" src="https://user-images.githubusercontent.com/78735911/217679542-7c36ed54-5b7a-497f-88c7-aec499e8d338.png">
</p><br/>
<p align="justify">
In a real-world case, adding unique features to avoid double counting, like shape, the number of grapes, and the average
colour in the contour pixel, improve the accuracy of counting. Also, the ground is not flat and increases the noise in
coordinate transforming. The slippage of wheels should be considered too.
## Evaluation:
To evaluate the effect of each filter in avoiding double counting, some tests were done, and at each step, ignoring one of filtering. According to the result of table 1, contributions to avoiding double counting for area, frame, and tolerance filtration are 47.5, 62, and 47 percent respectively. The performance of the code was checked when the robot passed through a row twice. The result was presented in table 2, and it had 20-23 percent double counting.<br/>
</p>
<p align="center">
<img width="265" alt="Screenshot 2023-02-08 233926" src="https://user-images.githubusercontent.com/78735911/217676550-8eea1e2c-4be0-4c33-a805-58ef7ad93a13.png"><br/> 
</p>

