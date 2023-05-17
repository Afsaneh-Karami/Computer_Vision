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
µ0,0 = Area,µ2,0 = central image moment in  in the x direction, µ0,2 = central image moment in  in the x direction <br />
