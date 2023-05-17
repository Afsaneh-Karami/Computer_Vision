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
* Update function:
<div align="center">
<img width="400" alt="Screenshot 2023-05-17 184524" src="https://github.com/Afsaneh-Karami/Computer_Vision/assets/78735911/dc2c71d0-b804-45a1-8530-8b4a2cd61e62">
</div>
H for the Kalman filter is the matrix of the observation model, and for the extended version is the Jacobian matrix of the observation model for the state variables.
input:xp, Pp, H, R ( matrix of the observation noise), z
(observation vector of the sensor),h (maps the state variables
of the system to the observation model) <br/>
output: xe, Pe <br/>
## methodology and result: <br/>
