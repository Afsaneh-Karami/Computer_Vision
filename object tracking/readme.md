#  Object Tracking <br/>
The object tracking process is implemented in the Kalman
filter by predicting the current object’s position based on
information from the previous state (like position and velocity)
and updating it based on the sensor information, like cameras.
It has two models, the motion model, which describes the
dynamic of movement and the observation model, based on the
sensor data. Because of noise, it is necessary to calculate the
uncertainty of the estimation of the algorithm. The noise in the
state transition model comes from the motion and sensor noise
(measurement noise) from the observation model.<br/>
The dataset for this project is available in folder (GOTO [folder](https://github.com/Afsaneh-Karami/Computer_Vision/tree/main/object%20tracking/Dataset)), which includes the real measurement of position in 2D dimension (x and y), and noisy position data (a and b). <br/>
Kalman filter is a common algorithm for object tracking. 
For this project, two algorithms, the standard Kalman filter and
the extended Kalman filter, were used. Both algorithms have
assumed that noise distribution is Gaussian. To show the noise
distribution, which is calculated by subtracting the observation
vector (a,b) from the real value (x, y), the histogram of
noise in the x and y directions is plotted in the following picture. To check the kind of distribution, three tests
Kolmogorov-Smirnov, Anderson-Darling, and Lilliefors, were
applied, and the result shows that the distribution Is not
Gaussian. For example, h and p for lillietest in Matlab were
1 and 0.001 for both noise datasets. So, in reality, the noise does not have a Gaussian distribution. Still, for this project, the
Gaussian distribution is considered for noise in both motion
and observation models. <br/>
![noise distributionx](https://github.com/Afsaneh-Karami/Computer_Vision/assets/78735911/4d768307-0dbb-4b1d-9003-d30b2f60f1fb)<br/>
![noise distributiony](https://github.com/Afsaneh-Karami/Computer_Vision/assets/78735911/bab2a132-2f31-4878-9742-0c26d667b799)<br/>
* Standard Kalman filter
Standard Kalman filter algorithm estimates the state of a linear system if the state (motion model) and measurement (observation model) noise is Gaussian distribution. The Kalmen filter can improve the noisy or incomplete measurements common in real-world scenarios. It is used in many domains like navigation systems, robot areas, and object tracking in computer vision.
* Extended Kalman filter
The Extended Kalman Filter (EKF) extends the standard
Kalman filter and works with nonlinear systems. Many real-world systems have nonlinear motion models. It approximates
the nonlinear motion by converting it into small linear parts,
which the Kalman filter algorithm can use. For example, use
the Taylor series expansions, which are linear functions, in the
standard Kalman filter. In this project, the Jacobian matrix, a
partial derivative of the motion function for each state element, is used to linearise. The formula used to model motion with
an extended Kalman filter is the same as the Kalman filter,
mentioned in the next part; just the F and H are the Jacobian
matrix of the motion model and the Jacobian matrix of the
observation model, respectively.
*  Formula for Kalman filter and extended Kalman filter:
*  Prediction function:
<div align="center">
<img width="400" alt="Screenshot 2023-05-17 212026" src="https://github.com/Afsaneh-Karami/Computer_Vision/assets/78735911/62ebd946-2894-4dbb-b510-01e4fd847562">
</div>
For Kalman filter F is matrixof themotionmodel. For extended Kalman filter, it is the Jacobian matrix of the motion model with respect to the state variables.<br/>
input:x (initial state), P (initial state covariance which is equal to Q), F, Q (matrix of the motion noise) <br/>
output:xp and Pp <br/>

*  Update function:
<div align="center">
<img width="400" alt="Screenshot 2023-05-17 184524" src="https://github.com/Afsaneh-Karami/Computer_Vision/assets/78735911/dc2c71d0-b804-45a1-8530-8b4a2cd61e62">
</div>
H for the Kalman filter is the matrix of the observation model, and for the extended version is the Jacobian matrix of the observation model for the state variables.
input:xp, Pp, H, R ( matrix of the observation noise), z (observation vector of the sensor),h (maps the state variables of the system to the observation model) <br/>
output: xe, Pe <br/>

##  methodology: <br/>
For this task two method was applied, including: <br/>
1- Extended Kalman filter for constant speed movement for
both x and y coordinate axis (GOTO [folder](https://github.com/Afsaneh-Karami/Computer_Vision/tree/main/object%20tracking/extended_kalmanfilter_constant%20speed))<br/>
2- Extended Kalman filter with constant speed movement for
x coordinate axis and constant acceleration movement for y
coordinate axis (GOTO [folder](https://github.com/Afsaneh-Karami/Computer_Vision/tree/main/object%20tracking/extended_kalmanfilter_constant%20acceleration))<br/>
The first method, an extended Kalman filter, the motion
model considered constant velocity. For the second method,
the x and y data were plotted based on the time (dt=0.2), as
shown in the following. For plot x-t, it was so near a linear motion, but for y, it was
near a quadratic function, which means a constant acceleration
motion model. The function of movement (motion model) for
the y direction was created by the poly fit function in Matlab
(quadratic function). The formula was presented below and
depicted in following figure. Based on this function, acceleration is
-4, the initial velocity is 6.9, and the initial y is 6, which were
applied in the initial state matrix. <br/>
y = −2t^2 + 6.9t + 6 <br/>
![x-t Graph](https://github.com/Afsaneh-Karami/Computer_Vision/assets/78735911/55384ca7-f27a-42f5-a731-72f9ae7ff74f)
![y-t Graph](https://github.com/Afsaneh-Karami/Computer_Vision/assets/78735911/b49bed3c-09c4-43f8-84bc-6e980bec0aee)

Some matrixes were used in the Kalman filter and extended Kalman filter with constant velocity motion for both the x and the y direction. <br/>
<img width="500" alt="a" src="https://github.com/Afsaneh-Karami/Computer_Vision/assets/78735911/676ac5ad-e785-4de6-9e29-fc230f4f22f2">
<img width="500" alt="Screenshot 2023-05-17 214615" src="https://github.com/Afsaneh-Karami/Computer_Vision/assets/78735911/5a4647e7-9a29-4703-a7a5-3253428ea6bf">

Some matrixes were used in extended Kalman filters with the constant velocity in the x direction and constant acceleration in the y direction.
<img width="500" alt="s" src="https://github.com/Afsaneh-Karami/Computer_Vision/assets/78735911/31489110-3070-4c5b-b35e-3256902b0c0d">
<img width="500" alt="s1" src="https://github.com/Afsaneh-Karami/Computer_Vision/assets/78735911/c4497b94-ad53-499a-932d-bee053c0fef2">

*  validation gate
In object tracking, a validation gate is used to ensure that
the updated state in the observation model is correct. So, put
the area around the current state (the possible distance the
object can reach indicate the boundary of this area) and accept
the updated state in this area. In this way, avoid incorrect
sensor detection, which can be because of a segmentation
algorithm or similar objects near each other. In object tracking,
the validation gate acts like a filter that rejects any object
detections outside the gate and, if it happens, puts the previous
estimation for it. The advantage of using a validation gate
is that it reduces the tracking error, gives more accurate
results, and avoids drift or false tracks. Choosing the proper
validation gate needs attention; small values lead to track loss
or fragmentation because they reject valid object detections.
A big value allows false tracks or confusion.
The Mahalanobis distance for observation i and target j were
used to calculate the validation gate based on the bellow
formula.
<div align="center">
<img width="500" alt="s2" src="https://github.com/Afsaneh-Karami/Computer_Vision/assets/78735911/250e8f41-ea20-4257-bdff-2c6473785442">
</div>
##  result: <br/>
For comparing the result of each method, errors of noisy
data and real value and the error of estimated data and real
value were calculated. The formula used for error is mentioned
in the following. The Table showed the error result
for noisy data.
<div align="center">
<img width="500" alt="s3" src="https://github.com/Afsaneh-Karami/Computer_Vision/assets/78735911/81c75623-ae73-4461-ab2b-cedaaf5b37ca"><br/>
<img width="500" alt="s4" src="https://github.com/Afsaneh-Karami/Computer_Vision/assets/78735911/61f31061-95ae-4196-8cf3-b27904e11776"><br/>
</div>

Different validation gates were applied, and the best one
with the lowest error was chosen for each method which was
65 for the constant speed motion model in two directions, x
and y, 15 for constant speed in the x direction and constant
acceleration in the y direction. The plots of the validation gate
regarding error are shown in below.After
applying the validation gate, each method’s error decreased
compared to when no validation gate was implemented because unrelated states that happened by the error in
sensor detection decreased. As it is clear in the following Tabel when
the motion model of y-direction changed from constant speed
to constant acceleration, which better matched with data, the
error of estimated state decreased, and the lowest error was for
method second.
* first method:
Figures show the real, observed
and noisy data for constant speed motion in both directions x
and y in two condition validation gates 65 mm and without
validation gate. <br/>
<img width="500" alt="s5" src="https://github.com/Afsaneh-Karami/Computer_Vision/assets/78735911/b74402a5-4fdb-465c-a582-b606a95ce3ef"> <br/>
<img width="500" alt="s6" src="https://github.com/Afsaneh-Karami/Computer_Vision/assets/78735911/f46498f9-62b9-410b-848b-e33117fe59e2">
<img width="500" alt="s7" src="https://github.com/Afsaneh-Karami/Computer_Vision/assets/78735911/a8e26708-9bb2-4ae8-8019-123863c8de09">

* second method:
Figures show the real, observed
and noisy data for constant speed motion in directions x and
constant acceleration y for two condition validation gates 15
mm and without validation gate. <br/>
<img width="500" alt="s8" src="https://github.com/Afsaneh-Karami/Computer_Vision/assets/78735911/c380437d-b464-45a4-ba7b-bbe90db4c97d"> <br/>
<img width="500" alt="s9" src="https://github.com/Afsaneh-Karami/Computer_Vision/assets/78735911/429fd4a4-04b7-4ec8-a06b-1ead82307bb5">
<img width="500" alt="s10" src="https://github.com/Afsaneh-Karami/Computer_Vision/assets/78735911/88d34e1b-df36-40e8-a9d3-1e842c4f63a3">
