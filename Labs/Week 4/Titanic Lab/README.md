# 1. Titanic data EDA
From preliminary Exploratory Data Analysis on the Titanic dataset, we can extract the following observations:
- The features seem to strongly correlate with the label (Survived) the most are passenger class (Pclass), having passengers in first class the highest odds of surviving, gender, having women more chances of surviving, and age, having younger people more frequently survived.
- Good opportunities for feature engineering/extraction are present:
  - The family size of each passenger can be easily computed.
  - The average ticket price paid per family may also be extracted.
  - Titles from the Name feature can be extracted and categorized into few values.
  - Cabin numbers (not very useful, and messy) can be aggregated into decks, that allow for more discrimination.

# 2. Reviewing a random sample of entries in Kaggle Titanic Competition

## I. Kaggle Titanic Competition by JUN IAN LIM
[Link to the entry](https://www.kaggle.com/junianlim/kaggle-titanic-competition)

- **Any feature engineering or feature wrangling methods which you have seen?**  
The creation of 4 new columns (NumCabin, CabinLetter, CabinNum and CabNum), derived from Cabin column.
Transformation of skewed data using natural log.
Dropping missing value for Embarked (2 rows only).
Split of CabinNum due to lack of normality into 4 groups based on 25,50,75 quantiles.

- **Did they impute any missing values?**  
Yes, using the column median on Embarked, Sex and Pclass and 0 for other variables.

- **What about scaling methods for numerical variables?**  
The author is using natural log instead of a normalizer.

- **What about encoding categorical variables?**  
Pandas get_dummies() is called on Sex, Pclass and Embarked columns.

- **Any evidence of overfit or sampling bias?**  
No evidence of that.


## II. Titanic problem by DARIA VASILEVA
[Link to the entry](https://www.kaggle.com/dariasvasileva/titanic-problem)

- **Any feature engineering or feature wrangling methods which you have seen?**  
Imputing NaN's as detailed below, splitting cabins and ticket value in categories, extracting titles from the Names column, creating a FamilySize column adding SibSp + Parch + 1.

- **Did they impute any missing values?**  
Yes, the Age column with median age within the group (possible groups: sex, pclass), the embarked column with the mode of its column, and the Fare column with median value within the pclass.

- **What about scaling methods for numerical variables?**  
MinMax scaler is used.

- **What about encoding categorical variables?**  
The author manually encodes Sex and Pclass (with a dictionary).

- **Any evidence of overfit or sampling bias?**  
No evidence of overfitting.


## III. Titanic Data Science Solutions by MANAV SEHGAL
[Link to the entry](https://www.kaggle.com/startupsci/titanic-data-science-solutions)

- **Any feature engineering or feature wrangling methods which you have seen?**  
Extraction of titles from name and converting to ordinal variable. Dropping useless columns. Age bands created from Age. 

- **Did they impute any missing values?**  
Yes, with the mode in Embarked and with the median in Fare.

- **What about scaling methods for numerical variables?**  
No scaling seems to be performed.

- **What about encoding categorical variables?**  
The author encodes the variable Sex manually (via a dictionary).

- **Any evidence of overfit or sampling bias?**  
The author point out that, while both Decision Tree and Random Forest score the same, he chooses to use Random Forest as they correct for decision trees' habit of overfitting to their training set.


## IV. Titanic using LogisticRegression by DEMKO1
[Link to the entry](https://www.kaggle.com/ahmetcelik158/titanic)

- **Any feature engineering or feature wrangling methods which you have seen?**  
Not much apart from dropped columns ("Name", "Ticket", "Cabin"), filled missing values and basic categorical variables encoding.

- **Did they impute any missing values?**  
Yes, missing values in Embarked are filled with 'None'.

- **What about scaling methods for numerical variables?**  
No scaling methods seem to be applied.

- **What about encoding categorical variables?**  
The author does this manually with a function.

- **Any evidence of overfit or sampling bias?**  
No evidence of overfitting or sampling bias.

## V. A Data Science Framework: To Achieve 99% Accuracy by LD FREEMAN
[Link to the entry](https://www.kaggle.com/ldfreeman3/a-data-science-framework-to-achieve-99-accuracy)

- **Any feature engineering or feature wrangling methods which you have seen?**  
Columns 'PassengerId','Cabin', 'Ticket' are dropped. FamiliSize column is created. Continuous variables such as Fare and Age are split into bins.

- **Did they impute any missing values?**  
Yes. Age is filled with the median, Embarked with the mode, and Fare with median.

- **What about scaling methods for numerical variables?**  
No scaling is performed, probably because most numerical variables are split into bins.

- **What about encoding categorical variables?**  
The author uses pandas method get_dummies().

- **Any evidence of overfit or sampling bias?**  
Cross-validation is used to avoid overfitting, and a depth limit is set to avoid the same effect in the decision tree model.
