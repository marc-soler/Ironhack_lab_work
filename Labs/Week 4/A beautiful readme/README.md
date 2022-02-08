# Using linear regression to predict the insurance claim amount :oncoming_automobile: :blue_car: :truck: :moneybag:
![](Images/Car-Insurance-Claim.jpeg)

## The situation
### Scenario:
We are risk analysts employed at an insurance company. Our team is focusing on the claims our clients make. We are given data from roughly 11.000 of our customers.

### Challenge:
Given a data set, building a machine learning model to find out what features determine the amount claimed by a certain customer, and to what degree.

## The analysis process
The complete analysis is available [here](Final code/customer_analysis_prediction.ipynb).

## Key take aways
- The best performing model, based on their indicators, is actually the base model (Model (X)), with an explained variance of roughly 77% and a mean average error (MAE) of 87.7. Therefore, this model allows us to predict the total claimed amount of a certain customer (as long as its features are similar to the ones in our sample) within a margin of 87.7$.

- Other insights, albeit not very promising, are that a lot of relevant data is missing, and most of the available one barely correlates with the set label.
