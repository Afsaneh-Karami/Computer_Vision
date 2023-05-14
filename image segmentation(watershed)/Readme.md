# Segmenting plant from the background, segment each leaf of a plant and count them:<br />
<p align="justify">
The dataset is the image of 15 plants and 15 ground truths manually segmented and used to calculate the segmentation accuracy. Two methods, active-contour and RGB mask, were used for plant segmentation. For leaf segmentation watershed method was a good choice because lots of leaves were occluded with each other.
</p>
<p align="center">
<img width="303" alt="1" src="https://user-images.githubusercontent.com/78735911/217668371-afdc851b-04f8-43a2-90f5-5eae37895d87.png"> <br />
</p><br/>

## Navigation section:<br />
<p align="justify">

 </p>
 
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

