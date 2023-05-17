# Object classification based on the shape and texture features<br/>
In this project, shape and texture features were applied to the image to classify weed and onion plants in the foreground. Shape features calculate the geometric properties of an object, while texture features describe the surface properties of an object. For classification, shape features like solidity, non-compactness, circularity, eccentricity and texture features like angular second moment, contrast, and correlation proposed by Haralick et al. (1973) were used. The dataset is available (GOTO [folder](https://github.com/Afsaneh-Karami/Computer_Vision/tree/main/object%20classification%20with%20shape%20and%20texture%20feature/Dataset)). There are 20 different samples including the colour image, the near infra-red image and the ground truth that manually segment to extract feature from images. In fact, several manual segment images used the calculated features from them to segment other images. In this project 18 images chosed for training the classification model and 2 imsges for testing.<br />
## shape feature <br/>
1. Solidity is the area of the region to that of the convex hull. It is a significant feature when the objects are irregular or contain concavities. <br />
2. Circularity is the degree of an object’s circularity, and in this task, it is an outstanding feature because onion, compared to weed, has such a low circularity. It was calculated from two formulas. The first method compares the area of a region A(R) to that of a circle with the same perimeter P(R). The second one compares the rotational moment of inertia of the region around the axis through the centre point I(R) to that of a circle with the same area A(R). <br />
3. Non-compactness is the reverse of circularity by an added scale invariant term. <br />
4. Eccentricity measures the object elongates, which is a different value for these two classes. The difference between variances along the ellipse axis is based on the second-order moments. <br />
* methodology and result:<br />
The truth image (separate foreground from the background)
was used to create images including weed or onion separately.
For example, in the weed image, the region with weeds is
white, and the other part is black. The bwconncomp function
was applied to get properties of connected components in the
image for weed and onion, and regionprops function was used
to get the shape features. <br />
For circularity and compactness based on the inertia, function
ind2sub gave the x and y values of the desired region (the
output of bwconncomp) in the image. Then by these values,
variance and inertia and circularity were calculated based on the following formula. So, shape
features were determined separately for each image and region
containing weed and onion. <br />
Circularity(R) = I(C)/I(R)=µ0,0^2/((µ2,0 + µ0,2)*2π) <br />
Non compactness(R)=2π*((µ2,0 + µ0, 2)/µ0,0^2+6/µ0,0) <br />
µ0,0 = Area, µ2,0 = central image moment in  in the x direction, µ0,2 = central image moment in  in the x direction <br />
To compare the feature shape for two classes and infer
which one can better distinguish a weed from an onion, the
histogram of each feature was presented in histogram folder (GOTO [folder](https://github.com/Afsaneh-Karami/Computer_Vision/tree/main/object%20classification%20with%20shape%20and%20texture%20feature/histogram)).
Average and variance show the data distribution and indicate
how well this feature can distinguish between two objects. As
apparent in the images, circularity based on inertia and solidity
are the best indicator among others. Then feature circularity
based on the perimeter, non-compactness and eccentricity are
good properties to separate. 
![Circularity based on inertia](https://github.com/Afsaneh-Karami/Computer_Vision/assets/78735911/0cf4b878-73d3-4aca-bd52-3b7e5825a8a5)
![Circularity](https://github.com/Afsaneh-Karami/Computer_Vision/assets/78735911/a72b721f-cf81-4a1d-bff1-f49b77f1b242)
![Eccentricity](https://github.com/Afsaneh-Karami/Computer_Vision/assets/78735911/d8e59734-a9c5-4d44-8d0b-661b7a8f912f)
![solidity](https://github.com/Afsaneh-Karami/Computer_Vision/assets/78735911/28acc7cd-1380-4339-a424-2da2218dcef5)
![non compactness based on inertia](https://github.com/Afsaneh-Karami/Computer_Vision/assets/78735911/4f87f1e3-87c7-4efd-a0bf-2855b8bc1e27)
## texture feature <br/>
For texture features, a grey-level co-occurrence matrix
(GLCM) of objects describes the relationships between pixels
pairs at a specific distance and orientation was used. <br />
Angular second-moment measures the local uniformity of grey
levels.<br />
Contrast is the difference in intensity between different parts of the object.<br />
Correlation calculates the similarity of two regions of texture. <br />
* methodology and result:<br />
The function imoverlay applied to the RGB image separates
the region of interest (weed or onion) from the RGB image and
puts zero for other parts. So, we have two kinds of images one
shows an RGB image of just weeds, and another depicts the
onions. The imoverlay was also implemented on the depth
image. Then the three-channel RGB image of the weed and
onion separated and changed to grey images. For every three
channels and the depth (infrared image), the function graycomatrix got GLCM.
The number of grey levels was selected based on trial and
error; eight was the best.
Four orientations, 0,45,90,135, were considered, and their
average and range were used for plotting the histogram of
features (GOTO [folder](https://github.com/Afsaneh-Karami/Computer_Vision/tree/main/object%20classification%20with%20shape%20and%20texture%20feature/histogram)). Finally, the graycoprops function got the three desired texture features. This way, the GLCM and features are
calculated separately for the image’s whole region of interest
for weed and onion. <br />
For three channels and one depth, three features were
calculated for four orientations for two objects, weed and
onion, which led to 24 overall features. Feature data distribution showed that
more outstanding texture features were the contrast of all
channels (average). 
## object classification using features <br/>
In this project, extracted features are used by the Support
Vector Machine algorithm (SVM) to classify objects. To find
the best combination of features which gives a more accurate
classification, feature analysis was done.
* methodology and result:<br />
All the features were extracted and averaged for each image,
so there are 5 shape features and 12 texture features for
each image for each object. Features of images 19 and 20
for both classes were separated as test data. The function
fitcsvm was used for the classification. It is a machine learning
algorithm, the Support Vector Machine (SVM) algorithm,
for classification. SVM is a machine learning algorithm that finds the optimal boundary (hyperplane) to separate the two
classes in the feature space. This hyperplane is selected
to maximise the margin between it and the nearest points
from both classes(support vectors). In this way, the algorithm
has the highest generalisation performance on test data. The
output of the prediction of SVM is the discriminant score,
which represents the SVM model confidence in classification.
The value of the score is the distance from the observation
to the decision boundary, and the sign indicates whether
the observation belongs to this class or not. Four different
combinations of features were trained and tested on data,
including the first 5 feature shapes, the second 12 texture
features, the third combination of all 17 features, and the
fourth combination of the 10 best features. Two algorithms
were used to analyse features (to find the best 10 features).
The beta coefficient of fitcsvm model indicates weight features
and shows the importance of each feature in the classification
model. The enormous value means that features are more
critical in the classification process. The second model for
feature analysis was Feature Selection and Classification using
Nonlinear Component Analysis (fscnca function in Matlab).
It is a linear Support Vector Machine (SVM). The reason for
using two algorithms is that one can not give 10 best features.

